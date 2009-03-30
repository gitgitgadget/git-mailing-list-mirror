From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] Add warning about known issues to documentation of
	cvsimport
Date: Tue, 31 Mar 2009 00:36:46 +0200
Message-ID: <20090330223646.GC68118@macbook.lan>
References: <20090323195304.GC26678@macbook.lan> <20090324031448.GA12829@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 00:38:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoQ7b-0004Eq-Jp
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 00:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547AbZC3Wgw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 18:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbZC3Wgw
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 18:36:52 -0400
Received: from darksea.de ([83.133.111.250]:37639 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752429AbZC3Wgv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 18:36:51 -0400
Received: (qmail 12601 invoked from network); 31 Mar 2009 00:36:46 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 31 Mar 2009 00:36:46 +0200
Content-Disposition: inline
In-Reply-To: <20090324031448.GA12829@coredump.intra.peff.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115196>

On Mon, Mar 23, 2009 at 11:14:48PM -0400, Jeff King was talking about:
> On Mon, Mar 23, 2009 at 08:53:05PM +0100, Heiko Voigt wrote:
>=20
> > The described issues are compiled from the tests by Michael Haggert=
y and me.
> > Because it is not apparent that these can be fixed anytime soon at =
least warn
> > unwary users not to rely on the inbuilt cvsimport to much.
>=20
> I think this change is good in concept.
>=20
> > +[[issues]]
> > +ISSUES
> > +------
> > +Problems related to timestamps:
> > +
> > + * If timestamps of commits in the cvs repository are not stable e=
nough
> > +   to be used for ordering commits
> > + * If any files were ever "cvs import"ed more than once (e.g., imp=
ort of
> > +   more than one vendor release)
> > + * If the timestamp order of different files cross the revision or=
der
> > +   within the commit matching time window
>=20
> Reading this, I kept waiting for the "then" to your "if". I think the
> implication is "your import will be incorrect". But it would be nice =
to
> say _how_, even if it's something as simple as "changes may show up i=
n
> the wrong commit, the wrong branch, be omitted" or whatever. Just giv=
e a
> general idea of what can happen.

You are right, I actually wanted to update my patch but as I've seen
today my patch already made it into master. So I guess I will prepare a=
n
update patch to address these issues.

>=20
> Also, this renders somewhat poorly in the manpage version. I get:
>=20
> <quote>
> ISSUES
>        Problems related to timestamps:
>=20
>=20
>        =B7   If timestamps of commits in the cvs repository are not s=
table
>            enough to be used for ordering commits
>=20
>        =B7   If any files were ever "cvs import"ed more than once (e.=
g., import
>            of more than one vendor release)
>=20
>        =B7   If the timestamp order of different files cross the revi=
sion order
>            within the commit matching time window
>        Problems related to branches:
>=20
>=20
>        =B7   Branches on which no commits have been made are not impo=
rted
> </quote>
>=20
> Note the extra blank line between each heading and its list, and the
> lack of a blank line between the end of the first list and the headin=
g
> of the second. Your source is very readable, so it really is just
> asciidoc being silly, but I wonder if there is a way to work around
> that.

My xmlto is not working at the moment. I will check that.
