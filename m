From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [doc] User Manual Suggestion
Date: Thu, 23 Apr 2009 22:29:00 -0400
Message-ID: <20090424022900.GB6321@fieldses.org>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org> <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 04:31:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxBBx-0007fb-8W
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 04:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755222AbZDXC3G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 22:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754605AbZDXC3E
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 22:29:04 -0400
Received: from mail.fieldses.org ([141.211.133.115]:50235 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434AbZDXC3D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 22:29:03 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1LxB9w-0001h1-HG; Thu, 23 Apr 2009 22:29:00 -0400
Content-Disposition: inline
In-Reply-To: <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117402>

On Thu, Apr 23, 2009 at 01:37:05PM -0500, Michael Witten wrote:
> On Thu, Apr 23, 2009 at 12:57, J. Bruce Fields <bfields@fieldses.org>=
 wrote:
> > On Wed, Apr 22, 2009 at 03:38:52PM -0400, David Abrahams wrote:
> >>
> >> http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#h=
ow-to-check-out
> >> covers "git reset" way too early, IMO, before one has the conceptu=
al
> >> foundation necessary to understand what it means to "modify the cu=
rrent
> >> branch to point at v2.6.17". =C2=A0If this operation must be cover=
ed this
> >> early in the manual, it should probably not be until
> >> http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#m=
anipulating-branches
> >
> > I agree; we should suggest just a git-checkout (to a detached HEAD)
> > instead, though that needs a little explanation so people aren't sc=
ared
> > by the warning message it gives.
>=20
> Everyone talks about "before one has the conceptual foundation
> necessary to understand". Well, here's an idea: The git documentation
> should start with the concepts!
>=20
> Why don't the docs start out defining blobs and trees and the object
> database and references into that database? The reason everything is
> so confusing is that the understanding is brushed under the tutorial
> rug. People need to learn how to think before they can effectively
> learn to start doing.

OK, but let's not over-generalize: the person that just wants to figure
out whether the driver for their network card was fixed in today's
network devel tree shouldn't have to sit through a discussion of the
object database.  And even among readers that are in it for the long
haul, I think many people will react better to something that gives the=
m
at least a little concrete how-to information up front.

So the goal was always to find a tutorial route through the material
that would allow us to introduce the concepts as we go along.

And I agree that I haven't succeeded at that--patches welcomed,
including patches that, say, move more of the current chapter 7 to an
earlier place.  (But this has to be done carefully, and I'd still rathe=
r
it not be the *very* first thing.)

I've unfortunately had a lot less time to work on this, but am happy to
at least help review patches.

--b.
