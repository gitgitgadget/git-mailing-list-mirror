From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH 3/6] tg-files: list files changed by the topic
	branch
Date: Mon, 4 Oct 2010 08:59:18 +0200
Message-ID: <20101004065918.GL28679@pengutronix.de>
References: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com> <1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com> <1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com> <1286141157-30422-3-git-send-email-bert.wesarg@googlemail.com> <20101003220330.GE28679@pengutronix.de> <AANLkTimLgWKPBjVAni=t6EK4Yr9FyJZa=Yk01SeMcwA1@mail.gmail.com> <20101004064747.GJ28679@pengutronix.de> <AANLkTi=-2fHW30vxvc8q30KPfE0YWxUfuqzvk15fmtO6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 08:59:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2f1B-000722-3F
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 08:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705Ab0JDG7U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 02:59:20 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40583 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab0JDG7T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 02:59:19 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2f14-0005Y6-SC; Mon, 04 Oct 2010 08:59:18 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2f14-0003jI-G3; Mon, 04 Oct 2010 08:59:18 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTi=-2fHW30vxvc8q30KPfE0YWxUfuqzvk15fmtO6@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157992>

Hi Bert,

On Mon, Oct 04, 2010 at 08:50:11AM +0200, Bert Wesarg wrote:
> 2010/10/4 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> > On Mon, Oct 04, 2010 at 08:43:52AM +0200, Bert Wesarg wrote:
> >> git diff-tree --name-only $(pretty_tree refs/top-bases/$name)
> >> $(pretty_tree $name)
> > That's what I thought after sending the mail and shuting down my ma=
chine
> > :-)
>=20
> But what about the -w and -i option now?
=46or these we need pretty_tree -i and pretty_tree -w?!

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
