From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: git-format-patch.txt rewordings and
	cleanups
Date: Tue, 24 Mar 2009 19:53:31 -0400
Message-ID: <20090324235331.GC19389@fieldses.org>
References: <1237803683-14939-1-git-send-email-bebarino@gmail.com> <20090324220913.GN19389@fieldses.org> <780e0a6b0903241636j4749daf3xddb6e4c200c00820@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 00:55:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmGSX-0002GF-Mx
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 00:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344AbZCXXxe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 19:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754737AbZCXXxd
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 19:53:33 -0400
Received: from mail.fieldses.org ([141.211.133.115]:33184 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632AbZCXXxd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 19:53:33 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1LmGR1-0006s7-V4; Tue, 24 Mar 2009 19:53:31 -0400
Content-Disposition: inline
In-Reply-To: <780e0a6b0903241636j4749daf3xddb6e4c200c00820@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114517>

On Tue, Mar 24, 2009 at 04:36:15PM -0700, Stephen Boyd wrote:
> On Tue, Mar 24, 2009 at 3:09 PM, J. Bruce Fields <bfields@fieldses.or=
g> wrote:
> > On Mon, Mar 23, 2009 at 03:21:23AM -0700, Stephen Boyd wrote:
> >> =C2=A0+
> >> -Note that you would need to include the leading dot `.` if you
> >> -want a filename like `0001-description-of-my-change.patch`, and
> >> -the first letter does not have to be a dot. =C2=A0Leaving it empt=
y would
> >> -not add any suffix.
> >> +Note the first letter is not required to be a dot, you will need =
to
> >> +include the leading dot `.` if you want a filename like
> >> +`0001-description-of-my-change.patch`.
> >
> > That's a comma-splice, trivially fixed by changing "dot, you" to "d=
ot;
> > you".
> >
> > Better?: "Note that the leading dot isn't actually required if you =
don't
> > want a dot between the patch name and the suffix."
> >
> > (Though personally I'd strike the whole sentence, since a) probably
> > nobody cares, and b) the 1 in a million person that does actually w=
ant
> > to do this can figure it out easily enough on their own with a quic=
k
> > test.)
> >
> > --b.
> >
>=20
> I don't think documentation is meant to point the user to trial and
> error. Even if the error is fairly harmless. Although you could be
> right that nobody cares.
>=20
> How about a sentence with no negation?
>=20
> "Note that the leading dot is required if you want a dot between the
> patch name and the suffix."

Sure!

--b.
