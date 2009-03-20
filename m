From: Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
Subject: Re: [PATCH 2/2] git-gui: some French translation enhancements
Date: Fri, 20 Mar 2009 10:34:54 -0400
Organization: Savoir-faire Linux
Message-ID: <1237559694.25283.46.camel@alexandre-desktop>
References: <cd2d922d5257aac105de08fd90e6dbd389f0b6f0.1237506346.git.nicolas.s-dev@laposte.net>
	 <5b4295c484a9659d1c5813e1859f192c34d6a99e.1237506346.git.nicolas.s-dev@laposte.net>
	 <20090320071316.GB5693@glandium.org>
Reply-To: alexandre.bourget@savoirfairelinux.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	Git List <git@vger.kernel.org>, Sam Hocevar <sam@zoy.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Mar 20 16:01:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkgE3-00023t-DG
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 16:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbZCTPAF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 11:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751974AbZCTPAE
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 11:00:04 -0400
Received: from mail.savoirfairelinux.net ([69.28.212.163]:53703 "EHLO
	open-xchange.savoirfairelinux.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751060AbZCTPAB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 11:00:01 -0400
X-Greylist: delayed 1621 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Mar 2009 11:00:01 EDT
Received: from localhost (unknown [127.0.0.1])
	by open-xchange.savoirfairelinux.net (Postfix) with ESMTP id 67E1B46174E;
	Fri, 20 Mar 2009 14:32:54 +0000 (UTC)
Received: from open-xchange.savoirfairelinux.net ([127.0.0.1])
	by localhost (open-xchange.savoirfairelinux.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L4eFCP9ZgkTA; Fri, 20 Mar 2009 10:32:51 -0400 (EDT)
Received: from [192.168.50.166] (IP-208-88-110-46.mtl.fibrenoire.ca [208.88.110.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by open-xchange.savoirfairelinux.net (Postfix) with ESMTP id 78F9846174D;
	Fri, 20 Mar 2009 10:32:51 -0400 (EDT)
In-Reply-To: <20090320071316.GB5693@glandium.org>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113966>

Le vendredi 20 mars 2009 =C3=A0 08:13 +0100, Mike Hommey a =C3=A9crit :
> On Fri, Mar 20, 2009 at 01:54:02AM +0100, Nicolas Sebrecht wrote:
> IMHO, we should find a better way to say that than to use the "index"
> word at all. This obviously applies to all uses of "index" in french
> where we avoided it in english.
>=20
> OTOH, the best I can find for "staging area" is "zone de pr=C3=A9para=
tion",
> and that doesn't help finding a word for stage and unstage.

"zone de pr=C3=A9paration" sounds good to me.


-------------

> [from another e-mail]
> > We should care that the revert operation does *not* remove a commit=
 but
> > add a new one (this makes sense to Git). As a consequence, we shoul=
d
> > avoid "Annuler", "R=C3=A9voquer" and "D=C3=A9faire".
> >
> > "Inverser" looks like the best translation.

> Yeah, I agree with that reasoning.

Hmm.. if you look at the git-gui program, when we use "Revert", it's no=
t
always the usage of the git-revert command that is invoked.

Most of the time, it's the equivalent of running "git reset --hard", or
"git checkout path/filename.ext" (in fact, it uses git-checkout-index,
see git-gui/lib/index.tcl::revert_helper..).

That is true for example in the "Commit" menu, 3rd to last item, which
reads in french "Inverser les modifications" or "R=C3=A9voker les
modifications" as I modified it at some point.

What happens here, is really not inversion of modifications; we're just
wiping out all changes from the working dir, back to HEAD. Several of
the translated messages are used in *that* context.=20


So, considering this, which one of: "Annuler", "R=C3=A9voquer", "D=C3=A9=
faire",
"Effacer", "Restaurer l'original", "Scrapper", "Trucider", "Supprimer" =
+
"les modifications" would be best ?

It should be obvious that it's going to affect the blue icons, and that
those modifications will dissapear forever.

Also note that "svn revert" does like git-checkout-index, and not like
git-revert, so the terms must be clear here, even in English.


Alexandre

--=20
Alexandre Bourget
Directeur adjoint au d=C3=A9veloppement
Consultant en Logiciel Libre
Savoir-faire Linux Inc.
alexandre.bourget@savoirfairelinux.com
514-276-5468 poste 124
