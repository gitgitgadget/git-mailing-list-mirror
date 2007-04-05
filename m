From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 04/13] support rollback on writes to checksummed files
Date: Thu, 05 Apr 2007 15:58:22 -0700
Message-ID: <7vhcrumnsh.fsf@assigned-by-dhcp.cox.net>
References: <56b7f5510704051529k55a96bdfy5b072b220f8269a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:58:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZauQ-0005re-N4
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 00:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767255AbXDEW6Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 18:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767400AbXDEW6X
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 18:58:23 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:50650 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767255AbXDEW6X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 18:58:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405225823.MOCF373.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 18:58:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jayN1W00H1kojtg0000000; Thu, 05 Apr 2007 18:58:22 -0400
In-Reply-To: <56b7f5510704051529k55a96bdfy5b072b220f8269a7@mail.gmail.com>
	(Dana How's message of "Thu, 5 Apr 2007 15:29:32 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43879>

"Dana How" <danahow@gmail.com> writes:

> From 1df9e443ce11365f955b83e70365670ff9ada8d6 Mon Sep 17 00:00:00 2001
> From: Dana How <how@deathvalley.cswitch.com>
> Date: Thu, 5 Apr 2007 13:13:42 -0700
> Subject: [PATCH 04/13] support rollback on writes to checksummed files
> add struct sha1posn, sha1mark(), sha1undo() to csum-file.[ch]

Have an empty line after "Subject:".  Begin a sentence with a
capital (i.e. "Add struct...").

Explain *why* these changes are needed, not just *what* the
patch does -- the latter can be read from the patch text.
