From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH/RFC] autoconf: Add test for OLD_ICONV
Date: Wed, 5 Dec 2007 17:31:23 +0100
Message-ID: <ADB12552-AD67-4781-B194-AD15CA4A7B44@wincent.com>
References: <7vd4u5l29v.fsf@gitster.siamese.dyndns.org> <1196869526-2197-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Arjen Laarhoven <arjen@yaph.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 17:32:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzxAi-0000gJ-Me
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 17:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbXLEQcI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 11:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbXLEQcH
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 11:32:07 -0500
Received: from wincent.com ([72.3.236.74]:37568 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbXLEQcG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Dec 2007 11:32:06 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB5GVOHc026157;
	Wed, 5 Dec 2007 10:31:25 -0600
In-Reply-To: <1196869526-2197-1-git-send-email-jnareb@gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67165>

El 5/12/2007, a las 16:45, Jakub Narebski escribi=F3:

> Update configure.ac (and config.mak.in) to keep up with git
> development by adding [compile] test whether your library has
> an old iconv(), where the second (input buffer pointer) parameter
> is declared with type (const char **) (OLD_ICONV).
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This patch needs checking if it correctly sets OLD_ICONV
> when needed.  I have checked only that it is not set when
> with new iconv() declaration.  Could people using Cygwin
> (and other with OLD_ICONV: Darwin) test it?

Before applying your patch:

     CC utf8.o
utf8.c: In function =91reencode_string=92:
utf8.c:328: warning: passing argument 2 of =91iconv=92 from incompatibl=
e =20
pointer type
     CC convert.o

After applying your patch:

     CC utf8.o
     CC convert.o

This on Darwin Kernel Version 9.1.0 (Mac OS X 10.5.1).

Cheers,
Wincent
