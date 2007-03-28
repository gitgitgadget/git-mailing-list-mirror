From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] --pretty=format: print fewer <unknown>s
Date: Wed, 28 Mar 2007 15:13:30 -0700
Message-ID: <7v3b3pf245.fsf@assigned-by-dhcp.cox.net>
References: <20070328220914.GA25389@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 00:13:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWgOc-0003F2-WA
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 00:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933770AbXC1WNc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 18:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933762AbXC1WNc
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 18:13:32 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:62529 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933770AbXC1WNb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 18:13:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070328221331.CNZV25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 28 Mar 2007 18:13:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gNDW1W00D1kojtg0000000; Wed, 28 Mar 2007 18:13:30 -0400
In-Reply-To: <20070328220914.GA25389@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 28 Mar 2007 18:09:14 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43395>

Jeff King <peff@peff.net> writes:

> This makes empty bodies truly empty, and fills in the
> default UTF-8 encoding for an empty encoding.

I do not think the latter is correct.  Replacing with an empty
string might make sense, although I haven't thought through the
issues.
