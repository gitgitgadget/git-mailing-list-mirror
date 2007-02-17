From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] name-rev: introduce the --ref-filter=<pattern> option
Date: Sat, 17 Feb 2007 10:47:24 -0800
Message-ID: <7vabzctydf.fsf@assigned-by-dhcp.cox.net>
References: <20070127040618.GA14205@fieldses.org>
	<Pine.LNX.4.64.0701262022230.25027@woody.linux-foundation.org>
	<20070127044246.GC14205@fieldses.org>
	<20070127045552.GB9966@spearce.org>
	<7vhcudoxfj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701271334410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0702171502040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vlkiwvfy5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702171921130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 17 19:47:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIUb1-0004gX-44
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 19:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbXBQSrZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 13:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbXBQSrZ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 13:47:25 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:49001 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbXBQSrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 13:47:25 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217184724.UWMS1300.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 13:47:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QinP1W00B1kojtg0000000; Sat, 17 Feb 2007 13:47:24 -0500
In-Reply-To: <Pine.LNX.4.63.0702171921130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 17 Feb 2007 19:22:35 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40008>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Instead of (or, in addition to) --tags, to use only tags for naming,
> you can now use --ref-filter=<patter> to specify a shell pattern
> which the refs must match to be used for naming.
>
> Example:
>
> 	$ git name-rev --ref-filter=*v1* 33db5f4d
> 	33db5f4d tags/v1.0rc1^0~1593

I am sorry I did not mention earlier, but doesn't --ref-filter
sound too long?  How about '--refs=*v1*'?

No need to resend, just Ack / Nack would do.
