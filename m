From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Fix Solaris Workshop Compiler issues
Date: Thu, 15 Nov 2007 01:17:56 +0100
Message-ID: <20071115001756.GA25021@atjola.homenet>
References: <Pine.LNX.4.64.0711142125460.17530@bianca.dialin.t-online.de> <20071114204732.GE3973@steel.home> <7vprycfrk6.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711150011020.4135@bianca.dialin.t-online.de> <20071114232809.GH3973@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 01:18:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsSR1-0005Wm-V7
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 01:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184AbXKOASD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2007 19:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755890AbXKOASB
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 19:18:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:50340 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754926AbXKOASA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 19:18:00 -0500
Received: (qmail invoked by alias); 15 Nov 2007 00:17:58 -0000
Received: from i577BBF04.versanet.de (EHLO localhost) [87.123.191.4]
  by mail.gmx.net (mp051) with SMTP; 15 Nov 2007 01:17:58 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19m2BghDcZmLO5/vZDZ4+sy90fBbvYXJKHStjufY6
	zmHXrIvCdjwcet
Content-Disposition: inline
In-Reply-To: <20071114232809.GH3973@steel.home>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65027>

On 2007.11.15 00:28:09 +0100, Alex Riesen wrote:
> Guido Ostkamp, Thu, Nov 15, 2007 00:21:55 +0100:
> > The main difference is that the 'struct delta_index' is opaque in d=
elta.h=20
> > and non-opaque in diff-delta.c; the patch clearly shows it solves t=
he=20
> > error. So we've got a solution.
>=20
> It is not the solution. How do you think the rest of Git compiles?
>=20
> > If you feel we could try something else, please let me know and I'l=
l check=20
> > it out.
>=20
> Yes. Read the mail I sent before:
>=20
>     Try removing the "const". Looks like that compiler is too stupid
>     to understand it.

No, just tried with cc: Sun C 5.7 Patch 117837-06 2005/10/05

It's the "struct hack", ie. the incomplete array at the end of
delta_index. Still looking for a fix/workaround.

Bj=F6rn
