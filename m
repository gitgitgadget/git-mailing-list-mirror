From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: git-cherry doesn't detect a "copied" commit
Date: Fri, 23 Oct 2015 08:47:56 +0200
Message-ID: <CAC9WiBgkv+nu1YX+zaxigG9FWppDJ19f7d2gm_7H9wosHSV_Yw@mail.gmail.com>
References: <CAC9WiBhM4edBFCYx35xZJB79AZWo49mkO-Pxnb1q4aLDmBufWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 23 08:48:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpW8v-0005Ls-4M
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 08:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbbJWGr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 02:47:57 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:35715 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbbJWGr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 02:47:56 -0400
Received: by iofz202 with SMTP id z202so115005752iof.2
        for <git@vger.kernel.org>; Thu, 22 Oct 2015 23:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=VYLIMPcwHphgjYzyasRP4rwGHFc1fSfUgcbYVtu7xKE=;
        b=nZPUGgAdLuH/A6ZGrL/1MbOvoym6LmLjrks7QPUdneyAYQV8wkd92eWFxvyUV52w04
         pRc34uBX4aDVWlCGsSfVccMywQQqiRn0inpTQehZDul4YVJLr+aL0/KD5bejwFxkOvT6
         cnYAdX6xYlBWc7T3YOqaLHkUsm7Y5lVgvznF6kNQZgRvUeRACvJ1y8pcfEtgZ2yHjh0q
         BtR83lPbpLL2U884DpQJpVDv34XKsBP9YQLVBanrFLKISQtHSzkICpDLtvW7ZmbTgpNo
         z+tg9y8WXekeNCmnN+zhmVILq7Vwcj4WM5fMpulP+J3eYMXrJt/PJpKexEGA4FuLU8St
         S/Hw==
X-Received: by 10.107.46.228 with SMTP id u97mr19529020iou.165.1445582876060;
 Thu, 22 Oct 2015 23:47:56 -0700 (PDT)
Received: by 10.79.77.1 with HTTP; Thu, 22 Oct 2015 23:47:56 -0700 (PDT)
In-Reply-To: <CAC9WiBhM4edBFCYx35xZJB79AZWo49mkO-Pxnb1q4aLDmBufWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280086>

Hi,

On Tue, Oct 20, 2015 at 6:32 PM, Francis Moreau <francis.moro@gmail.com> wrote:
> Hi,
>
> I'm seeing something odd with git-cherry: it doesn't seem to detect
> that a commit has been cherry-picked from master branch.
>
> This happens with the systemd git repository (from github) so it
> should be fairly simple to reproduce.
>
> What I did:
>
> $ git --version
> git version 2.6.0
> $ git checkout -b foo v210
> $ git cherry-pick -x 9ea28c55a2488e6cd4a44ac5786f12b71ad5bc9f
> $ git branch --contains 9ea28c55a2488e6cd4a44ac5786f12b71ad5bc9f
> master
> $ git cherry master HEAD
> + fef60bf34d1b372bea1db2515a8d936386dfc523
>
> so git-cherry tells me that the cherry-picked commit has not
> equivalent in master, which is no the case.
>
> What am I missing ?
>

Could anybody give me a hint even if I'm blind and not seeing my
stupid mistake ?

Thanks
-- 
Francis
