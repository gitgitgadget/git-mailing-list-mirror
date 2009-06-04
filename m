From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH] pre-commit: check .topdeps for valid branches
Date: Thu, 4 Jun 2009 11:34:56 +0200
Message-ID: <20090604093456.GA14548@pengutronix.de>
References: <1243592316-10820-1-git-send-email-bert.wesarg@googlemail.com> <1243976962-10486-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 11:35:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC9Lr-0001VU-02
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 11:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989AbZFDJe6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jun 2009 05:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753608AbZFDJe5
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 05:34:57 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39675 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbZFDJe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 05:34:56 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1MC9Le-0005Mj-5k; Thu, 04 Jun 2009 11:34:58 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1MC9Lc-0004IB-Q1; Thu, 04 Jun 2009 11:34:56 +0200
Content-Disposition: inline
In-Reply-To: <1243976962-10486-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120687>

Hi Bert,

> diff --git a/hooks/pre-commit.sh b/hooks/pre-commit.sh
> index 8e05a4e..1eae2e8 100644
> --- a/hooks/pre-commit.sh
> +++ b/hooks/pre-commit.sh
> @@ -52,6 +52,9 @@ BEGIN      { in_hunk =3D 0; }
>  /^[^@ +-]/ { in_hunk =3D 0; }
>  ' |
>  	while read newly_added; do
> +		ref_exists "$newly_added" ||
> +			die "Invalid branch as dependent: $newly_added"
> +
>  		# deps can be non-tgish but we can't run recurse_deps() on them
>  		ref_exists "refs/top-bases/$newly_added" ||
>  			continue
> --=20
> tg: (0f8cd77..) bw/check-valid-deps (depends on: bw/check-for-dep-cyc=
le)
this patch doesn't apply to my branch.  I'd say you didn't send out
bw/check-for-dep-cycle (or I oversaw it).

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
