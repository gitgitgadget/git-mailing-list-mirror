From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH/RFC] autoconf: Add test for OLD_ICONV
Date: Thu, 6 Dec 2007 20:07:11 +0100
Message-ID: <BCD45527-C564-4CD3-9797-36F6251377E6@wincent.com>
References: <7vd4u5l29v.fsf@gitster.siamese.dyndns.org> <200712051752.28667.jnareb@gmail.com> <52A4CC8B-EB11-4E3F-A3B6-06826F860E5D@wincent.com> <200712052219.00930.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Arjen Laarhoven <arjen@yaph.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 20:09:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0M6F-0004NA-Ql
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 20:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbXLFTHr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Dec 2007 14:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbXLFTHr
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 14:07:47 -0500
Received: from wincent.com ([72.3.236.74]:40153 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754131AbXLFTHq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Dec 2007 14:07:46 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB6J7DnQ025165;
	Thu, 6 Dec 2007 13:07:15 -0600
In-Reply-To: <200712052219.00930.jnareb@gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67323>

El 5/12/2007, a las 22:19, Jakub Narebski escribi=F3:

> Ahhh... now I understand. You have installed new iconv() on your
> computer, and generic 'uname -s' (OS name) based guessing in Makefile
> guesses wrongly that you need OLD_ICONV, while ./configure script
> actually tests it and correctly decides to unset OLD_ICONV !

No, nothing installed. It's that Mac OS X 10.5 (Leopard)/Darwin 9 =20
comes with a newer version of iconv. So while there was no warning =20
prior to Leopard there is one now, which your patch fixes for those =20
using configure.

This came up before here:

<http://marc.info/?l=3Dgit&m=3D119397507006026&w=3D2>

Still, I'd like to fix the warning for those who don't use configure. =20
Have posted a separate patch for that just now.

Cheers,
>

Wincent
