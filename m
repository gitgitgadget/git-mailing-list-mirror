From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: name-rev does not show the shortest path
Date: Thu, 23 Aug 2007 12:38:17 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070823103817.GF6573@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 12:38:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOA5Q-0002w0-95
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 12:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758145AbXHWKiU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 23 Aug 2007 06:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758815AbXHWKiU
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 06:38:20 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:49863 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757011AbXHWKiT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 06:38:19 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IOA4w-00004L-IP
	for git@vger.kernel.org; Thu, 23 Aug 2007 12:38:18 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l7NAcHS8009254
	for <git@vger.kernel.org>; Thu, 23 Aug 2007 12:38:17 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l7NAcHF6009253
	for git@vger.kernel.org; Thu, 23 Aug 2007 12:38:17 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56492>

Hello,

I want to check to which kernel version I need to upgrade to get a
certain feature.  For my case it was introduced in 0567a0c022d5b.

	zeisberg@cassiopeia:~/gsrc/linux-2.6$ rev=3D0567a0c022d5b343370a343121=
f38fd89925de55

	zeisberg@cassiopeia:~/gsrc/linux-2.6$ git name-rev --tags $rev
	0567a0c022d5b343370a343121f38fd89925de55 tags/v2.6.22~1686^2~1^3~5

	zeisberg@cassiopeia:~/gsrc/linux-2.6$ git name-rev --refs=3D*-rc1 $rev
	0567a0c022d5b343370a343121f38fd89925de55 tags/v2.6.22-rc1~1009^2~1^3~5

I don't now the underlaying algorithm, maybe it's to get a short string=
?

Anyhow I want to know the earliest tag that includes this patch?  Is
there something I missed?

I remember there was a similar discussion regarding describe.

BTW: gitk does the right thing, it says:

	Follows: v2.6.21-rc7
	Precedes: v2.6.22-rc1

(called with=20

	zeisberg@cassiopeia:~/gsrc/linux-2.6$ gitk 0567a0c022d5b343370a343121f=
38fd89925de55^..0567a0c022d5b343370a343121f38fd89925de55
)

I didn't check how it does that though.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

exit vi, lesson I:
: q ! <CR>
