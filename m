From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH 1/2] Add a useful return value to git-check-attr
Date: Tue, 17 Apr 2007 02:28:34 -0700
Message-ID: <7vzm57pcxp.fsf@assigned-by-dhcp.cox.net>
References: <200704171010.49168.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 11:29:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdjzk-0007hh-4i
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 11:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbXDQJ2g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 05:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753100AbXDQJ2g
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 05:28:36 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:47769 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096AbXDQJ2f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 05:28:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070417092835.VPLN1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 17 Apr 2007 05:28:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id o9Ua1W00E1kojtg0000000; Tue, 17 Apr 2007 05:28:34 -0400
In-Reply-To: <200704171010.49168.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 17 Apr 2007 10:10:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44746>

Andy Parkins <andyparkins@gmail.com> writes:

> git-check-attr previously always returned success.  With this patch it
> returns success when the requested attribute is found for all supplied
> paths.
>
> This lets you check in a script whether a file has an attribute:
>
>  $ git-check-attr attribute -- file && echo "file has attribute"

I wrote check-attr primarily to have a quick way to make sure
the attribute stack is working properly, but I agree making
gitattributes available to scripts is important to make it
useful in general.

And your patch was a step in the right direction based on my
previous patch.

But sorry, you were shooting at a target that is still moving
too fast, and you missed.  It's not your fault, as even I did
not know where it was heading to, but my plan has been to have
the scripts parse the text output, as we would need more than
true/false values, as I did in the four patch series I sent out
tonight.
