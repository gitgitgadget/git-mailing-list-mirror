From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH 01/10] cat_file: take -i/-w parameters
Date: Sat, 9 Oct 2010 22:32:19 +0200
Message-ID: <20101009203219.GN29673@pengutronix.de>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Oct 09 22:32:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4g5v-0007sX-Bu
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760540Ab0JIUcX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Oct 2010 16:32:23 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51830 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756891Ab0JIUcW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 16:32:22 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P4g5d-000472-DC; Sat, 09 Oct 2010 22:32:21 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P4g5b-0000No-NY; Sat, 09 Oct 2010 22:32:19 +0200
Content-Disposition: inline
In-Reply-To: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158605>

Hi Bert,

On Fri, Oct 08, 2010 at 09:57:59AM +0200, Bert Wesarg wrote:
> This changes the way how cat_file selects the source of the file. It
> accepts an optional parameter which is either -i or -w and will react=
 on this
> instead of the branch name. tg-patch is updated accordingly and can n=
ow
> accepts the current branch name as argument with -i or -w given.
>=20
> cat_file was also broken for the worktree case when we are not in the=
 top level.
>=20
> Also, tg-patch allowed to be on the top-base branch, but -i and -w do=
esn't
> make sense there too.
>=20
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
doesn't apply anymore.  Do you care to fix and resend?  I think it's
your own change to cat_file BTW ... :-)


> ---
>=20
> I will probably never understand why TopGit accepts to be on a top-ba=
se branch.
/me shrugs.

> I will probably never understand why TopGit not changes the cwd to th=
e top level.
I can imagine that strange things can happen then, but I don't have an
example.

> I will probably never understand why TopGit does not use the git-sh-s=
etup.sh.
I'm not sure this works in all cases.  And I think it's not sensibe as
we don't have control over this file.  And what if it starts providing =
a
function with the same name as one of our's?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
