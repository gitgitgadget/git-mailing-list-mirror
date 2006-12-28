From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 9/11] Allow merging bare trees in merge-recursive.
Date: Thu, 28 Dec 2006 00:08:14 -0800
Message-ID: <7vk60cxx1t.fsf@assigned-by-dhcp.cox.net>
References: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
	<20061228073523.GI17867@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 09:08:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzqJQ-0003i4-FA
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 09:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWL1IIR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 03:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbWL1IIR
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 03:08:17 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:60262 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964947AbWL1IIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 03:08:16 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061228080815.EOZJ2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Dec 2006 03:08:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 488V1W00B1kojtg0000000; Thu, 28 Dec 2006 03:08:29 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35536>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> To support wider use cases, such as from within `git am -3`, the
> merge-recursive utility needs to accept not just commit-ish but
> also tree-ish as arguments on its command line.

Yes, this was one of the things I did not like about
merge-recursive (I think the original Python one may have
accepted three trees but I am not sure --- it's so looong ago).
