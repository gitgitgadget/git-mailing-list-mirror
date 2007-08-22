From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] Fixed non portable use of expr, and incorrect use of test -eq for string comparison.
Date: Wed, 22 Aug 2007 15:23:59 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070822132359.GA13750@informatik.uni-freiburg.de>
References: <11877841633473-git-send-email-david@olrik.dk> <20070822122140.GB11926@informatik.uni-freiburg.de> <9E40DAA3-69E5-417C-8041-E1980E42DB60@olrik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Jack Olrik <david@olrik.dk>
X-From: git-owner@vger.kernel.org Wed Aug 22 15:24:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INqBy-00012d-VE
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 15:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbXHVNYH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 22 Aug 2007 09:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbXHVNYF
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 09:24:05 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:44465 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750747AbXHVNYD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 09:24:03 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1INqBl-0005qJ-2u; Wed, 22 Aug 2007 15:24:01 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l7MDO0l9013758;
	Wed, 22 Aug 2007 15:24:00 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l7MDNxsj013757;
	Wed, 22 Aug 2007 15:23:59 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	David Jack Olrik <david@olrik.dk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <9E40DAA3-69E5-417C-8041-E1980E42DB60@olrik.dk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56378>

David Jack Olrik wrote:
>=20
> On 22/08/2007, at 14.21, Uwe Kleine-K=F6nig wrote:
>=20
> >David Jack Olrik wrote:
> >>-	if test "`expr index $httpd_only /`" -eq '1' || \
> >>+	if test "`echo $httpd_only | cut -c 1`" =3D '/' || \
> >> 				which $httpd_only >/dev/null
> >
> >I wonder why not use:
> >
> >	if expr "z$httpd_only" : "z/" >/dev/null
>=20
> You'd then need to check against 2 instead of 1, which I find less
> obvious as we are testing for a '/' at the begining of the string.
If I understood the problem right you only need to test for the exit
code, that is the program test is not required at all.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D5%2B7
