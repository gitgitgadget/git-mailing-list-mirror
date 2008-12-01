From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [TOPGIT] Resolving conflicts
Date: Mon, 1 Dec 2008 13:18:19 +0100
Message-ID: <20081201121819.GB13495@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Uwe Kleine-Koenig <ukl@pengutronix.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 13:20:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L77l9-0003nm-JG
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 13:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbYLAMSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 07:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbYLAMSV
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 07:18:21 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55582 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbYLAMSV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 07:18:21 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <sha@pengutronix.de>)
	id 1L77jH-0004Qw-Nr; Mon, 01 Dec 2008 13:18:19 +0100
Received: from sha by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <sha@pengutronix.de>)
	id 1L77jH-0000N1-61; Mon, 01 Dec 2008 13:18:19 +0100
Content-Disposition: inline
X-Sent-From: Pengutronix Entwicklungszentrum Nord - Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Impressum: Pengutronix - Linux Solutions for Science and Industry
	Handelsregister:  Amtsgericht Hildesheim, HRA 2686 Hannoversche
	Str. 2, 31134 Hildesheim, Germany Phone: +49-5121-206917-0 |  Fax:
	+49-5121-206917-9 Inhaber: Dipl.-Ing. Robert Schwebel
X-Message-Flag: See Message Headers for Impressum
X-Uptime: 12:33:09 up 4 days, 18:28, 14 users,  load average: 4.91, 4.84,
	2.81
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102027>

Hi,

I'm going my first steps with topgit and this tool seems to add the
missing link for my git experience.

I have a little problem with conflicts resulting from different topgit
branches though. What I'm trying to do is this (taken from the topgit
README):

## Create another topic branch depending on two others non-trivially
$ tg create t/whatever t/revlist/author-fixed t/gitweb/nifty-links
tg: Creating t/whatever base from t/revlist/author-fixed...
tg: Merging t/whatever base with t/gitweb/nifty-links...
Merge failed!
tg: Please commit merge resolution and call: tg create
tg: It is also safe to abort this operation using `git reset --hard`
tg: but please remember you are on the base branch now;
tg: you will want to switch to a different branch.
$ ..resolve..

After resolving I exported t/whatever to a quilt series. The series does
not apply because it does not contain the conflict resolution. If I export
to a git branch instead the merge is a commit of its own, resulting in a
non linear history.
Any chance to fix this or am I missing something?

Another thing is that the exported branch contains an empty commit
resulting from t/whatever (and a corresponding empty patch when exported
as a quilt series)

Best regards,
  Sascha

-- 
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
