From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git log -g: Complain, but do not fail, when no reflogs are there
Date: Mon, 23 Jul 2007 22:37:57 -0700
Message-ID: <7vbqe2jr9m.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707240039300.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 07:38:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDD5v-0002Fe-F5
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 07:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbXGXFiA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 01:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbXGXFiA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 01:38:00 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:50394 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbXGXFh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 01:37:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070724053758.SFLM1393.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 24 Jul 2007 01:37:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id THdy1X00E1kojtg0000000; Tue, 24 Jul 2007 01:37:59 -0400
In-Reply-To: <Pine.LNX.4.64.0707240039300.14781@racer.site> (Johannes
	Schindelin's message of "Tue, 24 Jul 2007 00:39:50 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53524>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When asking "git log -g --all", clearly you want to see only those refs
> that do have reflogs, but you do not want it to fail, either.
>
> So instead of die()ing, complain about it, but move on to the other refs.

Hmph, do we even want to error(), I wonder...

Can you tell, at that point, if there were explicit branch
names given originally on the command line, or the refs came
from --all?
