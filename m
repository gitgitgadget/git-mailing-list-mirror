From: "Aubrey Li" <aubreylee@gmail.com>
Subject: git clone problem
Date: Tue, 3 Apr 2007 13:56:13 +0800
Message-ID: <6d6a94c50704022256t305c964eq45cc4189dcf20c27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 07:56:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYc0A-00017l-AY
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 07:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbXDCF4P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 01:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173AbXDCF4P
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 01:56:15 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:46502 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbXDCF4O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 01:56:14 -0400
Received: by an-out-0708.google.com with SMTP id b33so1531861ana
        for <git@vger.kernel.org>; Mon, 02 Apr 2007 22:56:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YNNgY22dUylbqCx60szR609G2hOMDaaVOH3huPExSzHZMR6GJkiUc8c/bVAxMYV3gg2X1alRMJtcJ+WJ1kumsSWyCbvb/HTtZF6VvEo39imKx+VudYauo0DClkJJSaJ7n2Eyq5jBjh7vxiefVs3gnbggQeg8+fR0TPGlu9CoBd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FrDUOCAXaUKaRrLTgaVeaokzq+p4EANWF1vqStViQ1wP5kiB7MVWicnDKOtanQw+hF+xVjQeL7pDTtnpAcaKkIH5ee44eLTPrHjyC5dmt5t6B7lAU7xpS/Oalda1usGG9hsHo3+c1cwpH0ehoPHuMvz1K1jlcCluQSBg3zHuF9g=
Received: by 10.114.113.1 with SMTP id l1mr2106147wac.1175579773584;
        Mon, 02 Apr 2007 22:56:13 -0700 (PDT)
Received: by 10.114.146.8 with HTTP; Mon, 2 Apr 2007 22:56:13 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43618>

Somehow I can't clone a git repository any more through http, which I
can do it before. Git clone always hangs at the same commit-ID,
without any error, warnings.
Please help, thanks.

Best Regards,
-Aubrey

=============================================
aubrey@ubuntu-feisty:~/upstream-uboot$ git-clone
http://www.denx.de/git/u-boot-blackfin.git

----snip----
walk d2c83f549378fb3fc34cb3c2e62fd772fbf8b68b
got b2e8b3c69774357044f39186a10cf1542bde6be5
got 2da827b326038662feb6f28cb0f9a3d86cef6b2e
got f9741f4fc9f4b1165c58d76dc58e0593808b84e5
got eb62a0abe8bdea88c563380c302a88fa64eff151
got 620d3c9a14affca29a5c4e575e9f355c2bd4aed2
got 58e3b14c18ed3288ceef8d086946dbf3df64ccf2
got 0612ed5872dbec0736e779eb28748af04c0d4f1c
walk 620d3c9a14affca29a5c4e575e9f355c2bd4aed2
walk 4decd84e8f04279c5cfff7f8e907465ef8d8a3fb
walk 58e3b14c18ed3288ceef8d086946dbf3df64ccf2
walk e59581c56ab5d6e0207ddac3b2c1d55cb36ec706
walk dae80f3caf9754a6dd3ddf3cf903d0c46cbd4385
walk e4c2d37adc8bb1bf69dcf600cbc6c75f916a6120
walk 1954be6e9c9421b45d0a9d05b10356acc7563150
walk fae684e89844856383bdf101440889557df3e6b1
walk 4e26f1074c3ac1bd8fd094f0dc4a1c4a0b15a592
walk 1aa934c81b77f2080d3ca4b226eab67b17a33961
walk 4f4b602ec7524a032bdf3c6d28c7f525a4a67eaa
walk 1729b92cde575476684bffe819d0b7791b57bff2
got 3ab1a99fbc6527441b6932b20d3e0a262a9d5fdb
got a6c834c3ece23487b4f744bfc516c78aab800117
got 4be23a12f23f1372634edc3215137b09768b7949
--------hang here--------
