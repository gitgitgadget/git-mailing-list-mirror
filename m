From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-index-pack really does suck..
Supersedes: <7v7istw5w7.fsf@assigned-by-dhcp.cox.net>
Date: Tue, 03 Apr 2007 13:40:35 -0700
Message-ID: <7vzm5pur7g.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
	<db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
	<Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
	<alpine.LFD.0.98.0704031625050.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 22:40:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYpo0-00062b-CO
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 22:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945930AbXDCUkh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 16:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945933AbXDCUkh
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 16:40:37 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44777 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945930AbXDCUkg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 16:40:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070403204036.TTVA25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Apr 2007 16:40:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ikgb1W00E1kojtg0000000; Tue, 03 Apr 2007 16:40:35 -0400
In-Reply-To: <alpine.LFD.0.98.0704031625050.28181@xanadu.home> (Nicolas
	Pitre's message of "Tue, 03 Apr 2007 16:32:25 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43658>

[sorry, sent a message without finishing]

Nicolas Pitre <nico@cam.org> writes:

> Maybe we shouldn't run index-pack on packs for which we _already_ have 
> an index for which is the most likely reason for the collision check to 
> trigger in the first place.
>
> This is in the same category as trying to run unpack-objects on a pack 
> within a repository and wondering why it doesn't work.
> ...
> I'm of the opinion that this patch is unnecessary.  It only helps in 
> bogus workflows to start with, and it makes the default behavior unsafe 
> (unsafe from a paranoid pov, but still).  And in the _normal_ workflow 
> it should never trigger.

Hmmmm.  You may have a point.

So maybe we should retitle this thread from "git-index-pack
really does suck.." to "I used git-index-pack in a stupid way"?
 
