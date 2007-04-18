From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Custom low-level merge driver support.
Date: Wed, 18 Apr 2007 14:01:41 -0700
Message-ID: <7vfy6xflca.fsf@assigned-by-dhcp.cox.net>
References: <11768880622402-git-send-email-junkio@cox.net> <Pine.LNX.4.64.070
	4181247410.12094@racer.site> <20070418153445.GC12888@admingilde.org>
	<alpine.LFD.0.98.0704180910120.2828@ woody.linux-foundation.org>
	<7vslaxhamd.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704181136360.2828@woody.linux-foundation.org>
	<7vzm55fqyv. fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704181246160.2828@woody.linux-foundation.org>
	<7vk5w9fnjx. fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704181330050.2828@woody.linux-foundation.org>
	<Pine.LNX.4.63.0704181304220.2806@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Waitz <tali@admingilde.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: David Lang <david.lang@digitalinsight.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 23:01:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeHHd-0006W1-NB
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 23:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992694AbXDRVBn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 17:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992697AbXDRVBm
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 17:01:42 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:63747 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992694AbXDRVBm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 17:01:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418210142.IMOQ1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 17:01:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ol1h1W00D1kojtg0000000; Wed, 18 Apr 2007 17:01:41 -0400
In-Reply-To: <Pine.LNX.4.63.0704181304220.2806@qynat.qvtvafvgr.pbz> (David
	Lang's message of "Wed, 18 Apr 2007 13:09:43 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44948>

David Lang <david.lang@digitalinsight.com> writes:

> On Wed, 18 Apr 2007, Linus Torvalds wrote:
>
> I could also see having one external program that can handle the
> different types of files and/or merges. rather than having a different
> line for each would it make sense to add another variable that could
> be handed to the merge program that would tell it what sort of merge
> to do?

That was the direction I was thinking about.
