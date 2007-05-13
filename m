From: Junio C Hamano <junkio@cox.net>
Subject: RFH for [PATCH] Optimized cvsexportcommit: calling 'cvs status' only once instead of once per changed file.
Date: Sun, 13 May 2007 14:01:49 -0700
Message-ID: <7vps54qvya.fsf_-_@assigned-by-dhcp.cox.net>
References: <0056A63A-D511-4FDD-82A6-A13B06E237E9@zib.de>
	<200705092230.16027.robin.rosenberg.lists@dewire.com>
	<380B28A3-5CD0-4371-A717-1D2629E6302D@zib.de>
	<46a038f90705092353x107c738foa7db547ab29b1748@mail.gmail.com>
	<7vd519m9z7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Steffen Prohaska" <prohaska@zib.de>,
	"Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 13 23:02:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnLD2-0006Wd-8s
	for gcvg-git@gmane.org; Sun, 13 May 2007 23:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760594AbXEMVBv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 17:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760595AbXEMVBv
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 17:01:51 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:63068 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857AbXEMVBu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 17:01:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070513210150.VFVT13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 13 May 2007 17:01:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id yl1p1W00U1kojtg0000000; Sun, 13 May 2007 17:01:50 -0400
cc: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <7vd519m9z7.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 10 May 2007 00:08:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47182>

I'd like to have feedbacks on this patch, as I think what it
tries to do is sensible and worth to have it in v1.5.2 if it
works for people.

Ack?  Nack?  YesButNeedsmorework?
