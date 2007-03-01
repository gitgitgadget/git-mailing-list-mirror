From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/2] pathattr: allow piping to external program.
Date: Thu, 01 Mar 2007 01:37:28 -0800
Message-ID: <7vodnduwx3.fsf@assigned-by-dhcp.cox.net>
References: <7vodndxwia.fsf@assigned-by-dhcp.cox.net>
	<7vzm6xux9o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 10:37:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMhjE-0005Ik-8s
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 10:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933223AbXCAJha (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 04:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933224AbXCAJha
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 04:37:30 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42849 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933223AbXCAJh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 04:37:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070301093729.RCMS24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Mar 2007 04:37:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VMdU1W00a1kojtg0000000; Thu, 01 Mar 2007 04:37:29 -0500
In-Reply-To: <7vzm6xux9o.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 01 Mar 2007 01:29:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41066>

Junio C Hamano <junkio@cox.net> writes:

> This sets up capability for various traits to be an external
> process, accessed via pipe.  conv-i and conv-o need to spawn
> bidirectional pipe, but I have not coded that part yet.
>
> You can try running:
>
>     $ git show HEAD:Documentation/*.txt

... obviously I meant

	$ git show HEAD:Documentation/git.txt

or something a bit more concrete than '*' here.

>
> with:
>
>     [pathattr "kludge"]
>         path = Documentation/*.txt
>         pretty = "pipe sed -e 's/^/>> /'"
>
> to see what it does.
>
> Signed-off-by: Junio C Hamano <junkio@cox.net>
