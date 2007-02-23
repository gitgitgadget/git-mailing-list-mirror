From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: script to add another remote
Date: Fri, 23 Feb 2007 00:43:26 -0800
Message-ID: <7vr6sh8dsh.fsf@assigned-by-dhcp.cox.net>
References: <1172182595.20817.26.camel@dv>
	<7v8xepde5g.fsf@assigned-by-dhcp.cox.net>
	<1172218468.20390.15.camel@dv>
	<7vbqjl9td1.fsf@assigned-by-dhcp.cox.net>
	<1172219072.20390.17.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Fri Feb 23 09:43:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKW1c-00018w-3V
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 09:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbXBWIn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 03:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbXBWIn2
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 03:43:28 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:63001 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140AbXBWIn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 03:43:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070223084329.VCSX2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 23 Feb 2007 03:43:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SwjT1W0011kojtg0000000; Fri, 23 Feb 2007 03:43:27 -0500
In-Reply-To: <1172219072.20390.17.camel@dv> (Pavel Roskin's message of "Fri,
	23 Feb 2007 03:24:32 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40428>

Pavel Roskin <proski@gnu.org> writes:

>> So probably the next step would be to refactor some logic and
>> functionality out of git-clone, move them to git-remote, and
>> reimplement git-clone in terms of git-remote.  Implementation of
>> "--more" option would become much simpler (or, almost free)
>> after that is done.
>
> Oh, I see.  Thanks for the explanation.

Sorry for being incomplete --- obviously you cannot reimplement
clone with init and remote alone.  You need 'fetch' ;-).
