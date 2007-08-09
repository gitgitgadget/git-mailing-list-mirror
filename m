From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-merge: do up-to-date check also for strategies ours, subtree.
Date: Thu, 09 Aug 2007 14:11:24 -0700
Message-ID: <7v3aysxvk3.fsf@assigned-by-dhcp.cox.net>
References: <20070809120831.19319.qmail@a61af064a2a242.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 23:11:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJFI4-0004AF-D1
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 23:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123AbXHIVL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 17:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754183AbXHIVL1
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 17:11:27 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:49538 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbXHIVLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 17:11:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070809211125.EINN7193.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 9 Aug 2007 17:11:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ZxBQ1X0061kojtg0000000; Thu, 09 Aug 2007 17:11:24 -0400
In-Reply-To: <20070809120831.19319.qmail@a61af064a2a242.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Thu, 9 Aug 2007 12:08:31 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55474>

Right now I do not have time to dig mailing list archive around
mid March 2006, and I do not recall the requestor's original
rationale, but I have a vague recollection that we added this
"no fast-forward check" specifically in response to a user
request.
