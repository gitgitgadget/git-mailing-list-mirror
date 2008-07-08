From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] bash: offer only paths after '--'
Date: Wed, 9 Jul 2008 01:51:53 +0200
Message-ID: <20080708235153.GD8224@neumann>
References: <279b37b20807071341k3551e61cl10c5969600ba8218@mail.gmail.com>
	<20080708044922.GD2542@spearce.org>
	<7vprppvt7a.fsf@gitster.siamese.dyndns.org>
	<alpine.DEB.1.00.0807081335470.4319@eeepc-johanness>
	<20080708165614.GB8224@neumann>
	<7vtzf0rusw.fsf@gitster.siamese.dyndns.org>
	<20080708231837.GA16895@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 01:53:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGMzc-0008B6-P0
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 01:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbYGHXwL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 19:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754549AbYGHXwK
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 19:52:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:56794 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754216AbYGHXwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 19:52:09 -0400
Received: from [127.0.1.1] (p5B1330E6.dip0.t-ipconnect.de [91.19.48.230])
	by mrelayeu.kundenserver.de (node=mrelayeu2) with ESMTP (Nemesis)
	id 0MKwtQ-1KGMyO1HDU-0007Ls; Wed, 09 Jul 2008 01:52:04 +0200
Content-Disposition: inline
In-Reply-To: <20080708231837.GA16895@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1+DpS85kTceARNsTVDF7mAc4t9l3hkODyN9goE
 h/2AkZYhfhd9IvExU+tD7n3ODjg8qIzSGP/8fkhPLi3JrtjRk9
 eYujZoYTOM8AHHpn+thCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87811>

On Tue, Jul 08, 2008 at 11:18:37PM +0000, Shawn O. Pearce wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > SZEDER G=E1bor <szeder@ira.uka.de> writes:
> > > +		c=3D$((++c))
> >=20
> > This assignment is somewhat curious, although it should work as exp=
ected
> > either way ;-)
>=20
> I agree, its damned odd.  But we already do this in the same
> sort of loop inside of _git_branch() (see around line 541 in
> next).  This new patch is only sticking with our current set
> of conventions in the script, so I say its fine.
Well, according to

  git blame contrib/completion/git-completion.bash  |grep '++'

you started this convention back in 2006, I just copied and modified
your code (;

Maybe an old C++ "heritage"?  In C++ it matters for class types (e.g.
iterators), because the postfix operator might be slower than the
prefix.

Best,
G=E1bor
