From: Steven Penny <svnpenn@gmail.com>
Subject: Build without BUILT_INS
Date: Mon, 23 Apr 2012 21:19:44 -0500
Message-ID: <CAAXzdLVbqp-_9A+BwcOuiHi3A39gAJb7_NqANfhAfuK9-+iZ0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 04:19:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMVM8-0004FN-3j
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 04:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756417Ab2DXCTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 22:19:45 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44123 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756355Ab2DXCTo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 22:19:44 -0400
Received: by iadi9 with SMTP id i9so296361iad.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 19:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ZZTDaWnAwawSHRI5v7srODoxlft0DR8QIyszW/YRxf8=;
        b=ut+Lfw08lZyGvdEPCir5MCf8bmzQE7FWMm0Ussk/WPE0QsZuv9u1Jzt+5sTlSAkpLJ
         V1Tn8ugBAB7ptFtTH31l+djpydtYG5KocuGxI93nDn3d+6ByubuvE8mERrOFvgW5qcIA
         I8OPHSxKtfR90CbUN+AXCKmpOXDwUA25ssJmmowbnu3OgfWVGxjlPcQ7NzrVMyycjJ9f
         1CeqAcr67SUXAZ7chLgwBa3xyEcyJMn94d2RQO6QubaTjzQJWld5kERPOM+0d/jPKLiC
         tCrBeC6N1vXzbS5wNO3/eQP/ORvkBwj/f/9I91C1NlOR+Moa/OLQeZg0cNmH5HMyu92Z
         F7NQ==
Received: by 10.50.169.65 with SMTP id ac1mr8308071igc.54.1335233984432; Mon,
 23 Apr 2012 19:19:44 -0700 (PDT)
Received: by 10.231.80.147 with HTTP; Mon, 23 Apr 2012 19:19:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196179>

I would like to build Git for Windows without the hard links in libexec/git-core

I tried doing

make install prefix=/c/git BUILT_INS=

and I get this error

install git.exe git-upload-pack.exe git-receive-pack.exe
git-upload-archive.exe git-shell.exe git-cvsserver '/c/git/bin'
install: cannot stat `git-receive-pack.exe': No such file or directory
install: cannot stat `git-upload-archive.exe': No such file or directory
make: *** [install] Error 1

Is there a way to build Git without the built-ins?

Some discussion here

http://github.com/msysgit/git/pull/4
