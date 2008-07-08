From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: offer only paths after '--'
Date: Tue, 8 Jul 2008 23:55:38 +0000
Message-ID: <20080708235538.GB17263@spearce.org>
References: <279b37b20807071341k3551e61cl10c5969600ba8218@mail.gmail.com> <20080708044922.GD2542@spearce.org> <7vprppvt7a.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807081335470.4319@eeepc-johanness> <20080708165614.GB8224@neumann> <7vtzf0rusw.fsf@gitster.siamese.dyndns.org> <20080708231837.GA16895@spearce.org> <20080708235153.GD8224@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: SZEDER GGGbor <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 01:56:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGN2z-0000UC-1F
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 01:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbYGHXzj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 19:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754682AbYGHXzj
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 19:55:39 -0400
Received: from george.spearce.org ([209.20.77.23]:54672 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754675AbYGHXzj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 19:55:39 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A914538195; Tue,  8 Jul 2008 23:55:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080708235153.GD8224@neumann>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87812>

SZEDER GGGbor <szeder@ira.uka.de> wrote:
> On Tue, Jul 08, 2008 at 11:18:37PM +0000, Shawn O. Pearce wrote:
> > Junio C Hamano <gitster@pobox.com> wrote:
> > > SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
> > > > +		c=3D$((++c))
> > >=20
> > > This assignment is somewhat curious, although it should work as e=
xpected
> > > either way ;-)
>
> Well, according to
>=20
>   git blame contrib/completion/git-completion.bash  |grep '++'
>=20
> you started this convention back in 2006, I just copied and modified
> your code (;

Yea, I don't doubt it was me that did this.
=20
> Maybe an old C++ "heritage"?  In C++ it matters for class types (e.g.
> iterators), because the postfix operator might be slower than the
> prefix.

Unlikely, but maybe.  I'm not really a C++ programmer.  I tend to
avoid C++ when/if I am given the chance to do so.

--=20
Shawn.
