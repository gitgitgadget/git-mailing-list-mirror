From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-pull and tag objects
Date: Sun, 11 Feb 2007 13:55:57 -0800
Message-ID: <7vfy9ccqaa.fsf@assigned-by-dhcp.cox.net>
References: <1170933407.15431.38.camel@okra.transitives.com>
	<81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
	<7v4ppurka1.fsf@assigned-by-dhcp.cox.net>
	<20070210142322.GB25607@thunk.org>
	<Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
	<eqldhe$h7i$1@sea.gmane.org>
	<Pine.LNX.4.64.0702101347350.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 11 22:56:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGMfx-00042Q-UG
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 22:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbXBKVz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 16:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbXBKVz6
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 16:55:58 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:64051 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932566AbXBKVz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 16:55:58 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070211215558.YJHF21704.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Feb 2007 16:55:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NMvx1W00X1kojtg0000000; Sun, 11 Feb 2007 16:55:58 -0500
In-Reply-To: <Pine.LNX.4.64.0702101347350.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 10 Feb 2007 13:58:59 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39311>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 10 Feb 2007, Jakub Narebski wrote:
>> 
>> One of the solutions, used in git.git repository, is to put public key
>> as a out-of-tree blob using git-hash-object, then tag it using singed tag
>> with instruction about how to extract key in the tag message (tag comment).
>
> No. That's horrible. Yes, it's what Junio did, but if you don't trust the 
> archive, the _last_ thing you should do is to depend on a blob in the 
> archive itself to contain the thing to make you trust it more.

True.  I should have made it clear it was purely a convenient
way for people to get the public key and verifying that key
needs to be done on a separate channel.  Otherwise it would have
confused people (exactly like Jakub was confused).
