From: Jack Adrian Zappa <adrianh.bsc@gmail.com>
Subject: Fwd: diff not finding difference
Date: Thu, 24 Sep 2015 17:09:15 -0400
Message-ID: <CAKepmajegSMO91YZOe+P_BH2kzzR=RMqCE94XRQSfZzOVYKt6A@mail.gmail.com>
References: <CAKepmajSPgGK-DqR3Bxf2Xqxj2Gz0MazRNxM6wsVcSiBQsoE4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git-mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 24 23:09:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDlf-0003gu-AM
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbbIXVJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:09:18 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:36032 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744AbbIXVJR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:09:17 -0400
Received: by lacao8 with SMTP id ao8so77910446lac.3
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 14:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=328XWU/3+qeS9VeMRjjHFhCVn9a9lO5fekfz4C44S5k=;
        b=dPPPMYeRXOkiMIQ0Ju8PuSnYPM63nkz2YPOcLPRkxPAgA8N/GiuOXVlBLqTW8KYzVJ
         GGGWuntmE6LTL38aj0NOCSZrcZTW7w6X2kEPkcWWeuE5OpaTzQN5NVtDKtxRCH98j4gu
         Sy0FIO3Ysc5vodb8ISu3DlBOSiznxYqTT7Cbu4P2upzk/FsOEP6hVXFRXVGdu0CgQlve
         um5XIPcHBS11cKvCF5eiAEqRJ0Yh6Fh/vBj86BGXKFDIaywdqeUtJSR2pHEY9H3EJ0YX
         6Ql+ui/5mdhVDx4RIIN08wSM00nNWuBbVuFQAeCoFE8zzv8jDFnk3ywgzVGXI4KhwuYL
         +i+Q==
X-Received: by 10.112.161.232 with SMTP id xv8mr541785lbb.7.1443128955379;
 Thu, 24 Sep 2015 14:09:15 -0700 (PDT)
Received: by 10.25.139.130 with HTTP; Thu, 24 Sep 2015 14:09:15 -0700 (PDT)
In-Reply-To: <CAKepmajSPgGK-DqR3Bxf2Xqxj2Gz0MazRNxM6wsVcSiBQsoE4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278618>

This is a weird one:

[file-1 begin]

abcd efg hijklmnop

[file-1 end]

[file-2 begin]

blah blah blah
/////////////////////////////////////////////////////////////////////////////////
abdc boo ya!

[file-2 end]

Do a diff between these and it won't find any difference.

Same with the following two lines, each in a different file:
sabc fed ghi jkl
abc def ghi jkl

I first noticed this on the command line git and then in VS2013.  The
original problem was like my first example.  The files were much
longer, but all that git would see is the addition of the line of
////..., but not the removal of the original line.

I've tried some other simple file changes with similar results.
Something seems to be definitely broken in git diff. :(

Command line version of git is 1.9.5 msysgit.0.


A
