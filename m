From: Junio C Hamano <junkio@cox.net>
Subject: Re: Error.pm: add configuration variable in Makefile
Date: Sun, 18 Feb 2007 00:45:32 -0800
Message-ID: <7virdzj1lf.fsf@assigned-by-dhcp.cox.net>
References: <200702162200.15241.barra_cuda@katamail.com>
	<loom.20070217T152508-6@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergio Callegari <scallegari@arces.unibo.it>
X-From: git-owner@vger.kernel.org Sun Feb 18 09:45:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIhfy-0002g1-AQ
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 09:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbXBRIpe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 03:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161152AbXBRIpe
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 03:45:34 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:53047 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161161AbXBRIpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 03:45:33 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070218084533.CBOM1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Feb 2007 03:45:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QwlY1W0031kojtg0000000; Sun, 18 Feb 2007 03:45:32 -0500
In-Reply-To: <loom.20070217T152508-6@post.gmane.org> (Sergio Callegari's
	message of "Sat, 17 Feb 2007 14:38:58 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40063>

Sergio Callegari <scallegari@arces.unibo.it> writes:

> Problem is that the "private" Error.pm is put in a "public" location and not
> kept private with the current installation of Git.

I see.

I do not think anybody minds too much if the private Error.pm is
installed in $(prefix)/share/git-core/perl/ or somesuch, as long
as you arrange things so that Git.pm can find it, so go wild.
