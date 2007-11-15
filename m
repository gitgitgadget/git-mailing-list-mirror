From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Fix Solaris Workshop Compiler issues
Date: Thu, 15 Nov 2007 01:50:11 +0100
Message-ID: <20071115005011.GC25021@atjola.homenet>
References: <Pine.LNX.4.64.0711142125460.17530@bianca.dialin.t-online.de> <20071114204732.GE3973@steel.home> <7vprycfrk6.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711150011020.4135@bianca.dialin.t-online.de> <20071114232809.GH3973@steel.home> <20071115001756.GA25021@atjola.homenet> <7v3av89wq7.fsf@gitster.siamese.dyndns.org> <20071115004404.GB25021@atjola.homenet> <7vy7d08her.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 01:50:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsSwC-0007dL-TU
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 01:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920AbXKOAuQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2007 19:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755237AbXKOAuQ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 19:50:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:47423 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754642AbXKOAuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 19:50:14 -0500
Received: (qmail invoked by alias); 15 Nov 2007 00:50:12 -0000
Received: from i577BBF04.versanet.de (EHLO localhost) [87.123.191.4]
  by mail.gmx.net (mp002) with SMTP; 15 Nov 2007 01:50:12 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19Ohlojc2VO4uxbtntzMZQoPwkqiBIPahZmJ720NI
	RvC8KusY8bSZai
Content-Disposition: inline
In-Reply-To: <7vy7d08her.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65036>

On 2007.11.14 16:46:20 -0800, Junio C Hamano wrote:
> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>=20
> > On 2007.11.14 16:30:08 -0800, Junio C Hamano wrote:
> >
> >> Maybe your compiler needs -DFLEX_ARRAY=3D0 in CFLAGS?
> >
> > Actually, I just created a test-case remotely on a Solaris box in m=
y
> > university (see below) and didn't compile the actual git code. With=
 the
> > FAM, cc complains about a redeclared identifier, with a zero-sized
> > array, it complains that an array cannot be zero-sized...
>=20
> I think you can pass -DFLEX_ARRAY=3D1 as a workaround.  It would
> waste one array member in a flexible structure but that is
> better than compiler choking.

Yeah, that at least compiles (didn't do any further tests), forgot to
say that in the last email.

Bj=F6rn
