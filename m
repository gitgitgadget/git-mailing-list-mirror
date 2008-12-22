From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: push to backup repo periodically fails with "not fast forward"
Date: Mon, 22 Dec 2008 19:11:00 +0200
Message-ID: <94a0d4530812220911l37b825edj55178658f24755c1@mail.gmail.com>
References: <19016122-e19d-4885-8b0f-dec7b686c6ea@o4g2000pra.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: davetron5000 <davetron5000@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 18:13:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEoKW-0006Pf-8Z
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 18:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbYLVRLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 12:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbYLVRLF
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 12:11:05 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:39368 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbYLVRLE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 12:11:04 -0500
Received: by bwz14 with SMTP id 14so8385526bwz.13
        for <git@vger.kernel.org>; Mon, 22 Dec 2008 09:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AlSyykmI4wc4i25eDigpH5ScjlXKm6fFOs9xHVbEGCM=;
        b=wNVDSlaThyxBu0v3vzPF2xtbmTRIbMTVByDrThE/2XTCKi9Iy5eojCOarzOlLom2zn
         kpIFyuj38UsVaook2+1Y/xW4W/3OprQWfAn8XnOxl12wlKDdxLbNFxQsuOOIfdYHoPm1
         o8jU+sNVJQJEVOrS/56LUeD/TbIZPP3snhLj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Vk3K1I/iD9B5kBezzJmTMewGbh/FY3t8MYrhmL9aBomIPdwL2eOafMSSlTZTdgrEbL
         g5yaVEOBt5q0n45pqHEY1fLbIlG62qOTxsSkHTeIm6Y65tyY3N+7W3CdXTWvCdWUlipl
         AdN60Brgf37oMySN/VDxhHIveGDz37rRJ1X5Y=
Received: by 10.181.240.10 with SMTP id s10mr2386105bkr.108.1229965860890;
        Mon, 22 Dec 2008 09:11:00 -0800 (PST)
Received: by 10.181.148.10 with HTTP; Mon, 22 Dec 2008 09:11:00 -0800 (PST)
In-Reply-To: <19016122-e19d-4885-8b0f-dec7b686c6ea@o4g2000pra.googlegroups.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103760>

On Mon, Dec 22, 2008 at 6:24 PM, davetron5000 <davetron5000@gmail.com> wrote:
> I have a repo on another disk that I ONLY use to backup my in-use
> local repo.  I have a post-commit hook that does the push (git push --
> all remote-repo-name)
>
>>git commit -a -m 'some change'
> Counting objects: 71, done.
> Compressing objects: 100% (26/26), done.
> Writing objects: 100% (29/29), 2.31 KiB, done.
> Total 29 (delta 12), reused 0 (delta 0)
> Unpacking objects: 100% (29/29), done.
> To file:///Volumes/Git/pose/main
>   22d7f10..0037aaf  bimonthly-frequency -> bimonthly-frequency
>  ! [rejected]        master -> master (non-fast forward)
> error: failed to push some refs to 'file:///Volumes/Git/pose/main'
> Created commit 0037aaf: Removed assertion that made no sense.
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> I'm using git as a front-end to Subversion, but I can't figure out why
> this is happening.
>
> The repo at /Volumes/Git/pose/main is NEVER pulled from or pushed to
> by anything other than my hook.  I can't understand why any push to it
> would NOT be a fast-forward.
>
> Any ideas how I can figure out what's going on?

Do you rebase your original repo?

-- 
Felipe Contreras
