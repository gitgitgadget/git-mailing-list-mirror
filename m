From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH] tg-graph: print dependency graph like git log
	--graph
Date: Tue, 19 May 2009 20:44:02 +0200
Message-ID: <20090519184402.GA27352@pengutronix.de>
References: <1242711875-25666-1-git-send-email-bert.wesarg@googlemail.com> <20090519132854.GA9606@piper.oerlikon.madduck.net> <36ca99e90905190633l46fff979jecb61d4d0d907815@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: martin f krafft <madduck@debian.org>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org, Adam Simpkins <adam@adamsimpkins.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue May 19 20:44:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6UIS-0001Td-7v
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 20:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbZESSoI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 14:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbZESSoH
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 14:44:07 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54926 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbZESSoG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 14:44:06 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1M6UIG-0006gn-2A; Tue, 19 May 2009 20:44:04 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1M6UIE-00077T-3C; Tue, 19 May 2009 20:44:02 +0200
Content-Disposition: inline
In-Reply-To: <36ca99e90905190633l46fff979jecb61d4d0d907815@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119558>

Hi Bert,

On Tue, May 19, 2009 at 03:33:16PM +0200, Bert Wesarg wrote:
> On Tue, May 19, 2009 at 15:28, martin f krafft <madduck@debian.org> w=
rote:
> > also sprach Bert Wesarg <bert.wesarg@googlemail.com> [2009.05.19.07=
44 +0200]:
> >> @@ -62,12 +70,33 @@ git for-each-ref refs/top-bases |
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ -n "$graphviz" ]; then
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ -n "$graphviz_verbo=
se" ]; then
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type=3D"=
header"
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lines=3D=
0
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "\t=
\"$name\" ["
> >
> > You need to pass -e to echo for it to honour escape sequences. That
> > should solve Michael's problem. Alternatively, just use ^I directly=
=2E
> Correct, thanks. Looks like a feature from bash or dash to honor
> escape sequences without -e'
quoting
http://www.gnu.org/software/hello/manual/autoconf/Limitations-of-Builti=
ns.html#Limitations-of-Builtins:

	It is not possible to use `echo' portably unless both options
	and escape sequences are omitted.

=2E.. use printf instead.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
