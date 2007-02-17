From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] name-rev: introduce the --ref-filter=<regex> option
Date: Sat, 17 Feb 2007 09:42:26 -0800
Message-ID: <7vlkiwvfy5.fsf@assigned-by-dhcp.cox.net>
References: <20070127040618.GA14205@fieldses.org>
	<Pine.LNX.4.64.0701262022230.25027@woody.linux-foundation.org>
	<20070127044246.GC14205@fieldses.org>
	<20070127045552.GB9966@spearce.org>
	<7vhcudoxfj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701271334410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0702171502040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 17 18:42:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HITZv-0002D1-U5
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 18:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992970AbXBQRm2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 12:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992972AbXBQRm2
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 12:42:28 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61605 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992970AbXBQRm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 12:42:27 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217174227.TPKR1300.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 12:42:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QhiS1W00S1kojtg0000000; Sat, 17 Feb 2007 12:42:27 -0500
In-Reply-To: <Pine.LNX.4.63.0702171502040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 17 Feb 2007 15:02:36 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39995>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Instead of (or, in addition to) --tags, to use only tags for naming,
>> you can now use --ref-filter=<regex> to specify which refs are
>> used for naming.
>> 
>> Example:
>> 
>> 	$ git name-rev --ref-filter='/v1' 33db5f4d
>> 	33db5f4d tags/v1.0rc1^0~1593
>
> Likes, dislikes?

"Describe these objects in terms of these refs -- do not use any
other random refs, even if they are closer" was sorely lacking
for it to be usable for me, so I like what it does.

When we talk about path and path-like things including refs
I think we consistently use fnmatch not regexp.  At least I
think we try to.
