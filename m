From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Some ideas for StGIT
Date: Sat, 04 Aug 2007 20:32:34 -0700
Message-ID: <7vodhmirl9.fsf@assigned-by-dhcp.cox.net>
References: <1186163410.26110.55.camel@dv>
	<200708031914.04344.andyparkins@gmail.com>
	<1186206085.28481.33.camel@dv> <20070804055110.GP20052@spearce.org>
	<f934ve$3oi$1@sea.gmane.org> <20070805023130.GV20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 05:32:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHWrL-0001Yw-5v
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 05:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106AbXHEDch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 23:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757399AbXHEDcg
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 23:32:36 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:51069 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755760AbXHEDcg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 23:32:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070805033236.JFLP7349.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sat, 4 Aug 2007 23:32:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y3Yb1X0011kojtg0000000; Sat, 04 Aug 2007 23:32:35 -0400
In-Reply-To: <20070805023130.GV20052@spearce.org> (Shawn O. Pearce's message
	of "Sat, 4 Aug 2007 22:31:30 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54926>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> So really `revert`, `cherry-pick`, `rebase -m` (and also `am -3`
> as it also uses merge-recursive) are all the same underlying
> implementation.

Minor factual correction.  "am -3" uses merge-recursive *ONLY*
when patch does not apply, so it is often the best of both
worlds, as long as your changes do not involve renames.  And
that is what the default rebase uses.
