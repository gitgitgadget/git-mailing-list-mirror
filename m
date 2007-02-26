From: Junio C Hamano <junkio@cox.net>
Subject: Re: Isn't "dangling" a misnomer?
Date: Mon, 26 Feb 2007 12:03:45 -0800
Message-ID: <7virdolm8u.fsf@assigned-by-dhcp.cox.net>
References: <3c6c07c20702260835v4865ace1u18a20f6b1d0030b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Mike Coleman" <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 26 21:05:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLm5j-0007dz-KA
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 21:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030628AbXBZUDs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 15:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030634AbXBZUDr
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 15:03:47 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48073 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030628AbXBZUDr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 15:03:47 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070226200347.CIAG233.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 26 Feb 2007 15:03:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UL3m1W00C1kojtg0000000; Mon, 26 Feb 2007 15:03:46 -0500
In-Reply-To: <3c6c07c20702260835v4865ace1u18a20f6b1d0030b5@mail.gmail.com>
	(Mike Coleman's message of "Mon, 26 Feb 2007 10:35:50 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40659>

"Mike Coleman" <tutufan@gmail.com> writes:

> What about an alternative term like "orphaned" or "unreferenced"?  The
> former is a bit more suggestive, but unfortunately might be confusing
> since the terms like ancestors, parents, etc., are already being used
> to talk about commit trees, which really is an orthogonal topic.  The
> latter term seems like it would work, though it does sound a bit
> sterile.

We seem to use the word "unreachable" to refer to them.
E.g. fsck and prune do "reachability analysis".
