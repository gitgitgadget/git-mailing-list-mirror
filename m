From: Petr Baudis <pasky@suse.cz>
Subject: Re: topgit patches
Date: Wed, 25 Feb 2009 22:23:09 +0100
Message-ID: <20090225212309.GM12275@machine.or.cz>
References: <20090225195856.GA12372@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "martin f. krafft" <madduck@debian.org>
To: Uwe =?iso-8859-2?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Feb 25 22:25:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcRFD-0001hD-Qx
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 22:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756059AbZBYVXQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 16:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbZBYVXP
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 16:23:15 -0500
Received: from w241.dkm.cz ([62.24.88.241]:54362 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755981AbZBYVXP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 16:23:15 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 9F3A51E4C021; Wed, 25 Feb 2009 22:23:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090225195856.GA12372@pengutronix.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111495>

  Hi,

On Wed, Feb 25, 2009 at 08:58:56PM +0100, Uwe Kleine-K=F6nig wrote:
> The following changes since commit 8c77c342166ddc6ecb3840628d89ddc5bb=
6b043b:
>   Kirill Smelkov (1):
>         tg-completion: complete options for `tg remote`
>=20
> are available in the git repository at:
>=20
>   git://git.pengutronix.de/git/ukl/topgit.git pu
>=20
> Uwe Kleine-K=F6nig (5):
>       [TOPGIT] limit rev-list in branch_contains to a single rev
>       [TOPGIT] allow working with annihilated branches
>       [TOPGIT] make tg remote idempotent
>       [TOPGIT] make creating a commit from a topgit branch a function
>       [TOPGIT] implement linearize export method
>=20
>  tg-export.sh  |   94 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-------
>  tg-remote.sh  |    6 ++--
>  tg-summary.sh |   11 ++++++-
>  tg.sh         |   19 ++++++++++-
>  4 files changed, 113 insertions(+), 17 deletions(-)
>=20
> I consider the first three as ready to pull (they form my master bran=
ch
> at the repo above).  The fourth commit is just preparing the fifth.  =
The
> fifth commit implements a new export method that I use often.  The er=
ror
> handling isn't well tested, just because I don't usually run into mer=
ge
> conflicts in my series :-)
>=20
> I look forward to comments, especially for the last commit.
>=20
> For review purposes I send the patches as a reply to this mail.

  I'm unfortunately not actively using topgit right now and I have no
time to maintain it or review patches. :-( Martin seems to be in simila=
r
situation. So, would you like push access to the main repository? ;-)

--=20
				Petr "Pasky" Baudis
The average, healthy, well-adjusted adult gets up at seven-thirty
in the morning feeling just terrible. -- Jean Kerr
