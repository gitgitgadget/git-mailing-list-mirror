From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: Using git clone
Date: Sun, 9 Nov 2014 16:24:24 +0100 (CET)
Message-ID: <1094459024.7303740.1415546663657.JavaMail.zimbra@imag.fr>
References: <1415120399.4259.5.camel@precision690.xccg.com> <20141108171539.GB162918@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "Dr. George E. Moore" <gem@x-ctr-l.com>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Nov 09 16:24:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnUM5-0004pH-RG
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 16:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbaKIPYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 10:24:37 -0500
Received: from mx2.imag.fr ([129.88.30.17]:48556 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662AbaKIPYh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 10:24:37 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id sA9FONIi027722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 9 Nov 2014 16:24:23 +0100
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id sA9FOPa4013631;
	Sun, 9 Nov 2014 16:24:25 +0100
In-Reply-To: <20141108171539.GB162918@vauxhall.crustytoothpaste.net>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF33 (Linux)/8.0.6_GA_5922)
Thread-Topic: Using git clone
Thread-Index: vM2fz2yerkkCuzp17h/YTBsYJKfF8g==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 09 Nov 2014 16:24:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: sA9FONIi027722
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1416151464.84488@cNdiO5NdCfIf33ra4fgeXA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

----- Original Message -----
> You generally want to use git fetch or git pull in that case.  git clone
> creates an entirely new copy of the original repository.

Just to complement the answer: "git clone" is more or less a shorthand for "git init" followed by "git fetch" (to get the remote objects) and "git checkout" (to get the actual files). The original poster probably doesn't want the "git init" part here indeed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
