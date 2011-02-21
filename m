From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: gitk error: can't read "pending_select": no such variable
Date: Mon, 21 Feb 2011 17:32:08 +0100
Message-ID: <20110221163208.GA9086@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 21 17:32:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrYgJ-0005tv-US
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 17:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708Ab1BUQcJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 11:32:09 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55442 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab1BUQcI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 11:32:08 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1PrYgC-0006LJ-1u
	for git@vger.kernel.org; Mon, 21 Feb 2011 17:32:08 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1PrYgC-0002SJ-0j
	for git@vger.kernel.org; Mon, 21 Feb 2011 17:32:08 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167493>

Hello,

I have no reliable reproduction recipe for this message, but it seems t=
o
happen after Ctrl+F5 with changes.

Details are:

	can't read "pending_select": no such variable
	can't read "pending_select": no such variable
	    while executing
	"rowofcommit $pending_select"
	    (procedure "layoutmore" line 13)
	    invoked from within
	"layoutmore"
	    (procedure "chewcommits" line 5)
	    invoked from within
	"chewcommits"
	    ("eval" body line 1)
	    invoked from within
	"eval $script"
	    (procedure "dorunq" line 11)
	    invoked from within
	"dorunq"
	    ("after" script)

and that happens with Debian's gitk 1:1.7.2.3-2.2

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
