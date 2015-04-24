From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: URL not displaying change made with git.
Date: Fri, 24 Apr 2015 15:26:42 +0200
Message-ID: <vpq4mo5d5d9.fsf@anie.imag.fr>
References: <CAKXTx=1g6eBR1hR9vsQohjp2nCjd=gGU=embAzfQhp6JKZNyWQ@mail.gmail.com>
	<vpqoamdellc.fsf@anie.imag.fr>
	<CAKXTx=3HeZ7WzX-4soENvPL1TSomg-xgSMn_-sABMOs1x=yRDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Scott Meyer <dutchlab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 15:26:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yldd6-0007KQ-Uc
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 15:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbbDXN0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 09:26:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58710 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752875AbbDXN0r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 09:26:47 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t3ODQe0Y031354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Apr 2015 15:26:41 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3ODQg8w007973;
	Fri, 24 Apr 2015 15:26:42 +0200
In-Reply-To: <CAKXTx=3HeZ7WzX-4soENvPL1TSomg-xgSMn_-sABMOs1x=yRDg@mail.gmail.com>
	(Scott Meyer's message of "Fri, 24 Apr 2015 08:59:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 24 Apr 2015 15:26:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3ODQe0Y031354
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1430486802.47444@sDv2Mfx1w+riD07A9uO8oQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267739>

[ Please, don't top-post on this list ]

Scott Meyer <dutchlab@gmail.com> writes:

> The site is local to my laptop.  I am attempting to establish a
> development environment where I can view and test changes before
> moving to production.

OK, so you're doing web development, right?

Then, the problem is unrelated from Git: your webserver looks at files
on disk, not at the Git repository (i.e. whether your changes are staged
in the index, commited, or totally outside Git does not change the
result). My guess would be that you have two clones of the same project.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
