From: Junio C Hamano <junkio@cox.net>
Subject: Re: tree corrupted on disk quota full
Date: Fri, 12 Jan 2007 16:53:26 -0800
Message-ID: <7vzm8noigp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701111324350.3594@woody.osdl.org>
	<20070111215812.GK17999@mellanox.co.il>
	<Pine.LNX.4.64.0701111410420.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 01:53:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5X9H-0000Ia-RP
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 01:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbXAMAx2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 19:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbXAMAx2
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 19:53:28 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:51653 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161144AbXAMAx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 19:53:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070113005327.CDCA7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 19:53:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AQsb1W00o1kojtg0000000; Fri, 12 Jan 2007 19:52:36 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36734>

Linus Torvalds <torvalds@osdl.org> writes:

> Sad. The old code was perfectly good. The new code was unsafe, but thought 
> it was better. See commit 93822c2239a336e5cb583549071c59202ef6c5b2 for 
> details.

Sorry about not catching it earlier.
