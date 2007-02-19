From: Junio C Hamano <junkio@cox.net>
Subject: Re: Publishing Question: First time Pushing to nonexsiting directory
Date: Mon, 19 Feb 2007 00:33:22 -0800
Message-ID: <7vk5yea6nh.fsf@assigned-by-dhcp.cox.net>
References: <20070219073526.GA26531@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Mon Feb 19 09:33:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ3xf-00025X-R6
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 09:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbXBSIdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 03:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbXBSIdY
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 03:33:24 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43424 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbXBSIdX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 03:33:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070219083322.HDEF1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Feb 2007 03:33:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id RLZN1W00F1kojtg0000000; Mon, 19 Feb 2007 03:33:23 -0500
In-Reply-To: <20070219073526.GA26531@cip.informatik.uni-erlangen.de> (Thomas
	Glanzmann's message of "Mon, 19 Feb 2007 08:35:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40105>

Thomas Glanzmann <thomas@glanzmann.de> writes:

> I thought that there is a command available which I can use to push a
> repository to a remote nonexisting location (that gets created on the
> fly) ...

Sorry, there isn't.

> I thought that I read a comment from Linus(?) long time ago to how to obtain
> that. But I am unable to find the e-mail in my archives. If there is no
> standard way, how do you do it? Just rsync the files and change the
> 'origin'?

What you remember might be this one:

    http://thread.gmane.org/gmane.comp.version-control.git/31351/focus=31610

Even if it isn't, it is worth a read.  Look for "The creation of
a new archive tends to" and "really _has_ to be separate".

There was another discussion around this topic as well:

    http://thread.gmane.org/gmane.comp.version-control.git/32040/focus=32108

which I think is a possible design in the right direction, but I
did not hear much from the users (as you can see in the archive
link above) so it hasn't materialized.  The only real improvement
that came out of the thread is deletion of a branch at the remote
site with "git-push :refs/heads/to-be-removed".

Another ancient one is:

    http://thread.gmane.org/gmane.comp.version-control.git/12651/focus=12667
