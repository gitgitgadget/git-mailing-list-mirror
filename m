From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit] aborting tg create leafs deleted .top* files in index
Date: Fri, 27 Feb 2009 11:59:15 +0100
Message-ID: <20090227105915.GA20932@pengutronix.de>
References: <36ca99e90902061103u24d4f38eua52d9259cb8d34d1@mail.gmail.com> <36ca99e90902262247q783f8ce1j20bdc971cfc22948@mail.gmail.com> <20090227083211.GA10326@pengutronix.de> <36ca99e90902270040g6ae29c69t1d958fda3dfce960@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>,
	martin f krafft <madduck@debian.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 12:00:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld0SW-00035l-4u
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 12:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbZB0K7V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 05:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbZB0K7U
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 05:59:20 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56422 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbZB0K7T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 05:59:19 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1Ld0R3-0000Es-Ad; Fri, 27 Feb 2009 11:59:17 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Ld0R1-0005SG-SS; Fri, 27 Feb 2009 11:59:15 +0100
Content-Disposition: inline
In-Reply-To: <36ca99e90902270040g6ae29c69t1d958fda3dfce960@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111662>

On Fri, Feb 27, 2009 at 09:40:45AM +0100, Bert Wesarg wrote:
> On Fri, Feb 27, 2009 at 09:32, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > What about the patch below? =A0It seems git-checkout from 1.6.x mer=
ges the
> > changes done to the newly checked out branch.
> Thank you very much. It works here as expected.
After some more thought I don't think this is the right fix.  While
throwing away changes to .top* looks OK, doing the same for other
changes seems not right to me.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
