From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] git-gui: some French translation enhancements
Date: Sat, 21 Mar 2009 04:48:19 +0100
Message-ID: <200903210448.19368.chriscool@tuxfamily.org>
References: <cd2d922d5257aac105de08fd90e6dbd389f0b6f0.1237506346.git.nicolas.s-dev@laposte.net> <20090320071316.GB5693@glandium.org> <1237559694.25283.46.camel@alexandre-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	Git List <git@vger.kernel.org>, Sam Hocevar <sam@zoy.org>
To: alexandre.bourget@savoirfairelinux.com
X-From: git-owner@vger.kernel.org Sat Mar 21 04:50:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LksEa-0004kg-9U
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 04:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbZCUDtS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 23:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753929AbZCUDtS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 23:49:18 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:55167 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753924AbZCUDtR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 23:49:17 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 722D394004D;
	Sat, 21 Mar 2009 04:49:06 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 264EF940041;
	Sat, 21 Mar 2009 04:49:04 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1237559694.25283.46.camel@alexandre-desktop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114026>

Le vendredi 20 mars 2009, Alexandre Bourget a =C3=A9crit :
> Le vendredi 20 mars 2009 =C3=A0 08:13 +0100, Mike Hommey a =C3=A9crit=
 :
> > On Fri, Mar 20, 2009 at 01:54:02AM +0100, Nicolas Sebrecht wrote:
> > IMHO, we should find a better way to say that than to use the "inde=
x"
> > word at all. This obviously applies to all uses of "index" in frenc=
h
> > where we avoided it in english.
> >
> > OTOH, the best I can find for "staging area" is "zone de pr=C3=A9pa=
ration",
> > and that doesn't help finding a word for stage and unstage.
>
> "zone de pr=C3=A9paration" sounds good to me.
>
>
> -------------
>
> > [from another e-mail]
> >
> > > We should care that the revert operation does *not* remove a comm=
it
> > > but add a new one (this makes sense to Git). As a consequence, we
> > > should avoid "Annuler", "R=C3=A9voquer" and "D=C3=A9faire".
> > >
> > > "Inverser" looks like the best translation.
> >
> > Yeah, I agree with that reasoning.
>
> Hmm.. if you look at the git-gui program, when we use "Revert", it's =
not
> always the usage of the git-revert command that is invoked.
>
> Most of the time, it's the equivalent of running "git reset --hard", =
or
> "git checkout path/filename.ext" (in fact, it uses git-checkout-index=
,
> see git-gui/lib/index.tcl::revert_helper..).
>
> That is true for example in the "Commit" menu, 3rd to last item, whic=
h
> reads in french "Inverser les modifications" or "R=C3=A9voker les
> modifications" as I modified it at some point.
>
> What happens here, is really not inversion of modifications; we're ju=
st
> wiping out all changes from the working dir, back to HEAD. Several of
> the translated messages are used in *that* context.
>
>
> So, considering this, which one of: "Annuler", "R=C3=A9voquer", "D=C3=
=A9faire",
> "Effacer", "Restaurer l'original", "Scrapper", "Trucider", "Supprimer=
" +
> "les modifications" would be best ?

Considering what you said, I think "Annuler" is best, but we really sho=
uld=20
remove "(revert)"  in "Annuler les modifications (revert)" as it is=20
definitely misleading translators ;-)

Sam could you please send a newer version of you original patch with th=
e=20
above change and:

s/Essayez de r=C3=A9cup=C3=A9r=C3=A9/Essayez de r=C3=A9cup=C3=A9rer/
s/selectionn=C3=A9s/s=C3=A9lectionn=C3=A9s/

About the index/staging area/adding/staging/unstaging, I think there is=
 not=20
yet an agreeement about how we should translate that so we should discu=
ss=20
it further.

Thanks,
Christian.
