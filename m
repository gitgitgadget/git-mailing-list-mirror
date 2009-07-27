From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [ANNOUNCE] GIT 1.6.4-rc3
Date: Mon, 27 Jul 2009 07:13:11 +0200
Message-ID: <20090727051311.GA17300@pengutronix.de>
References: <7vws5vrh93.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 07:13:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVIX6-0005MZ-39
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 07:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbZG0FNO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jul 2009 01:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbZG0FNO
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 01:13:14 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54653 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbZG0FNN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 01:13:13 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1MVIWP-00023c-GH; Mon, 27 Jul 2009 07:13:13 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1MVIWN-0004Va-MN; Mon, 27 Jul 2009 07:13:11 +0200
Content-Disposition: inline
In-Reply-To: <7vws5vrh93.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124155>

Hi Junio,

On Sun, Jul 26, 2009 at 01:16:40AM -0700, Junio C Hamano wrote:
> Updates since v1.6.3
> --------------------
>=20
> [...]
>=20
> (usability, bells and whistles)
>=20
>  * "git add --edit" lets users edit the whole patch text to fine-tune=
 what
>    is added to the index.
>=20
>  * "git am" accepts StGIT series file as its input.
>=20
>  * "git bisect skip" skips to a more randomly chosen place in the hop=
e
>    to avoid testing a commit that is too close to a commit that is
>    already known to be untestable.
>=20
>  * "git cvsexportcommit" learned -k option to stop CVS keywords expan=
sion
>=20
>  * "git grep" learned -p option to show the location of the match usi=
ng the
>    same context hunk marker "git diff" uses.
>=20
>  * https transport can optionally be told that the used client
>    certificate is password protected, in which case it asks the
>    password only once.
>=20
>  * "git imap-send" is IPv6 aware.
>=20
>  * "git log --graph" draws graphs more compactly by using horizontal =
lines
>    when able.
>=20
>  * "git log --decorate" shows shorter refnames by stripping well-know=
n
>    refs/* prefix.
>=20
>  * "git push $name" honors remote.$name.pushurl if present before
>    using remote.$name.url.  In other words, the URL used for fetching
>    and pushing can be different.
>=20
>  * "git send-email" understands quoted aliases in .mailrc files (migh=
t
>    have to be backported to 1.6.3.X).
>=20
>  * "git send-email" can fetch the sender address from the configurati=
on
>    variable "sendmail.from" (and "sendmail.<identity>.from").
>=20
>  * "git show-branch" can color its output.
>=20
>  * "add" and "update" subcommands to "git submodule" learned --refere=
nce
>    option to use local clone with references.
>=20
>  * "git submodule update" learned --rebase option to update checked
>    out submodules by rebasing the local changes.
>=20
>  * "gitweb" can optionally use gravatar to adorn author/committer nam=
es.
>=20
I'm not really sure if it's worth to point out:

 * "git rev-parse" learned "--stop-at-non-option"

But on the other hand I sometimes want to find out the oldest release
supporting a certain feature.  Up to you to decide ...

> ---
> exec >/var/tmp/1
> echo O=3D$(git describe master)
> O=3Dv1.6.4-rc2-31-g2ceb639
> git shortlog --no-merges $O..master ^maint
Is it intended that this occurs in the mail?  (Oh, a possible symlink
attack :-)

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
