From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] rebase -i: several cleanups
Date: Tue, 26 Jun 2007 19:00:20 -0700
Message-ID: <7vk5tqtavf.fsf@assigned-by-dhcp.pobox.com>
References: <Pine.LNX.4.64.0706251856300.4059@racer.site>
	<7vk5tqurrw.fsf@assigned-by-dhcp.pobox.com>
	<Pine.LNX.4.64.0706270216070.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 27 04:00:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3MpY-0007Rm-W2
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 04:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669AbXF0CAX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 22:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754679AbXF0CAX
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 22:00:23 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:59501 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754834AbXF0CAW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 22:00:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627020020.JLXM22777.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Jun 2007 22:00:20 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GS0L1X00S1kojtg0000000; Tue, 26 Jun 2007 22:00:21 -0400
In-Reply-To: <Pine.LNX.4.64.0706270216070.4438@racer.site> (Johannes
	Schindelin's message of "Wed, 27 Jun 2007 02:17:08 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51002>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > @@ -264,8 +269,11 @@ do
>> >  		echo $ONTO > "$DOTEST"/onto
>> >  		test t = "$VERBOSE" && : > "$DOTEST"/verbose
>> >  
>> > +		SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
>> > +		SHORTHEAD=$(git rev-parse --short $HEAD)
>> > +		SHORTONTO=$(git rev-parse --short $ONTO)
>> >  		cat > "$TODO" << EOF
>> > -# Rebasing $UPSTREAM..$HEAD onto $ONTO
>> > +# Rebasing $SHORTUPSTREAM)..$SHORTHEAD onto $SHORTONTO
>> 
>> What is this close-paren about?  Is it a typo?
>
> Darn. It _is_ a typo. I overlooked it _both_ when typing _and_ when 
> looking at the result.

No worries; will fix up.  I just wanted to make sure that I did
not know the notation that had some meaning.
