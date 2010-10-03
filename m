From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH 4/6] tg-prev/tg-next: commands to explore
	dependencies
Date: Sun, 3 Oct 2010 23:55:20 +0200
Message-ID: <20101003215520.GC28679@pengutronix.de>
References: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com> <1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com> <1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com> <1286141157-30422-3-git-send-email-bert.wesarg@googlemail.com> <1286141157-30422-4-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>
To: Per Cederqvist <ceder@lysator.liu.se>,
	Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 23:56:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2WXl-0000Id-R5
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 23:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451Ab0JCVz1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 17:55:27 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46707 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754900Ab0JCVzX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 17:55:23 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2WWf-00021K-Pa; Sun, 03 Oct 2010 23:55:21 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2WWe-0001pQ-VX; Sun, 03 Oct 2010 23:55:20 +0200
Content-Disposition: inline
In-Reply-To: <1286141157-30422-4-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157935>

Hi,

On Sun, Oct 03, 2010 at 11:25:55PM +0200, Bert Wesarg wrote:
> Two new commands to explore the dependencies of TopGit branches:
>=20
>   a) tg prev [-i | -w] [NAME]
>      outputs the dependencies of NAME
>=20
>   b) tg next [-i | -w] [NAME]
>      outputs branches which depends on NAME
I wonder if this is somehow mergable with Per's checkout [next|prev].
(contained in git://repo.or.cz/topgit/tsort.git, t/checkout)

What do you think?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
