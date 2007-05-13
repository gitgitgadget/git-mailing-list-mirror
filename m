From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] git-svn: fix segfaults due to initial SVN pool being cleared
Date: Sun, 13 May 2007 11:17:44 -0700
Message-ID: <7virawtwon.fsf@assigned-by-dhcp.cox.net>
References: <11790434841909-git-send-email-normalperson@yhbt.net>
	<11790434862131-git-send-email-normalperson@yhbt.net>
	<20070513150530.GA29082@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun May 13 20:17:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnIdk-0005W4-6W
	for gcvg-git@gmane.org; Sun, 13 May 2007 20:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbXEMSRq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 14:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757457AbXEMSRq
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 14:17:46 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:57375 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbXEMSRp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 14:17:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070513181744.TNUI13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 13 May 2007 14:17:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id yiHk1W00E1kojtg0000000; Sun, 13 May 2007 14:17:44 -0400
In-Reply-To: <20070513150530.GA29082@artemis> (Pierre Habouzit's message of
	"Sun, 13 May 2007 17:05:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47158>

Pierre Habouzit <madcoder@debian.org> writes:

>> Hopefully this fixes all segfault problems users have been
>> experiencing over the past few months.
>> 
>> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ...
>   I confirm it fixes every segfault I was able to reproduce with any
> prior version :)

That's wonderful.  Thanks for testing, everybody.  And thanks
for fixing, Eric.
