From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: 100%
Date: Sat, 23 Jun 2007 12:18:40 +0200
Message-ID: <467CF380.6060603@lsrfire.ath.cx>
References: <20070621030622.GD8477@spearce.org> <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org> <Pine.LNX.4.64.0706211248420.4059@racer.site> <20070621131915.GD4487@coredump.intra.peff.net> <Pine.LNX.4.64.0706220214250.4059@racer.site> <467B777D.C47BFE0E@eudaptics.com> <Pine.LNX.4.64.0706221122200.4059@racer.site> <86ps3oi7ma.fsf_-_@lola.quinscape.zz> <Pine.LNX.4.64.0706221347480.4059@racer.site> <86abusi1fw.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706230222330.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 23 12:19:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I22ho-0007Bz-5U
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 12:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbXFWKS6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Jun 2007 06:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbXFWKS6
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 06:18:58 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:59296
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751990AbXFWKS6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jun 2007 06:18:58 -0400
Received: from [10.0.1.201] (p508E514E.dip.t-dialin.net [80.142.81.78])
	by neapel230.server4you.de (Postfix) with ESMTP id E65263B001;
	Sat, 23 Jun 2007 12:18:53 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
In-Reply-To: <Pine.LNX.4.64.0706230222330.4059@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50727>

Johannes Schindelin schrieb:
> On Fri, 22 Jun 2007, David Kastrup wrote:
>> The people I know will expect "100% identical" or even "100.0%=20
>> identical" to mean identical, period.  They will be quite surprised =
to=20
>> hear that "99.95%" is supposed to be included.
>=20
> Granted, 100.0% means as close as you can get to "completely" with 4=20
> digits. But if you have an integer, you better use the complete range=
,=20
> rather than arbitrarily make one number more important than others.
>=20
> For if you see an integer, you usually assume a rounded value. If you=
=20
> don't, you're hopeless.

Why hopeless?  It's a useful convention to define "100%" as "complete
(not rounded)".  See it this way: 50% of the time, a given percent valu=
e
will be shown as one point less than it's "true" value, but you gain th=
e
ability to indicate full completeness.  And that's an interesting piece
of information.  The price is small given that the needed accuracy is
more in the range of 10 percent points (I assume).

It's more a question of how to make sure everybody knows what the
numbers mean -- but that's why we have a directory named
"Documentation". :-D  And even a person that hasn't read the docs is
unlikely to really get harmed by inexact percentages, right?

Ren=E9
