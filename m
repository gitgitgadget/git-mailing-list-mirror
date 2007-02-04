From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge doesn't remove files
Date: Sat, 03 Feb 2007 16:48:28 -0800
Message-ID: <7vy7nezr1f.fsf@assigned-by-dhcp.cox.net>
References: <20070203224819.20131.qmail@b1b53206edee41.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 01:48:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDVYW-0005OZ-3T
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 01:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbXBDAsa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 19:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbXBDAsa
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 19:48:30 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:50745 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751578AbXBDAs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 19:48:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204004829.QKIS1343.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 19:48:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KCoV1W0041kojtg0000000; Sat, 03 Feb 2007 19:48:29 -0500
In-Reply-To: <20070203224819.20131.qmail@b1b53206edee41.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Sat, 3 Feb 2007 22:48:19 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38626>

Gerrit Pape <pape@smarden.org> writes:

> Shouldn't git remove the original file after merging a commit that moved
> the file away?

I think this has been fixed quite a while ago --- does not seem
to reproduce with the current v1.5.0-rc.
