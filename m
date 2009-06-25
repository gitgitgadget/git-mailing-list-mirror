From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote: fixed missing .uploadpack usage for show command
Date: Thu, 25 Jun 2009 11:32:17 -0700
Message-ID: <7vmy7wcgge.fsf@alter.siamese.dyndns.org>
References: <20090625090036.GA32650@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Frey <cdfrey@foursquare.net>
X-From: git-owner@vger.kernel.org Thu Jun 25 20:32:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJtkI-0005OC-FG
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 20:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbZFYScP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 14:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbZFYScP
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 14:32:15 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:53112 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbZFYScO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 14:32:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090625183217.VFMJ25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 25 Jun 2009 14:32:17 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8JYH1c0094aMwMQ03JYHDw; Thu, 25 Jun 2009 14:32:17 -0400
X-VR-Score: -130.00
X-Authority-Analysis: v=1.0 c=1 a=C0EaV7SPPR0A:10 a=xp1XZONDAAAA:8
 a=2sPNTWWvntwGMlOfXoUA:9 a=3CdS1A_l_txkgYw6WMp1IhNnriYA:4 a=kMKJStmIQngA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122229>

Chris Frey <cdfrey@foursquare.net> writes:

> When using 'git remote show <name>', the remote HEAD check
> did not use the uploadpack configuration setting.
>
> Signed-off-by: Chris Frey <cdfrey@foursquare.net>

Thanks.

"X did not use Y" may be a good statement of the fact.  From the patch
text it can be seen that a NULL used to be passed and the patch makes it
to pass states->remote instead, so "This patch make X use Y", even though
left unsaid in the message, can be seen.

But it does not answer a more important question.  How was it a problem
that "X did not use Y"?

People who followed a recent discussion know the answer to this question,
but ones who read this in the "git log" output 6 months down the line will
not.  Please make a habit of justifying the change by stating "why".

"X should have used Y because of such and such reasons, but it didn't.
Instead of showing the correct result W, it gave Z, which may happen to be
the same as W in default settings but otherwise is wrong."
