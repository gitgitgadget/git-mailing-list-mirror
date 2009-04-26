From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [doc] User Manual Suggestion
Date: Sun, 26 Apr 2009 20:12:44 +0200
Message-ID: <20090426181244.GB4942@atjola.homenet>
References: <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com> <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com> <alpine.LNX.2.00.0904241852500.2147@iabervon.org> <b4087cc50904241626h166c6b3bqa4ec714d4cb5662a@mail.gmail.com> <alpine.LNX.2.00.0904251445030.2147@iabervon.org> <b4087cc50904251216p617e347bmdc70e109298fa9b2@mail.gmail.com> <94a0d4530904251224g6b228448q276436f17f7e5cc3@mail.gmail.com> <E85677CA-FA7E-4777-97DF-9B295E89B83A@boostpro.com> <20090426112802.GC10155@atjola.homenet> <b4087cc50904260936t4aa05c92ldab3b8ce8c9bd33a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Abrahams <dave@boostpro.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 11:31:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly8s7-0001wu-EU
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 20:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbZDZSNB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 14:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754543AbZDZSNA
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 14:13:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:55472 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754186AbZDZSM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 14:12:59 -0400
Received: (qmail invoked by alias); 26 Apr 2009 18:12:57 -0000
Received: from i59F5A916.versanet.de (EHLO atjola.local) [89.245.169.22]
  by mail.gmx.net (mp046) with SMTP; 26 Apr 2009 20:12:57 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+PmU9+3FSPQS20AGCGSN67DzOq63eXu2fFywPsPy
	HITTIzAeQaBmW2
Content-Disposition: inline
In-Reply-To: <b4087cc50904260936t4aa05c92ldab3b8ce8c9bd33a@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117627>

On 2009.04.26 11:36:04 -0500, Michael Witten wrote:
> 2009/4/26 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> > On 2009.04.25 15:36:24 -0400, David Abrahams wrote:
> >> Where it's relevant when the user notices that two distinct files =
have
> >> the same id (because they happen to have the same contents) and wo=
nders
> >> what's up.
> >...
> > And why would your implementation save the same object twice, in tw=
o
> > distinct files?
>=20
> This question makes me think that you don't understand the parent's
> point. He's not talking about implementation details; in fact, there'=
s
> no reason to mix the git world and the file system world at all in
> this discussion.
>=20
> David is pointing out that a user might notice that two different
> trees list the same blob. This can be startling if you have incomplet=
e
> picture about what's going on.

David said that the user encounters two distinct files with the same id=
=2E
The ids are properties of the objects. So he must have meant object
files, or he attributed the id to the wrong thing. I assumed that he
didn't mix those things up and really meant the object files, thus my
reply.

> >From a practical point of view, you might argue that not too many
> people are looking at trees and blobs;

Heh, I'd rather argue that too _few_ people have looked at commits and
trees at least once, whether it's an actual object or a graph like in
git for computer scientists.

> however, it seems to me that most people are afraid to use any of
> git's most useful features precisely because they don't understand th=
e
> git model and they don't understand that nothing is ever lost unless
> you explicitly clean up unreferenced objects---they don't see how eas=
y
> it is manipulate their repos. I argue that if they are given the full
> knowledge of git's concepts, then they will be able to reason about
> their repo actions with confidence, even if they only work with
> commits.

Agreed.

> I think the key is to stress in the documentation the idea that there
> are 2 separate worlds (the git object world and the working
> directory's file system world) and that the git tools provide an
> interface between them; this seems like a small and unnecessarily
> academic point, but I believe that it's important to working with
> confidence.

Agreed. That's also why I asked David why the user would look at the
object files in the repo (the .git dir). To some degree those are also
an implementation detail. The user works with the working tree and uses
the git tools to modify the repo.

> > It's an identity relation: same name/id =3D> same object. Unlike e.=
g. a
> > hash-table where you are expected to deal with collisions, and havi=
ng
> > the same hash doesn't mean that you have identical data.
>=20
> However, having the same *cryptographic* hash does mean that you have
> identical data.

That's the _assumption_ that git makes. Hash collisions are always
possible, just hard to create intentionally when the hash function has
not yet been broken.

Bj=F6rn
