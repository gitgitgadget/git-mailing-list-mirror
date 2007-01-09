From: Junio C Hamano <junkio@cox.net>
Subject: Re: a few remaining issues...
Date: Tue, 09 Jan 2007 12:22:04 -0800
Message-ID: <7vtzz0j6hf.fsf@assigned-by-dhcp.cox.net>
References: <7v7iw1hgvt.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701051453520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070105193306.GB8753@spearce.org>
	<Pine.LNX.4.63.0701091218080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 21:22:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4NU3-0001Mc-5C
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 21:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbXAIUWH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 15:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbXAIUWH
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 15:22:07 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:61698 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbXAIUWG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 15:22:06 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109202205.JDPT9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 15:22:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 98ME1W00b1kojtg0000000; Tue, 09 Jan 2007 15:21:15 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36392>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 5 Jan 2007, Shawn O. Pearce wrote:
>
>> I myself am also severly lacking in time right now.
>
> Did you have any chance to look at the patch I posted? It adds 
> "--walk-reflogs" option to the revision walker, and as long as there is 
> reflog information, traverses the commits in that order. It also shows the 
> reflog data just below the "commit" line.

What does it do when you say, for example:

	git log --walk-reflogs master..next

I couldn't make heads or tails out of the patch and did not
understand what it was trying to do.  It looked as if you were
making the log traversal machinery to walk _both_ reflog
(probably from the latest to older) and the usual ancestry.
