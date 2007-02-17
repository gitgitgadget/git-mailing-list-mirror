From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] name-rev: introduce the --ref-filter=<regex> option
Date: Sat, 17 Feb 2007 10:25:00 -0800
Message-ID: <7vmz3ctzer.fsf@assigned-by-dhcp.cox.net>
References: <20070127040618.GA14205@fieldses.org>
	<Pine.LNX.4.64.0701262022230.25027@woody.linux-foundation.org>
	<20070127044246.GC14205@fieldses.org>
	<20070127045552.GB9966@spearce.org>
	<7vhcudoxfj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701271334410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0702171502040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070217145921.GA16747@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 17 19:25:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIUFf-0003WL-0g
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 19:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993028AbXBQSZG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 13:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993030AbXBQSZG
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 13:25:06 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:42458 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993028AbXBQSZD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 13:25:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217182502.UKFW1300.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 13:25:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QiR01W00M1kojtg0000000; Sat, 17 Feb 2007 13:25:01 -0500
In-Reply-To: <20070217145921.GA16747@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 17 Feb 2007 09:59:21 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40005>

Jeff King <peff@peff.net> writes:

> On Sat, Feb 17, 2007 at 03:02:36PM +0100, Johannes Schindelin wrote:
>
>> > Instead of (or, in addition to) --tags, to use only tags for naming,
>> > you can now use --ref-filter=<regex> to specify which refs are
>> > used for naming.
>> > 
>> > Example:
>> > 
>> > 	$ git name-rev --ref-filter='/v1' 33db5f4d
>> > 	33db5f4d tags/v1.0rc1^0~1593
>> 
>> Likes, dislikes?
>
> It's a neat idea, but I wonder if you could make it even more flexible
> by simply accepting a list of possible refs, and then you could filter
> using grep, or your own more complex selection algorithm.
> Unfortunately, --stdin is already taken, but something like:
>
> git show-ref | grep tags/v1.4 | git name-rev --stdin-refs 33db5f4d

FWIW, I like that.
