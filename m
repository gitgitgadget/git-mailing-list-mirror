From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] [TopGit] Portability: Don't use alternation ("|")
	in sed regular expressions
Date: Sat, 14 Mar 2009 13:47:48 +0100
Message-ID: <20090314124748.GA26082@pengutronix.de>
References: <78BA729B-0026-45D0-96FC-330700519AAB@dartmouth.edu> <20090312152039.GA15626@pengutronix.de> <20090312152630.GA26379@piper.oerlikon.madduck.net> <7vvdqcejj2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: martin f krafft <madduck@madduck.net>,
	Brian Campbell <brian.p.campbell@dartmouth.edu>,
	git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 13:49:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiTJ2-0000Gk-7z
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 13:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbZCNMsH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Mar 2009 08:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbZCNMsF
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 08:48:05 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55333 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbZCNMsD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 08:48:03 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LiTHN-0003rr-IL; Sat, 14 Mar 2009 13:47:53 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LiTHI-0008SH-PD; Sat, 14 Mar 2009 13:47:48 +0100
Content-Disposition: inline
In-Reply-To: <7vvdqcejj2.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113250>

Hello,

On Fri, Mar 13, 2009 at 10:54:41PM -0700, Junio C Hamano wrote:
> martin f krafft <madduck@madduck.net> writes:
>=20
> > also sprach Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [20=
09.03.12.1620 +0100]:
> >> IMHO we should reuse as much as possible from git.git.  For me eve=
n
> >> requiring a git.git checkout to use its files would be OK.  I cons=
ider
> >> that even better then duplicating the relevant files.
> >
> > Maybe we could even start to think about integrating TopGit back
> > into git.git?
>=20
> Heh, it would need massive style fixes before that happens. I am fair=
ly
> picky on shell script styles.
me, too.  That's one of my todo list items, independently from martin's
suggestion.  (More to the bottom of that list, though.)

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
