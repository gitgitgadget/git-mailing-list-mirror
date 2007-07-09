From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] rerere: record resolution even if file is not in merge base
Date: Mon, 9 Jul 2007 17:32:09 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070709153209.GA19665@informatik.uni-freiburg.de>
References: <20070709070725.GA4445@lala> <7vps32ugu2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707091445450.5546@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 09 17:32:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7vEC-0004JE-0c
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 17:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbXGIPcP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 9 Jul 2007 11:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754545AbXGIPcP
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 11:32:15 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:39904 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754104AbXGIPcO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jul 2007 11:32:14 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1I7vDh-0007G0-Bx; Mon, 09 Jul 2007 17:32:13 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l69FWAh2020884;
	Mon, 9 Jul 2007 17:32:10 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l69FW9TI020883;
	Mon, 9 Jul 2007 17:32:09 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707091445450.5546@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52002>

Hello Johannes, hello Junio,

Johannes Schindelin wrote:
> Two-file merges were rare enough that they were dropped outside of th=
e=20
> radar.  This fix is a trivial change to builtin-rerere.c::find_confli=
ct(). =20
> It is still sane to insist that we do not do rerere for symlinks, and=
=20
> require to have stages #2 and #3, but we can drop the requirement to =
have=20
> stage #1. rerere does not use information from there anyway.
>=20
> This fix is from Junio, together with two tests to verify that it wor=
ks
> as expected.
>=20
> Noticed by Uwe Kleine-K=F6nig.
when I tested Junio's patch and wrote that it doesn't work, I was wrong=
=2E
I just recompiled git-rerere and called that instead of the installed
version.  The problem there was, that merge didn't called the updated.

So:

Acked-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+hertz+in+sec**-1
