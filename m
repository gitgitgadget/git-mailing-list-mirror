From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH/RFH] Mark user-manual as UTF-8
Date: Tue, 24 Jul 2007 12:36:31 +0200
Message-ID: <4753DAE3-2F1F-49C0-906A-09CBAF240C87@wincent.com>
References: <7vwswqgs6c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>,
	Thierry Parmentelat <thierry.parmentelat@sophia.inria.fr>,
	"H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 12:37:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDHlX-0007bJ-0r
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 12:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbXGXKgw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Jul 2007 06:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762560AbXGXKgw
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 06:36:52 -0400
Received: from wincent.com ([72.3.236.74]:43166 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757376AbXGXKgv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 06:36:51 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l6OAaZNQ023858;
	Tue, 24 Jul 2007 05:36:37 -0500
In-Reply-To: <7vwswqgs6c.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53561>

El 24/7/2007, a las 9:46, Junio C Hamano escribi=F3:

> There have been several complaints against k.org's user-manual
> page.  The document is generated in ISO-8859-1 by the xsltproc
> toolchain (I suspect this is because released docbook.xsl we use
> has xsl:output element that says the output is ISO-8859-1) but
> server delivers it with "charset=3DUTF-8", and all h*ll breaks
> loose.
>
> This attempts to force UTF-8 on the generating end.

Thanks for doing this, Junio. I was one of the people who reported =20
this (although never saw my mail get through to the list).

=46unnily, enough, about an hour after you posted your patch another =20
email ("git documentation - user manual html version has wierd [sic] =20
characters all over the place") was posted to the list...

Cheers,
Wincent
