From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: [PATCH] Re: git-gui: various French translation fixes
Date: Thu, 19 Mar 2009 19:38:39 +0100
Message-ID: <20090319183839.GA12913@vidovic>
References: <20090318205410.GA900@zoy.org> <200903190609.25344.chriscool@tuxfamily.org> <200903190714.25211.chriscool@tuxfamily.org> <20090319075855.GJ27280@zoy.org> <20090319124901.GM27280@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>,
	Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
To: Sam Hocevar <sam@zoy.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 19:40:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkNAC-0001d3-1i
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 19:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755104AbZCSSiu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 14:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbZCSSit
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 14:38:49 -0400
Received: from out4.laposte.net ([193.251.214.121]:45252 "EHLO
	out3.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753474AbZCSSit (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 14:38:49 -0400
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8311.laposte.net (SMTP Server) with ESMTP id D7F6F7000088;
	Thu, 19 Mar 2009 19:38:40 +0100 (CET)
Received: from ? (91-165-141-36.rev.libertysurf.net [91.165.141.36])
	by mwinf8311.laposte.net (SMTP Server) with ESMTP id 3EC047000087;
	Thu, 19 Mar 2009 19:38:40 +0100 (CET)
X-ME-UUID: 20090319183840257.3EC047000087@mwinf8311.laposte.net
Content-Disposition: inline
In-Reply-To: <20090319124901.GM27280@zoy.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-me-spamlevel: not-spam
X-me-spamrating: 40.000000
X-me-spamcause: OK, (-200)(0000)gggruggvucftvghtrhhoucdtuddrvdekuddrvdelucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113806>


On Thu, Mar 19, 2009 at 01:49:02PM +0100, Sam Hocevar wrote:
>=20
> On Thu, Mar 19, 2009, Sam Hocevar wrote:
> > On Thu, Mar 19, 2009, Christian Couder wrote:
> > > > >  #: git-gui.sh:2484 lib/index.tcl:410
> > > > >  msgid "Revert Changes"
> > > > > -msgstr "Annuler les modifications (revert)"
> > > > > +msgstr "R=E9voquer les modifications"
> > > >
> > > > I am not sure that "R=E9voquer" is better than "Annuler".
> > >=20
> > > Perhaps "Inverser"?

[...]

>    Sorry, I misread the Wikipedia interface because I wasn't logged i=
n
> and only admins can truly revert edits.

I don't think that we have to conform to Wikip=E9dia.

>                                         So it does have "revert" (to
> cancel an edit) and "undo" (to perform the opposite edit of a given
> edit), which get translated to "r=E9voquer" and "d=E9faire". I theref=
ore
> think "r=E9voquer" is just as good as the others.

I disagree here.

"Annuler", "R=E9voquer", "Inverser" or "D=E9faire" usualy stands for th=
e
same thing but :=20
- thoses words doesn't have stricly the same meanings ;
- we are in a special case here because of the underlying technical
  result.

We should care that the revert operation does *not* remove a commit but
add a new one (this makes sense to Git). As a consequence, we should av=
oid
"Annuler", "R=E9voquer" and "D=E9faire".

"Inverser" looks like the best translation.

--=20
Nicolas Sebrecht
