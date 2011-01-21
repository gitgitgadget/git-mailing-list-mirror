From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: cannot fetch arm git tree
Date: Fri, 21 Jan 2011 14:47:28 +0100
Message-ID: <20110121134728.GO14956@pengutronix.de>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com>
 <20110116092315.GA27542@n2100.arm.linux.org.uk>
 <20110116110819.GG6917@pengutronix.de>
 <AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com>
 <20110116134248.GD27542@n2100.arm.linux.org.uk>
 <4D398C43.1000306@vollmann.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jello huang <ruifeihuang@gmail.com>, git@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Detlef Vollmann <dv@vollmann.ch>
X-From: git-owner@vger.kernel.org Fri Jan 21 14:48:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgHL2-0004JI-Gs
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 14:47:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482Ab1AUNrf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Jan 2011 08:47:35 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54791 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204Ab1AUNre (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 08:47:34 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1PgHKq-0003zQ-VD; Fri, 21 Jan 2011 14:47:28 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1PgHKq-0000YM-Df; Fri, 21 Jan 2011 14:47:28 +0100
Content-Disposition: inline
In-Reply-To: <4D398C43.1000306@vollmann.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165369>

Hi Detlef,

On Fri, Jan 21, 2011 at 02:38:11PM +0100, Detlef Vollmann wrote:
> On 01/16/11 14:42, Russell King - ARM Linux wrote:
> >Let's say you already have a copy of my tree from a month ago, and L=
inus
> >has pulled some work from me into his tree, and repacked his tree in=
to one
> >single pack file.  At the moment, the largest pack file from Linus i=
s
> >400MB plus a 50MB index.
> >
> >You already have most of the contents of that 400MB pack file, but i=
f
> >you're missing even _one_ object which is contained within it, git w=
ill
> >have to download the _entire_ 400MB pack file and index file to retr=
ieve
> >it.
> I thought this has changed with "smart http" in git 1.6.6.
> Am I missing something?
Well, not all http repos offer smart http.  E.g. Russell doesn't[1],
probably because the serving machine doesn't have the power to nice
serve a repo via git:// or smart http://.

Best regards
Uwe

[1] I didn't recheck though

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
