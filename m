From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix push with refspecs containing wildcards
Date: Thu, 07 Jun 2007 23:38:44 -0700
Message-ID: <7v4pljlzm3.fsf@assigned-by-dhcp.cox.net>
References: <20070607225302.GA10633@steel.home>
	<20070607234305.GB10633@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 08:39:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwY7p-0000n6-0h
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 08:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758988AbXFHGir (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 02:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759140AbXFHGir
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 02:38:47 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:49494 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759129AbXFHGiq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 02:38:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070608063845.ZEDL5800.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 Jun 2007 02:38:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8uel1X0011kojtg0000000; Fri, 08 Jun 2007 02:38:45 -0400
In-Reply-To: <20070607234305.GB10633@steel.home> (Alex Riesen's message of
	"Fri, 8 Jun 2007 01:43:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49439>

Sending a fix is a good thing, but whenever doing one, could
people please also do a testcase that demonstrates the original
bug, and also a demonstration that the fix does not introduce
regression?

For this one, obviously a test for push that uses such wildcard
ref is needed but at the same time we would want a test for push
that does _not_ use a wildcard, fetch that uses a wildcard, and
a fetch that does not use a wildcard.
