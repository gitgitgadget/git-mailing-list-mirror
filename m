From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH v2 3/3] tg-push: handle non-tgish branches
Date: Thu, 28 May 2009 09:24:26 +0200
Message-ID: <20090528072426.GD12151@pengutronix.de>
References: <1243412195-29841-1-git-send-email-bert.wesarg@googlemail.com> <1243412221-2844-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Marc Weber <marco-oweber@gmx.de>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 28 09:24:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Zyc-0005uU-7K
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 09:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbZE1HY0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2009 03:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbZE1HY0
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 03:24:26 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58413 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbZE1HYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 03:24:25 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1M9ZyU-0001tK-Mx; Thu, 28 May 2009 09:24:26 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1M9ZyU-0003Fx-Ko; Thu, 28 May 2009 09:24:26 +0200
Content-Disposition: inline
In-Reply-To: <1243412221-2844-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120165>

Hi,

> -	# deps
> -	$recurse_deps &&
> +	# deps but only if branch is tgish
> +	$recurse_deps && [ -n "$_dep_is_tgish" ] &&
>  		no_remotes=3D1 recurse_deps push_branch "$name"
OK, wait for 1-2/3.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
