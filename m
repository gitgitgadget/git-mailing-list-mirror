From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-fetch, git-parse-remote: Cleanup implementation of '.'
Date: Fri, 16 Mar 2007 03:00:55 -0700
Message-ID: <7vlkhxv76w.fsf@assigned-by-dhcp.cox.net>
References: <etavpn$ma0$1@sea.gmane.org>
	<7vr6rqyr60.fsf@assigned-by-dhcp.cox.net>
	<45FA5771.1040200@lu.unisi.ch>
	<7vps79v8ik.fsf@assigned-by-dhcp.cox.net>
	<45FA657B.1010709@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Fri Mar 16 11:01:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS9F9-0000qO-2e
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 11:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933286AbXCPKA5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 06:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933320AbXCPKA5
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 06:00:57 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:34600 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933286AbXCPKA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 06:00:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070316100055.GMCN321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Mar 2007 06:00:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bN0w1W00E1kojtg0000000; Fri, 16 Mar 2007 06:00:56 -0400
In-Reply-To: <45FA657B.1010709@lu.unisi.ch> (Paolo Bonzini's message of "Fri,
	16 Mar 2007 10:38:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42343>

Paolo Bonzini <paolo.bonzini@lu.unisi.ch> writes:

>> I may not be really thinking straight tonight (no I am not
>> drunk, but just a tad sick), but I wonder if this is sufficient?
>> 
>> 	$(git-for-each-ref --format='%(refname):')
>> 
>> Shorter and one less process and pipe.
>
> It is.  Would you take care of that?

Surely, and thanks for sanity checking.
