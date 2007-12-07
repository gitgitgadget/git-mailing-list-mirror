From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH/RFC (take 3)] autoconf: Add test for OLD_ICONV (squelching compiler warning)
Date: Fri, 7 Dec 2007 09:22:58 +0100
Message-ID: <280C2FED-C7EB-42D1-BB71-1680558C7CBA@wincent.com>
References: <alpine.LFD.0.9999.0712061628070.13796@woody.linux-foundation.org> <1196990840-1168-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Blake Ramsdell <blaker@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Pascal Obry <pascal@obry.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Arjen Laarhoven <arjen@yaph.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 09:23:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0YV1-0007Nx-SU
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 09:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbXLGIXe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Dec 2007 03:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbXLGIXe
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 03:23:34 -0500
Received: from wincent.com ([72.3.236.74]:41330 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750947AbXLGIXd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Dec 2007 03:23:33 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB78MxpM007372;
	Fri, 7 Dec 2007 02:23:00 -0600
In-Reply-To: <1196990840-1168-1-git-send-email-jnareb@gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67397>

El 7/12/2007, a las 2:27, Jakub Narebski escribi=F3:

> Update configure.ac (and config.mak.in) to keep up with git
> development by adding [compile] test whether your library has an old
> iconv(), where the second (input buffer pointer) parameter is declare=
d
> with type (const char **) (OLD_ICONV).
>
> Test-proposed-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

Tested and working here on Mac OS X 10.5.1/Darwin 9.1.0 (where we no =20
longer have an old iconv):

configure: CHECKS for header files
checking for old iconv()... no

Cheers,
Wincent
