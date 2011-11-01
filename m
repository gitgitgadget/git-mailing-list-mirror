From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: git-p4: problem with commit 97a21ca50ef8
Date: Tue, 1 Nov 2011 15:50:31 +1100
Message-ID: <CAOk9v+_xXRGAGWg2L5u=r9qBS=H+ZmdF=TwumSyq7WKf-15okw@mail.gmail.com>
References: <CAOk9v+-==GwDQaZ=4BW1QfEF7+5SfhNF409Xom0bHdT_qKaiFA@mail.gmail.com>
 <20111101020841.GA8116@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Pete Wyckoff <pw@padd.com>, Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Nov 01 05:51:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RL6Jk-0002Yd-Qd
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 05:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437Ab1KAEvP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Nov 2011 00:51:15 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49988 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab1KAEvO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2011 00:51:14 -0400
Received: by eye27 with SMTP id 27so5947009eye.19
        for <git@vger.kernel.org>; Mon, 31 Oct 2011 21:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=K2jrk0oWqo0cwc97ZPDCUfZDXzi9yy5fgh4HlQDjVTo=;
        b=LURs+ZDsJgyIIbdAvl1B55L0Yn636eT7cN7sbEI/+ShRUuOHgEqCEf7bhzFxUu6ULn
         enP1y2FA28CkB0Rh4hWNt/4CPKVrTRteqwU2D+2/0oPfxwHFbkO9YeHRi2L5xd+BoSbf
         CJOSItQQLLI6ubZRFCeL0rPOkgAybvndr0o0U=
Received: by 10.213.33.210 with SMTP id i18mr21812ebd.25.1320123072156; Mon,
 31 Oct 2011 21:51:12 -0700 (PDT)
Received: by 10.213.17.209 with HTTP; Mon, 31 Oct 2011 21:50:31 -0700 (PDT)
In-Reply-To: <20111101020841.GA8116@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184556>

> Would it be good if git-p4 understood how to identify and create
> AppleDouble files on Mac? =C2=A0If yes, eventually, we can revert the
> commit and explain how this feature doesn't quite work yet.
> Even if no, it seems like we should revert and complain that
> this apple support is broken.

I've used git-p4 for many years, and have always had to work around
the limitation of the "apple" filetype and the resulting lack of files
added to the git repo.

Of course, I'd love to have git-p4 work seamlessly for this scenario.
Even Perforce have a KB article on the limitation of the "apple"
filetype with git-p4:

  http://kb.perforce.com/article/1417/git-p4

At least with 97a21ca50ef8 reverted, there is a warning that files
will be missing. The current behaviour results in a git repo with
unusable files without any warning whatsoever. I think having unusable
files, and without warnings, is worse as there is no indication that
there is a problem with files in the working tree.
