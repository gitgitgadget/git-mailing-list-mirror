From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] [TopGit] Portability: Don't use alternation ("|")
	in sed regular expressions
Date: Thu, 12 Mar 2009 16:09:23 +0100
Message-ID: <20090312150923.GB14521@pengutronix.de>
References: <1236837389-35687-1-git-send-email-brian.p.campbell@dartmouth.edu> <1236837389-35687-2-git-send-email-brian.p.campbell@dartmouth.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Brian Campbell <brian.p.campbell@dartmouth.edu>
X-From: git-owner@vger.kernel.org Thu Mar 12 16:18:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhmYj-0004Tx-A6
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 16:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756904AbZCLPJ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 11:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756876AbZCLPJ2
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 11:09:28 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35730 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361AbZCLPJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 11:09:27 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LhmXE-0007Qf-Sz; Thu, 12 Mar 2009 16:09:24 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LhmXD-0006Nl-BF; Thu, 12 Mar 2009 16:09:23 +0100
Content-Disposition: inline
In-Reply-To: <1236837389-35687-2-git-send-email-brian.p.campbell@dartmouth.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113074>

Hello Brian,

one more minor nitpick:

On Thu, Mar 12, 2009 at 01:56:29AM -0400, Brian Campbell wrote:
> -[ -n "$name" ] || name=3D"$(git symbolic-ref HEAD | sed 's#^refs/\(h=
eads\|top-bases\)/##')"
> +[ -n "$name" ] || name=3D"$(current_branch)"
current_branch doesn't look like the correct name.  I'd prefer
current_tgpatch is better?!  (For current_branch I would expect that
only refs/heads is stripped.)

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
