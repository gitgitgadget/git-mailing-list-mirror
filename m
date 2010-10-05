From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH] tg-patch: use pretty_tree
Date: Tue, 5 Oct 2010 09:18:49 +0200
Message-ID: <20101005071849.GH11737@pengutronix.de>
References: <1286216867-14701-1-git-send-email-bert.wesarg@googlemail.com> <1286222981-28358-1-git-send-email-bert.wesarg@googlemail.com> <AANLkTinOOzY2wk3Z89D2K8qDuHZkj65L56bHr79q2jpT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 09:18:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P31nb-00021u-RQ
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 09:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757725Ab0JEHSv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 03:18:51 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58203 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757667Ab0JEHSu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 03:18:50 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P31nV-0005YC-R2; Tue, 05 Oct 2010 09:18:49 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P31nV-0004EF-K2; Tue, 05 Oct 2010 09:18:49 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTinOOzY2wk3Z89D2K8qDuHZkj65L56bHr79q2jpT@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158169>

Hello,

On Tue, Oct 05, 2010 at 01:02:07AM +0200, Bert Wesarg wrote:
> On Mon, Oct 4, 2010 at 22:09, Bert Wesarg <bert.wesarg@googlemail.com=
> wrote:
> > @@ -46,22 +44,32 @@ base_rev=3D"$(git rev-parse --short --verify "r=
efs/top-bases/$name" 2>/dev/null)"
> >
> > =A0setup_pager
> :
> > +git diff-tree -p --stat -r $b_tree $t_tree
>=20
> There is currently no color output and I don't know if a simple
> --color suffice here.
--color=3Dauto maybe?

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
