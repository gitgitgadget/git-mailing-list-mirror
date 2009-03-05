From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: just curious: what influences a commit hash?
Date: Thu, 5 Mar 2009 10:02:21 +0100
Message-ID: <20090305090221.GA28687@pengutronix.de>
References: <20090305063632.42880@gmx.net> <1236237939.2421.38.camel@virgil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stoecher@gmx.at, git@vger.kernel.org
To: Matt Enright <awickedshimmy@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 10:03:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf9Uh-00035F-Rd
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 10:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbZCEJC2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 04:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbZCEJC1
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 04:02:27 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53819 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbZCEJC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 04:02:26 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lf9TD-0004GU-J6; Thu, 05 Mar 2009 10:02:23 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lf9TB-0007WK-Vs; Thu, 05 Mar 2009 10:02:21 +0100
Content-Disposition: inline
In-Reply-To: <1236237939.2421.38.camel@virgil>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112272>

Hi,

On Thu, Mar 05, 2009 at 02:25:39AM -0500, Matt Enright wrote:
> On Thu, 2009-03-05 at 07:36 +0100, stoecher@gmx.at wrote:
> > Hi,
> >=20
> > being new to git I did some experiments with commits looking at the=
 hashes. What I observed:
> > * The same commit (same file, same committer, same message) into di=
fferent empty repositories (git init) gives different hashes. So I assu=
me that also the time of the commit influences the hash. Is this intend=
ed? For what reason?
Yes, commit time and commit date influence the hash.

But the hashes for the corresponding trees should be the same.
Check the output of git rev-parse $commit^{tree}.

If you want to reproduce the exact same commit, you need to set
the env variables GIT_AUTHOR_DATE and GIT_COMMITTER_DATE.  (Not sure,
but GIT_AUTHOR_DATE might be handled by git am.)

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
