From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] [TopGit] Portability: Don't use alternation ("|")
	in sed regular expressions
Date: Thu, 12 Mar 2009 18:04:54 +0100
Message-ID: <20090312170454.GA2150@pengutronix.de>
References: <20090312152039.GA15626@pengutronix.de> <F3665462-16BC-42D6-BE28-F66CF48CEB9B@dartmouth.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Brian Campbell <brian.p.campbell@dartmouth.edu>
X-From: git-owner@vger.kernel.org Thu Mar 12 18:11:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhoMa-0001HV-Jm
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 18:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000AbZCLRFE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 13:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754331AbZCLRFD
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 13:05:03 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33542 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbZCLRFB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 13:05:01 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LhoL2-0003JM-Mj; Thu, 12 Mar 2009 18:04:56 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LhoL0-0002vQ-Bt; Thu, 12 Mar 2009 18:04:54 +0100
Content-Disposition: inline
In-Reply-To: <F3665462-16BC-42D6-BE28-F66CF48CEB9B@dartmouth.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113092>

Hello Brian,

On Thu, Mar 12, 2009 at 12:41:45PM -0400, Brian Campbell wrote:
>> IMHO we should reuse as much as possible from git.git.  For me even
>> requiring a git.git checkout to use its files would be OK.  I consid=
er
>> that even better then duplicating the relevant files.
>
> Hmm. How would the tests find your git working tree? I'd be willing t=
o =20
> start the process off at least by writing test cases for the =20
> functionality I'm changing here if I had a good idea of how to start.=
 =20
> Would it be sufficient to make something like "GIT_CHECKOUT=3D~/src/g=
it =20
> make check" work?
Yes, this would be a good start.  I would call it GIT_SRC, but that's u=
p
to you.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
