From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] A new merge stragety 'subtree'.
Date: Sat, 17 Feb 2007 00:51:30 -0800
Message-ID: <7vps89upyl.fsf@assigned-by-dhcp.cox.net>
References: <7vfy95y2n9.fsf@assigned-by-dhcp.cox.net>
	<20070217084558.GE27864@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 17 09:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HILI7-0004RI-Ck
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 09:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946518AbXBQIvc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 03:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946520AbXBQIvc
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 03:51:32 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:41244 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946518AbXBQIvb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 03:51:31 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217085130.USAS1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 17 Feb 2007 03:51:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QYrW1W00K1kojtg0000000; Sat, 17 Feb 2007 03:51:30 -0500
In-Reply-To: <20070217084558.GE27864@spearce.org> (Shawn O. Pearce's message
	of "Sat, 17 Feb 2007 03:45:58 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39976>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Really that isn't too different from a rename detection.

I know, but I am just lazy.  The match scoring part is very well
isolated so you or anybody can plug different code there.
