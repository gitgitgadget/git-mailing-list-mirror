From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: git merge --date --author
Date: Mon, 10 Mar 2014 13:52:52 +0100
Organization: OPTEYA
Message-ID: <1394455972.3257.51.camel@localhost.localdomain>
References: <1394188215.3257.17.camel@localhost.localdomain>
	 <87y50mxj0b.fsf@igel.home> <xmqqvbvpu757.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
	Yann Droneaud <ydroneaud@opteya.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:53:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzhv-00047A-Gk
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755AbaCJMxQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2014 08:53:16 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:34372 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753746AbaCJMxM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 08:53:12 -0400
Received: from [192.168.20.20] (unknown [37.162.217.221])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 53AE3940141;
	Mon, 10 Mar 2014 13:52:54 +0100 (CET)
In-Reply-To: <xmqqvbvpu757.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4 (3.10.4-1.fc20) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243757>

Hi,

Le vendredi 07 mars 2014 =C3=A0 11:43 -0800, Junio C Hamano a =C3=A9cri=
t :
> Andreas Schwab <schwab@linux-m68k.org> writes:
>=20
> > Yann Droneaud <ydroneaud@opteya.com> writes:
> >
> >> But I'd like to know if there's a specific reason for git merge to=
 not
> >> support --date and --author ?
> >
> > It's rather unusual that a merge is performed on behalf of a differ=
ent
> > author.
>=20
> Yes.  Michael's "Nobody bothered to implement it" is also correct
> but the reason why nobody bothered to most likely is due to "why
> would you want to lie?".
>=20

When was Git changed in some kind of TSA agent one has to bribe to get
allowed to cross^Wcommit ? Why git lawyer is not implemented ? I want a
fair trial !

And before adding to Git a perfect lie detector (how will it able to
make the difference between truth and lie ? then, will it be able to
make the difference between good and bad ?, oh god, no !), I would
prefer to have it detect bugs before one could commit instead.

You seems to think I'm lying, but I'm not a liar: I just need to make
some arrangements with the history under another identity, as I could b=
e
legally bound to. So it may sound like a lie for you, but ultimately,
it's the plain truth.

So as the tool is not in position to distinguish lie from truth, I'd
prefer to not see this concept brought here.

> If the use case is to rebuild history, you would need to be able to
> also lie about the committer, so
>=20
> >> git merge \
> >>     --date "2013-12-31 23:59:59 +0000" \
> >>     --author "Happy New Year <happy.new-year@gregorian.calendar>" =
\
> >>     current-year
>=20
> in such a history-rebuild script would not be sufficient.  The
> script can set necessary environment variables to lie about both
> author and commiter, though, of course.
>=20

Thanks for reminding this: I have to use GIT_COMMITER_DATE,
GIT_COMMITER_NAME and GIT_COMMITER_EMAIL.

As I'm not calling for adding --date and --author, I will continue to
use the environment variables: they're good enough for the job.

Regards.

--=20
Yann Droneaud
OPTEYA
