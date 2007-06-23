From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: 100%
Date: Sat, 23 Jun 2007 14:11:20 +0200
Message-ID: <467D0DE8.6030104@lsrfire.ath.cx>
References: <20070621030622.GD8477@spearce.org> <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org> <Pine.LNX.4.64.0706211248420.4059@racer.site> <20070621131915.GD4487@coredump.intra.peff.net> <Pine.LNX.4.64.0706220214250.4059@racer.site> <467B777D.C47BFE0E@eudaptics.com> <Pine.LNX.4.64.0706221122200.4059@racer.site> <86ps3oi7ma.fsf_-_@lola.quinscape.zz> <Pine.LNX.4.64.0706221347480.4059@racer.site> <86abusi1fw.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706230222330.4059@racer.site> <467CF380.6060603@lsrfire.ath.cx> <Pine.LNX.4.64.0706231154300.4059@racer.site> <467D06D4.9050203@lsrfire.ath.cx> <Pine.LNX.4.64.0706231259021.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 23 14:11:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I24Sk-0005KH-9T
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 14:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbXFWMLc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Jun 2007 08:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbXFWMLc
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 08:11:32 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:35997
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750833AbXFWMLb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jun 2007 08:11:31 -0400
Received: from [10.0.1.201] (p508E514E.dip.t-dialin.net [80.142.81.78])
	by neapel230.server4you.de (Postfix) with ESMTP id 93D3E2C00D;
	Sat, 23 Jun 2007 14:11:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
In-Reply-To: <Pine.LNX.4.64.0706231259021.4059@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50734>

Johannes Schindelin schrieb:
> Hi,
>=20
> On Sat, 23 Jun 2007, Ren=E9 Scharfe wrote:
>=20
>> Johannes Schindelin schrieb:
>>
>>> By the same reasoning, you could say "never round down to 0%, becau=
se=20
>>> I want to know when there is no similarity".
>>>
>>> You cannot be exact when you have to cut off fractions, so why try =
for=20
>>> _exactly_ one number?
>> Because completeness is special.
>=20
> I am not convinced. My vote is still for the _common_ practice of jus=
t=20
> rounding. IOW keep it as is.

As I already hinted at, the common result of comparing two files, as
done by e.g. cmp(1), is one bit that indicates equality.  This
information is lost when using up/down rounding, but it is retained whe=
n
rounding down.  It's _not_ common to be unable to determine equality
from the result of a file compare.

Ren=E9
