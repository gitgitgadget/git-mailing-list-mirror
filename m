From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] show-branch --reflog: show the reflog message at the top.
Date: Fri, 19 Jan 2007 16:23:57 -0800
Message-ID: <7v4pqmczqa.fsf@assigned-by-dhcp.cox.net>
References: <7virf2d190.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701200116280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 01:24:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H841a-00041q-6v
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 01:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932807AbXATAX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 19:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbXATAX7
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 19:23:59 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:60308 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932807AbXATAX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 19:23:58 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120002358.BQKX29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 19:23:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DCQF1W00P1kojtg0000000; Fri, 19 Jan 2007 19:24:16 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701200116280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 20 Jan 2007 01:16:51 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37228>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> does this mean you did not get used to "--walk-reflogs"? Just wanna know.

That's independent.

I still am having a hard time trying to explain what these
commands would do, and why they might be useful:

	git-log --walk-reflogs master..next
	git-log --walk-reflogs master -- Documentation/

On the other hand I can understand why this might be useful:

	git-log --walk-reflogs master
