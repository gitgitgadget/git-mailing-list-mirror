From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH] tg-push: don't accept non-tgish branches to push
Date: Wed, 27 May 2009 09:23:59 +0200
Message-ID: <20090527072359.GB13559@pengutronix.de>
References: <1243374382-14828-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Marc Weber <marco-oweber@gmx.de>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed May 27 09:27:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9DXR-0007LY-Ce
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 09:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759885AbZE0HX7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2009 03:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759026AbZE0HX7
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 03:23:59 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37200 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757603AbZE0HX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 03:23:58 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1M9DUV-0006gm-Bo; Wed, 27 May 2009 09:23:59 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1M9DUV-0003XN-A9; Wed, 27 May 2009 09:23:59 +0200
Content-Disposition: inline
In-Reply-To: <1243374382-14828-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120044>

Hi Bert,

On Tue, May 26, 2009 at 11:46:22PM +0200, Bert Wesarg wrote:
> tg push dies if you give it a non-tgish branch:
>=20
> $ tg push -r push-test master
> fatal: Not a valid object name refs/top-bases/master
> fatal: ambiguous argument '^{tree}': unknown revision or path not in =
the working tree.
> Use '--' to separate paths from revisions
> fatal: Not a valid object name master:.topdeps
>=20
> Fix this.
Why not just make it work instead of dying?

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
