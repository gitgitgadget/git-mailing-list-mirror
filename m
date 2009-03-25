From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH] hooks/pre-commit.sh: fix it again
Date: Wed, 25 Mar 2009 22:44:54 +0100
Message-ID: <20090325214454.GA14887@pengutronix.de>
References: <1237981384-7857-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 22:46:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmave-0000Mc-6M
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766AbZCYVo7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 17:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753900AbZCYVo7
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:44:59 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36535 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbZCYVo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 17:44:58 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lmau8-0001h7-9A; Wed, 25 Mar 2009 22:44:56 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lmau6-0003sJ-OJ; Wed, 25 Mar 2009 22:44:54 +0100
Content-Disposition: inline
In-Reply-To: <1237981384-7857-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114679>

Hello,

>  if head_=3D$(git symbolic-ref -q HEAD); then
>  	case "$head_" in
>  		refs/heads/*)
> -			git rev-parse -q --verify "${head_/#refs\/heads/refs\/top-bases}"=
 >/dev/null || exit 0;;
> +			git rev-parse -q --verify "${head_/refs\/heads/refs\/top-bases}" =
>/dev/null || exit 0;;
			git rev-parse -q --verify "refs/top-bases${head_#refs/heads}" >/dev/=
null || exit 0;;

should work.

But I'm too tired to make a patch now.  That probably would only result
in more crap...

Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
