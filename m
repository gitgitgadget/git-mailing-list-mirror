From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH] git-bisect.txt: clarify that reset finishes bisect
Date: Sun, 10 Feb 2013 01:23:05 +0100
Message-ID: <20130210002305.GB5744@rhlx01.hs-esslingen.de>
References: <5e23d4c420f150b700dd5100bffb38d32f874200.1360439176.git.git@drmicha.warpmail.net>
 <7v8v6xw3wf.fsf@alter.siamese.dyndns.org>
 <20130209232455.GA31027@rhlx01.hs-esslingen.de>
 <7vy5ext60o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Mohr <andi@lisas.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 01:23:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4Khm-00041Z-Dd
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 01:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623Ab3BJAXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 19:23:07 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:55312 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932616Ab3BJAXG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 19:23:06 -0500
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 102)
	id 30306A2C52; Sun, 10 Feb 2013 01:23:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vy5ext60o.fsf@alter.siamese.dyndns.org>
X-Priority: none
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215887>

On Sat, Feb 09, 2013 at 03:35:35PM -0800, Junio C Hamano wrote:
> Andreas Mohr <andi@lisas.de> writes:
> > The main point of my mail was to stretch the (whether actually intended)
> > *perceived* start <-> stop symmetry
> 
> Actually, in that sense, I do no think finish is exactly a good
> wording.  The majority of use case would be to finish up after you
> found the sole culprit, so in that sense "finish" is not too bad,
> but in general, when you "reset", there is not necessarily any
> symmmetry with "start".  We should definitely not be giving you an
> illusion that there is one by using "stop" [*1*].

Yeah, of course, but the whole point was that the *user* will *directly*
and *immediately* mentally go from a bisect "start" parameter to "stop",
and end up failing to find it.
Thus the "stop" *KEYWORD* *has* to be mentioned in the man page
(even if only to then expressly state that reset is not quite about "stop"iing
things).

> *1* another reason to avoid "stop" is that it could mean "I stop
> here for now, to later come back and start digging again from
> there", which is not "reset" is about at all.

Such reasons for not listing "stop" might even be stronger
than the reason of
users being required to successfully look up the symmetric "stop" keyword.
If that was decided to be the case, then "stop" would indeed have to be
omitted in the man page - to the detriments of usability.

Thanks,

Andreas Mohr
