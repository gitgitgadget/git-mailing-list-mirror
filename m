From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Teach Git how to parse standard power of 2 suffixes.
Date: Sat, 30 Dec 2006 18:33:45 -0800
Message-ID: <7vodpkhjzq.fsf@assigned-by-dhcp.cox.net>
References: <20061231020218.GA5366@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 03:33:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0qWE-0002Ys-Mh
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 03:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbWLaCdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 21:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbWLaCdr
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 21:33:47 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:53285 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932690AbWLaCdq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 21:33:46 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231023346.WNKX97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Dec 2006 21:33:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5EZ01W0091kojtg0000000; Sat, 30 Dec 2006 21:33:00 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20061231020218.GA5366@spearce.org> (Shawn O. Pearce's message of
	"Sat, 30 Dec 2006 21:02:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35653>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Sometimes its necessary to supply a value as a power of two in a
> configuration parameter.  In this case the user may want to use
> the standard suffixes such as K, KB, KiB, etc. to indicate that
> the numerical value should be multiplied by a constant base before
> being used.

If you are really going to do this, I think we would need
something similar to --bool to repo-config command.

Also can we fix the definition of core.packedGitWindowSize to be
independent of the page size on a particular platform?
