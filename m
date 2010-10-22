From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH] Clarify tg-log note
Date: Fri, 22 Oct 2010 10:43:58 +0200
Message-ID: <20101022084358.GE19834@pengutronix.de>
References: <0ecc03501a8282e7c19011ca1cbc138dec502390.1287734568.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Per Cederqvist <ceder@lysator.liu.se>, git@vger.kernel.org,
	pasky@suse.cz, martin f krafft <madduck@madduck.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 10:44:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9DER-0007Mi-9y
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 10:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352Ab0JVIoD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 04:44:03 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52621 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab0JVIoB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 04:44:01 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P9DEF-0004YO-Um; Fri, 22 Oct 2010 10:43:59 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P9DEE-0002OK-L8; Fri, 22 Oct 2010 10:43:58 +0200
Content-Disposition: inline
In-Reply-To: <0ecc03501a8282e7c19011ca1cbc138dec502390.1287734568.git.bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159665>

On Fri, Oct 22, 2010 at 10:03:36AM +0200, Bert Wesarg wrote:
> ---
>  README |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/README b/README
> index 5ca0424..348f515 100644
> --- a/README
> +++ b/README
> @@ -520,10 +520,15 @@ tg log
>  ~~~~~~
>  	Prints the git log of the named topgit branch.
> =20
> -	Note: if you have shared the TopGit branch, this command
> -	only lists the commits that were made in the current
> -	repository, so you will not see work done by your
> -	collaborators.
> +	Note: that you don't see changes made by the remote
> +	when the topic diverged at both sides. Any 'fast-forward'
> +	updates from remote topics will shown up. This could also
> +	mean, that you 'lose' all your history, because the remote
> +	made the merge and you do only a 'fast-forward'. Than you
> +	will see only his history from now on. So its best to prevent
> +	diverging development if you like to 'preserve' the full
> +	history. Please note, that 'lose' and 'preserve' only relates
> +	to when showing the log.
Hmm, I see your intention, but I wonder if it wouldn't be enough to say=
:

Note: if you have merged changes from a different repository, this
command might not list all interesting commits.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
