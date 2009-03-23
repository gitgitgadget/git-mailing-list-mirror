From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Re: git svn teething problems - initial clone okay - fetches not working
Date: Mon, 23 Mar 2009 20:02:25 -0000
Message-ID: <A8BADC6827F1425795889EC684D1C75C@HPLAPTOP>
References: <2BACA6CC2F9647C19C0463120219E694@HPLAPTOP> <c115fd3c0903231243n1cddf1f1ra88b00ca8db83044@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Tim Visher" <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 21:04:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlqNT-0008R7-Eb
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 21:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756906AbZCWUCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 16:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756383AbZCWUCh
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 16:02:37 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:40370 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755034AbZCWUCg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 16:02:36 -0400
Received: by ewy9 with SMTP id 9so1798407ewy.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 13:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:cc
         :references:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        bh=LbIE2QajkKyVr6bu/KPU5szQe/BkIpa7JUFCAxPVfQk=;
        b=r9pO6oSNh3vM0bYbLJYSm0b/ihPs8epphFrPM080R6GRBQnoCTUxYafJpvHO/QlOJd
         qWijLAYWy6cD2duCcmFSTKlaZlBQvzihkseUmnssMFQnp6FS5TYb/KjRSyK1r7AQ5ixb
         t446QlW1+2CucDgPQJ9BkcU6+ZOQrTFsmaViU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:cc:references:subject:date:mime-version
         :content-type:content-transfer-encoding:x-priority:x-msmail-priority
         :x-mailer:x-mimeole;
        b=RoC/IzPOqGq8plesWpCfTb7kdCORUWZvbLm/lM+n4uXB0Zdczq7yxpb8jEo4P0kcXU
         SswTSm71nAeDMeE/qUnhfpKnEzQ/IGt/xNeUHjHRHkHrMfYV/IITGyJosiRo7cSVSsCP
         J40GJknIggSQQR2qwjGhZkYGhzF0Y0ZGPlsjE=
Received: by 10.216.25.82 with SMTP id y60mr2816576wey.4.1237838552838;
        Mon, 23 Mar 2009 13:02:32 -0700 (PDT)
Received: from HPLAPTOP (aarongray.demon.co.uk [80.177.163.94])
        by mx.google.com with ESMTPS id i3sm5574085nfh.33.2009.03.23.13.02.30
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 13:02:32 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114346>

>I had a lot of success when I was more actively using `git svn` with
>`git svn rebase`.  Just be sure that you're doing your work in local
>branches and then merging back into the main trunk branches that are
>tracking the svn repo, that way you can always get the latest changes
>from your clean trunk branch.

I tried a rebase and filenames with 'needs update' after them flew by then 
an error message  :-

update-index --refresh: command returned error: 1

Aaron

On Mon, Mar 23, 2009 at 3:30 PM, Aaron Gray
<aaronngray.lists@googlemail.com> wrote:
> Hi,
>
> I am a newbie to git, so be warned :)
>
> I have installed git-daemon, and gitweb on an F10 server.
>
> Basically managed to do a 'git svn clone' on LLVM, it took 11 hours !
>
> Anyway I am having the problem that I can do a 'git svn fetch' and I see
> changes coming in. But the gitweb and another git clone from it do not
> reflect those changes. The repository is still showing its two days old.
>
> I am obviously missing something. The only documentation I could find on
> 'git svn' was the command line help and 'man git-svn'.
>
> Hope you can help,
>
> Aaron
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
>



-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail 
