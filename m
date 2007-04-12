From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Wed, 11 Apr 2007 19:06:43 -0700
Message-ID: <7vmz1el51o.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704092115020.6730@woody.linux-foundation.org>
	<461D6432.90205@vilain.net>
	<Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org>
	<461D6858.4090007@vilain.net>
	<Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org>
	<7vslb6mnva.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704111850240.4061@woody.linux-foundation.org>
	<7vy7kyl5br.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 04:06:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbohz-0000CD-Hd
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 04:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161453AbXDLCGp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 22:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161472AbXDLCGp
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 22:06:45 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62231 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161453AbXDLCGo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 22:06:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070412020645.NUHM1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 22:06:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id m26j1W00S1kojtg0000000; Wed, 11 Apr 2007 22:06:44 -0400
In-Reply-To: <7vy7kyl5br.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 11 Apr 2007 19:00:40 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44310>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Wed, 11 Apr 2007, Junio C Hamano wrote:
>>>
>>> The small detail in the last step is wrong, though.  Even if
>>> they EXIST, they may be isolated commits that are note connected
>>> to refs, and fsck in the repository would not have warned about
>>> unreachable trees from such unconnected commits.
>>
>> The superproject *is* a ref.
>
> But when you fsck the subproject repository in isolation in the
> earlier step in your procedure, that is not taken into account,
> is it?

Ah, forget about this.  The HEAD, which is in the tree of the
higher-level project, is a ref.  Silly me.
