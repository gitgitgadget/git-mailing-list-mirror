From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] glossary: stop generating automatically
Date: Sun, 18 Mar 2007 21:32:49 -0700
Message-ID: <7vaby9n98u.fsf@assigned-by-dhcp.cox.net>
References: <117427428145-git-send-email-> <1174274281887-git-send-email->
	<11742742813855-git-send-email-> <1174274281258-git-send-email->
	<11742742811304-git-send-email->
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "J. Bruce Fields" <bfields@citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Mar 19 05:32:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT9YE-0003lb-At
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 05:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbXCSEcw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 00:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbXCSEcv
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 00:32:51 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:64598 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbXCSEcv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 00:32:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070319043251.UGTQ18070.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 00:32:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cUYq1W00E1kojtg0000000; Mon, 19 Mar 2007 00:32:50 -0400
In-Reply-To: <11742742811304-git-send-email-> (J. Bruce Fields's message of
	"Sun, 18 Mar 2007 23:17:59 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42585>

"J. Bruce Fields" <bfields@citi.umich.edu> writes:

> From: J. Bruce Fields <bfields@citi.umich.edu>
>
> The sort_glossary.pl script sorts the glossary, checks for duplicates,
> and automatically adds cross-references.
>
> But it's not so hard to do all that by hand, and sometimes the automatic
> cross-references are a little wrong; so let's run the script one last
> time and check in its output.

This initially raised my eyebrow but after looking at the next
patch, I tend to agree why automated stuff needs to be lot
better, or we forget about automation and maintain that by
hand.

Dscho, preference?
