From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 25 Nov 2007 20:53:57 +0000
Message-ID: <20071125205357.GA23820@fieldses.org>
References: <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org> <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org> <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org> <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <7v4pfakr4j.fsf@gitster.siamese.dyndns.org> <ficmbr$s87$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 21:56:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwOW4-0004sm-AW
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 21:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756744AbXKYUza convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 15:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756758AbXKYUza
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 15:55:30 -0500
Received: from mail.fieldses.org ([66.93.2.214]:35370 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756356AbXKYUz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 15:55:29 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IwOUM-0006nR-Ek; Sun, 25 Nov 2007 20:54:02 +0000
Content-Disposition: inline
In-Reply-To: <ficmbr$s87$1@ger.gmane.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66004>

On Sun, Nov 25, 2007 at 09:36:14PM +0100, Jakub Narebski wrote:
> Junio C Hamano wrote:
>=20
> > [Actively cooking]
> >=20
> > * jc/spht (Sat Nov 24 11:57:41 2007 -0800) 6 commits
> > =C2=A0+ core.whitespace: documentation updates.
> > =C2=A0+ builtin-apply: teach whitespace_rules
> > =C2=A0+ builtin-apply: rename "whitespace" variables and fix styles
> > =C2=A0+ core.whitespace: add test for diff whitespace error highlig=
hting
> > =C2=A0+ git-diff: complain about >=3D8 consecutive spaces in initia=
l indent
> > =C2=A0+ War on whitespace: first, a bit of retreat.
> >=20
> > Now apply also knows about the customizable definition of what
> > whitespace breakages are, and I was reasonably happy. But Bruce kic=
ked
> > it back from "scheduled to merge" to "still cooking" status, remind=
ing
> > that we would want to have this not a tree-wide configuration but
> > per-path attribute. =C2=A0And I agree with him.
>=20
> Currently apply.whitespace is per repository - would this be changed
> as well,

There's a difference between the choice of preferred whitespace style
and the choice of action to take when encountering "bad" whitespace.

The former is (I think) obviously a property of the project (or perhaps
of individual paths within the project).  The latter may depend on what
you're doing with it at any given moment--for example, if I'm applying
patches to submit, I generally want to fix whitespace, but if I'm just
examining someone else's patches temporarily then I might want to impor=
t
them quickly without fixing up everything.

So, no, I don't think there should be a .gitattribute equivalent to
apply.whitespace.

--b.

> i.e. would it be moved to gitattributes together with custom
> diff drivers (or at least custom funcnames), custom merge drivers,
> making it per-project (if put under version control) and per-path?

>=20
>=20
> By the way, i18n.commitEncoding is per repository, and used to affect
> repository; not so with the "encoding" header in commit object.
>=20
> --=20
> Jakub Narebski
> Warsaw, Poland
> ShadeHawk on #git
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
