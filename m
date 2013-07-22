From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: git log anomalities
Date: Mon, 22 Jul 2013 11:08:54 +0200
Message-ID: <20130722090854.GA22222@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kernel@pengutronix.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 22 11:09:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1C7G-0005XW-FY
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 11:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756813Ab3GVJJF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jul 2013 05:09:05 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47881 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756791Ab3GVJJE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 05:09:04 -0400
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1V1C6w-00039k-Tf; Mon, 22 Jul 2013 11:08:54 +0200
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1V1C6w-0001Bo-EG; Mon, 22 Jul 2013 11:08:54 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:21e:67ff:fe11:9c5c
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230968>

Hello,

today I looked at the changes to drivers/net/ethernet/freescale/fec.c i=
n
the kernel since v3.8 using

	git log --stat v3.8.. --full-diff -- drivers/net/ethernet/freescale/fe=
c.c

which looks as expected. But when I added --graph the diffstats change.
E.g. for 793fc0964be1921f15a44be58b066f22b925d90b it changes from:

 drivers/net/ethernet/freescale/Makefile   |    3 +-
 drivers/net/ethernet/freescale/fec.c      | 1966 ---------------------=
--------
 drivers/net/ethernet/freescale/fec_main.c | 1966 +++++++++++++++++++++=
++++++++
 drivers/net/ethernet/freescale/fec_ptp.c  |    3 -
 4 files changed, 1968 insertions(+), 1970 deletions(-)

to

|  Documentation/devicetree/bindings/net/dsa/dsa.txt |   91 +
|  .../bindings/net/marvell-orion-mdio.txt           |    3 +
|  Documentation/networking/ip-sysctl.txt            |   35 +-
|  MAINTAINERS                                       |    2 +-
|  arch/arm/net/bpf_jit_32.c                         |    5 +-
|  arch/arm/plat-orion/common.c                      |   54 +-
|  arch/powerpc/net/bpf_jit_comp.c                   |   12 +-
|  ...
|  404 files changed, 15373 insertions(+), 8563 deletions(-)

Is that a bug, or a feature I don't understand?

(I'm using Debian's 1:1.8.3.2-1)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
