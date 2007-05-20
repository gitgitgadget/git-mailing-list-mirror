From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rev-list: '--indent' oneline output
Date: Sun, 20 May 2007 11:36:51 -0700
Message-ID: <7vveenl4u4.fsf@assigned-by-dhcp.cox.net>
References: <20070518215603.GS15393@fieldses.org>
	<1179676829751-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bfields@fieldses.org,
	torvalds@linux-foundation.org, junkio@cox.net
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun May 20 20:37:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpqHM-00045W-Qe
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757809AbXETSgy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757792AbXETSgy
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:36:54 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:40046 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757567AbXETSgx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:36:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520183653.PWYK19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 20 May 2007 14:36:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1Wcs1X0051kojtg0000000; Sun, 20 May 2007 14:36:52 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47884>

Steffen Prohaska <prohaska@zib.de> writes:

> Summaries in oneline output are indented to show the location of
> parents in merge commits. Indentation level is computed as the
> smallest sum of parent locations along all paths that reach the
> commit.
>
> As a result, the output of
>     git-rev-list --pretty=oneline --topo-order --indent
> is formatted in a way that resembles merge summaries. All commits that
> were pulled from a branch are indented with one additional space below
> the summary of the merge commit.

I would have expected this kind of UI level tweak to be done not
as a rev-list feature, but the subject of the e-mail to read
something like "--pretty=oneline: allow indentation levels",
i.e. wouldn't the feature apply not just rev-list but also
git-log?
