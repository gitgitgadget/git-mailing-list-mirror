From: jaseem abid <jaseemabid@gmail.com>
Subject: Need help to complete the proposed gsoc 2012 project
Date: Wed, 1 Aug 2012 00:59:03 +0530
Message-ID: <CAH-tXsByoeEWA0MZHp-xvJCpRZEXQT6G3M_MJYy+HwauW0ci0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 21:29:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwI8c-0005OU-Rb
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 21:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab2GaT3p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Jul 2012 15:29:45 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53370 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab2GaT3o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2012 15:29:44 -0400
Received: by wibhm11 with SMTP id hm11so3239562wib.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 12:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tXQOcWtFIpsH93jPq2rn/3qN9LThcK4a3fn0Fv7IEqs=;
        b=hMfqVRBtAEHZkGH7hiP0JwCRAa7HfcwVbRgAMXwB6oB1cUtz0IKAFW/r9921MxR/ha
         lsUTxMtlOGBbJtCj5qgOBRpMMDmEdoLY4gx1I/VvqGU9SaGsKU/sF//dnSNLTp/HCX/k
         fiOeInOGL72ES2uUvtGp4+6JaVeYoQlGmSG02xzlg3u1VJQmpDMQoyIb1mMbVjFrNjJo
         4rNW19QwwZjIpZfKZd+teFp4RwTfkuL2MihuDH0g3DdGl3xdqrbsIWOOvESQ5qFIQ+m3
         SuIMGJ8xAhA5Sx1HXX4FvCApdISuIBPdma2IFAGFCG3Ga5XDDIu11bRKgoxHIsuqAutT
         uwzA==
Received: by 10.180.81.193 with SMTP id c1mr5197464wiy.12.1343762983373; Tue,
 31 Jul 2012 12:29:43 -0700 (PDT)
Received: by 10.227.30.133 with HTTP; Tue, 31 Jul 2012 12:29:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202674>

Dear list,

Project					: Use JavaScript library / framework in gitweb
Project Description		        : https://github.com/peff/git/wiki/SoC-201=
2-Ideas
Code 					: https://github.com/jaseemabid/git/commits/gitweb

	The project was proposed by Jakub Nar=C4=99bski for GOSC 2012 but was =
not taken
up because git didn't get enough slots from Google. I almost completed =
the work
and now I am stuck at a stage where I cant move forward without some he=
lp from
the community. Jakub and Andrew Sayers used to help me but they are bus=
y with
their own work and are not available.

	The JavaScript in gitweb was re-implementing a lot of features which a=
 lot
of common libraries did a several times already. For example, sending a=
n Ajax
request or DOM manipulation required different code in different browse=
rs. The
project aims to clean up the JavaScript using such a library. As of now=
, I have
ported all of the existing features to a cleaner version using JQuery, =
and I am
ready to work on more features if required.

	I have also added tests for JavaScript which didn't exist before using=
 mocha
BDD testing framework, which can be run in both console with node.js pr=
oducing
TAP formatted output and in browsers. I have not introduced any UI chan=
ges. The
old CSS was used without modifications. Code quality was taken into goo=
d
account. All code is JSLint valid now.

Here is the detailed project status, todo, known bugs and commit notes =
:
https://gist.github.com/3218461

Any help will be greatly appreciated.

Regards,

Jaseem Abid
http://jaseemabid.github.com
