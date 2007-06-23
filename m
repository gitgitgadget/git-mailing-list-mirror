From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: 100%
Date: Sat, 23 Jun 2007 13:41:08 +0200
Message-ID: <467D06D4.9050203@lsrfire.ath.cx>
References: <20070621030622.GD8477@spearce.org> <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org> <Pine.LNX.4.64.0706211248420.4059@racer.site> <20070621131915.GD4487@coredump.intra.peff.net> <Pine.LNX.4.64.0706220214250.4059@racer.site> <467B777D.C47BFE0E@eudaptics.com> <Pine.LNX.4.64.0706221122200.4059@racer.site> <86ps3oi7ma.fsf_-_@lola.quinscape.zz> <Pine.LNX.4.64.0706221347480.4059@racer.site> <86abusi1fw.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706230222330.4059@racer.site> <467CF380.6060603@lsrfire.ath.cx> <Pine.LNX.4.64.0706231154300.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 23 13:41:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I23zb-00018v-3m
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 13:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbXFWLlV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Jun 2007 07:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753937AbXFWLlV
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 07:41:21 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:40919
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753899AbXFWLlU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jun 2007 07:41:20 -0400
Received: from [10.0.1.201] (p508E514E.dip.t-dialin.net [80.142.81.78])
	by neapel230.server4you.de (Postfix) with ESMTP id 2F7903B001;
	Sat, 23 Jun 2007 13:41:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
In-Reply-To: <Pine.LNX.4.64.0706231154300.4059@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50732>

Johannes Schindelin schrieb:
> Hi,
>=20
> On Sat, 23 Jun 2007, Ren=E9 Scharfe wrote:
>=20
>> Johannes Schindelin schrieb:
>>> On Fri, 22 Jun 2007, David Kastrup wrote:
>>>> The people I know will expect "100% identical" or even "100.0%=20
>>>> identical" to mean identical, period.  They will be quite surprise=
d to=20
>>>> hear that "99.95%" is supposed to be included.
>>> Granted, 100.0% means as close as you can get to "completely" with =
4=20
>>> digits. But if you have an integer, you better use the complete ran=
ge,=20
>>> rather than arbitrarily make one number more important than others.
>>>
>>> For if you see an integer, you usually assume a rounded value. If y=
ou=20
>>> don't, you're hopeless.
>> Why hopeless?  It's a useful convention to define "100%" as "complet=
e
>> (not rounded)".
>=20
> By the same reasoning, you could say "never round down to 0%, because=
 I=20
> want to know when there is no similarity".
>=20
> You cannot be exact when you have to cut off fractions, so why try fo=
r=20
> _exactly_ one number?

Because completeness is special.  If just one bit was available, I'd us=
e
it to indicate equality.  That's what the authors of cmp(1) did, too. :=
)

And 0% is not special, at least not in a useful way that I can think of=
=2E
  I.e. there is no practical difference between "no two lines match" an=
d
"one percent of the lines match".  If you're really interested in
similarities with an index below 10% then you'd better work with
absolute numbers instead of rounded percentages.

If someone came around with an interest in those cases with exactly 0%
similarity, then we might need to decide between rounding up or down.
But even in that hypothetical situation I think "equality" is still mor=
e
interesting a data point than "really everything differs".

Ren=E9
