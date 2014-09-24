From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Specifying account profile in MSMTP
Date: Wed, 24 Sep 2014 11:52:51 -0500
Message-ID: <CAHd499C5FZietAxQYBFwk+Zm0AeLWSADog7+=W0Fnm6G1sPSHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 24 18:52:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWpoH-00018E-Fz
	for gcvg-git-2@plane.gmane.org; Wed, 24 Sep 2014 18:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250AbaIXQwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2014 12:52:53 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:40396 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbaIXQww (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2014 12:52:52 -0400
Received: by mail-vc0-f178.google.com with SMTP id lf12so4543711vcb.37
        for <git@vger.kernel.org>; Wed, 24 Sep 2014 09:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=b1gRPin4CCd8/o8dHhtzeezf2+a5xNHasM8bFdcIbSQ=;
        b=QtqzkEk8iA+PtjuFU2gIfVbevMUSJgT8Ap4SxRIjWjJGqK5VBze+w4vQyOLmjsXQwy
         0MYrf/10vNCnEj4BNGEmqDrjTS7Jgzwdevgu3Q7iu/ORRIxiyKXEWL3385d4RmHJFBoB
         bAQYdn2HuvtLQjKquQpiwxhcNPcB5FW1smkuez3d9nVvMFznqnnHFDNBEdrWYQacieiM
         4yWOqN/InA2LBbGV4TtyH7jBxsjAf/e0LY0zi4vLpficsUWXe6U80F84jNroztxzhFQ+
         Ovp3JsZqS4aavXzdzlqVN6ujGAex5AqfijJ8fCYdBGgWxwG6NNzmeNtVkq5vRIoyL3w6
         mXRg==
X-Received: by 10.220.69.210 with SMTP id a18mr6822344vcj.67.1411577571836;
 Wed, 24 Sep 2014 09:52:51 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.3.200 with HTTP; Wed, 24 Sep 2014 09:52:51 -0700 (PDT)
X-Google-Sender-Auth: gFxVAR4SMm1NOlBcG_BNGaclhSQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257461>

Hey guys,

I'm using MSMTP to define 2 accounts: Work email and personal email.
If I send patches via email through Git at work, I want to use my work
SMTP server and account information. Likewise at home for personal
projects, I want to use my personal SMTP account.

I put my .gitconfig in Dropbox and I share it across all of my
machines, so I avoid putting my SMTP server information in my global
config because I'd then have to use the same account everywhere.
However, I do not define a "default" account in my MSMTP file (which
is also in dropbox, in fact my whole home directory is in there).

Is there a way to specify the MSMTP account to use at the command line
when I run `git send-email`? If not, are there other good solutions to
this problem?

If not, I might contribute an option to send-email to feed down into
MSMTP.exe so that I can specify the account to use. I'm not familiar
at all with MSMTP so I want to ask here first. Thank you!
