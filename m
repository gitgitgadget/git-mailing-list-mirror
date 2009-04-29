From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: (topgit question) deleting a dependency
Date: Wed, 29 Apr 2009 10:24:10 +0200
Message-ID: <20090429082410.GB18521@pengutronix.de>
References: <slrngvdgo4.kr7.sitaramc@sitaramc.homelinux.net> <20090428094138.GB9415@piper.oerlikon.madduck.net> <20090428204018.GA17722@pengutronix.de> <slrngvf976.65c.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 10:24:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz55o-0006Ug-UG
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 10:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbZD2IYO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 04:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbZD2IYN
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 04:24:13 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51181 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbZD2IYL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 04:24:11 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lz55O-00080n-M5; Wed, 29 Apr 2009 10:24:10 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lz55O-0004so-Fn; Wed, 29 Apr 2009 10:24:10 +0200
Content-Disposition: inline
In-Reply-To: <slrngvf976.65c.sitaramc@sitaramc.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117867>

Hello Sitaram,

[mmh, your mail didn't have me in the addressees, wonder why.]

On Wed, Apr 29, 2009 at 12:52:54AM +0000, Sitaram Chamarty wrote:
> On 2009-04-28, Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wr=
ote:
>=20
> > On Tue, Apr 28, 2009 at 11:41:38AM +0200, martin f krafft wrote:
> >> also sprach Sitaram Chamarty <sitaramc@gmail.com> [2009.04.28.1049=
 +0200]:
> >> [...]
> >> > I know "tg depend" only has the "add" subcommand right now,
> >> > but is there a manual way of getting the effect of a
> >> > hypothetical "tg depend remove"?
> >>=20
> >> No, not yet, see http://bugs.debian.org/505303 for further
> >> discussion on the issue.
> > But note that you might get some problems after doing that.  See
> >
> > 	http://thread.gmane.org/gmane.comp.version-control.git/116193/focu=
s=3D116205
>=20
> Hello Uwe,
>=20
> This is a little beyond my comprehension :(  However, this
> is also why I am limiting myself to
>=20
>   - a single level of dependencies in tg, (master -->
>     multiple t/something --> t/all), and
>=20
>   - no changes of its own in t/all
>=20
> When any of the t/something graduates to master, t/all will
> be blown away (safe, since it has no changes of its own) and
What makes you think it will "be blown away"?  Or alternatively, what d=
o
you mean saying that?  I often use the same approach and I never had th=
e
feeling anything is blown away.  If upstream uses your t/something patc=
h
it just merges into t/something making it empty without changing the
corresponding tree (assuming master contains no other changes).  Then
when t/something is merged into t/all nothing happens, because
t/something's tree didn't change.

So the only thing is that t/all depends on an empty tg-branch.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
