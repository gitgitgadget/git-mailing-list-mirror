From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: Reworded example text in git-bisect.txt.
Date: Sun, 22 Mar 2009 20:23:49 -0400
Message-ID: <20090323002349.GA21069@fieldses.org>
References: <1237520134-18044-1-git-send-email-dmellor@whistlingcat.com> <200903210528.32392.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "David J. Mellor" <dmellor@whistlingcat.com>, gitster@pobox.com,
	git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 01:25:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlXyr-0005FX-2X
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 01:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531AbZCWAX7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 20:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753332AbZCWAX7
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 20:23:59 -0400
Received: from mail.fieldses.org ([141.211.133.115]:50812 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228AbZCWAX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 20:23:58 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1LlXxF-0005UD-Ot; Sun, 22 Mar 2009 20:23:49 -0400
Content-Disposition: inline
In-Reply-To: <200903210528.32392.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114210>

On Sat, Mar 21, 2009 at 05:28:32AM +0100, Christian Couder wrote:
> Le vendredi 20 mars 2009, David J. Mellor a =C3=A9crit :
>=20
> [...]
>=20
> > @@ -94,14 +95,14 @@ the bisection state).
> >  Bisect visualize
> >  ~~~~~~~~~~~~~~~~
> >
> > -During the bisection process, you issue the command:
> > +To see the currently remaining suspects in 'gitk', the following c=
ommand
> > +is issued during the bisection process:
>=20
> I think it's better to avoid the passive tone, for example like this:
>=20
> "To see the currently remaining suspects in 'gitk', you issue the fol=
lowing=20
> command during the bisection process:"

Agreed, but drop the "you" too.

--b.

>=20
> >  ------------
> >  $ git bisect visualize
> >  ------------
>=20
> [...]
>=20
> > @@ -173,8 +175,8 @@ using the "'<commit1>'..'<commit2>'" notation. =
=46or
> > example: $ git bisect skip v2.5..v2.6
> >  ------------
> >
> > -would mean that no commit between `v2.5` excluded and `v2.6` inclu=
ded
> > -can be tested.
> > +The effect of this would be that no commit between `v2.5` excluded=
 and
> > +`v2.6` included could be tested.
>=20
> I'd prefer something like:
>=20
> "This tells the bisect process that no commit between `v2.5` excluded=
 and=20
> `v2.6` included can be tested."
>=20
> Otherwise it looks good to me.
>=20
> Thanks,
> Christian.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
