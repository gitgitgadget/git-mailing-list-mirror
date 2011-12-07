From: Chris Patti <cpatti@gmail.com>
Subject: Re: Odd issue - The Diffs That WILL NOT DIE.
Date: Wed, 7 Dec 2011 13:16:30 -0500
Message-ID: <CAJ8P3RC5DemBCvQxGgejtfy1oA7dF6QheTsEbobP_Tchayqyug@mail.gmail.com>
References: <CAJ8P3RBm=RhNf6LKLqprqX6Rqx0OgRnJR+=+-Qhg4PvpeqaUDg@mail.gmail.com>
	<20111206215102.GA3654@centaur.lab.cmartin.tk>
	<CAJ8P3RCPt9Kwi1F7_TEkZQhkm1mwR_TFKhYszS5LL50kXU8oNQ@mail.gmail.com>
	<CAGK7Mr7z6hqoda=pr3syzC5mO1+ZExMeD7sReeyRaYL5OMhemw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 19:16:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYM2n-0006zz-CO
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 19:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757334Ab1LGSQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 13:16:33 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:57447 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756855Ab1LGSQc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 13:16:32 -0500
Received: by wgbds13 with SMTP id ds13so2027873wgb.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 10:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=De4HShO4nzwPLHIWkVghHVqxq8SKvlS+rrR7lJgchXo=;
        b=xQc14QSN77bsDcIsPPsH62rdFMioYB/zwBIRP24Hc/ABVIKYsbvy6IsCmZuhcHIvyt
         Beb1/iPVEeoSFFmRMrOUlgt8MujsjwcRRWfnbaDKHFNMFe6FeBzQYu+OITOLhvYMruG/
         JotYGx+SJZpfDXM7raJoeDKacjXLgwwaIVsMg=
Received: by 10.180.19.42 with SMTP id b10mr31739547wie.39.1323281790679; Wed,
 07 Dec 2011 10:16:30 -0800 (PST)
Received: by 10.223.88.132 with HTTP; Wed, 7 Dec 2011 10:16:30 -0800 (PST)
In-Reply-To: <CAGK7Mr7z6hqoda=pr3syzC5mO1+ZExMeD7sReeyRaYL5OMhemw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186479>

On Wed, Dec 7, 2011 at 12:20 PM, Philippe Vaucher
<philippe.vaucher@gmail.com> wrote:
>> 11:35][admin@Hiram-Abiff-2:~/src]$ rm -rf framework/
>> [11:44][admin@Hiram-Abiff-2:~/src]$ git clone
> ...snip...
>> [11:51][admin@Hiram-Abiff-2:~/src]$ cd framework/
>> [11:51][admin@Hiram-Abiff-2:~/src/framework(master)]$ git diff
> ...snip...
>
> Can you paste the output of "git status" right after the "cd framework"?
>
> Looks like you have some external process that goes and touches your
> file after the git clone, or that git fails to check out the files
> after cloning but isn't able to work out it failed to checkout those
> files.
>
> Philippe


FYI this behavior persists across reboots so this rogue process is
also restarting itself :)

Thanks,
-Chris


-- 
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, Pixar
