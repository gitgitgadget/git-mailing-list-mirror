From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: Fix UTF Encoding issue
Date: Tue, 4 Dec 2007 09:20:21 +0100
Message-ID: <20071204082021.GE31042@auto.tuwien.ac.at>
References: <4753D419.80503@clearchain.com> <47547930.5070603@clearchain.com> <20071204080407.GC31042@auto.tuwien.ac.at> <200712041012.50935.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benjamin Close <Benjamin.Close@clearchain.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org,
	Perl Unicode Mailing List <perl-unicode@perl.org>,
	Dan Kogai <dankogai@dan.co.jp>
To: Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Tue Dec 04 09:20:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzT1K-0007JU-Td
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 09:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbXLDIU1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2007 03:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbXLDIU1
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 03:20:27 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:56194 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbXLDIU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 03:20:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id B14F68AFEF4D;
	Tue,  4 Dec 2007 09:20:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DR3yCDU-xD-f; Tue,  4 Dec 2007 09:20:21 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 5936D8C06799; Tue,  4 Dec 2007 09:20:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200712041012.50935.ismail@pardus.org.tr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67018>

On Tue, Dec 04, 2007 at 10:12:50AM +0200, Ismail D=F6nmez wrote:
> I think just a better method is to use (not tested):
>=20
> if( is_utf8($str) )=20
> {
> 	return decode_utf8($str);
> }
> else {
> 	return decode($str);
> }

I already tried this function. It does not test, if a string is
really UTF-8. It seems to be to intended to check, if perl stores
the string internally in a multi byte encoding.

mfg Martin K=F6gler.
