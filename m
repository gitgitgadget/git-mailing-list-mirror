From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Make tag names (i.e. the tag object's "tag" line) optional
Date: Sun, 10 Jun 2007 18:11:02 -0700
Message-ID: <7vy7ir2t3t.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	<200706101349.33280.johan@herland.net>
	<7vps435sy0.fsf@assigned-by-dhcp.cox.net>
	<200706110101.08664.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 03:11:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxYRF-0000Uz-Oo
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 03:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762085AbXFKBLG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 21:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763270AbXFKBLG
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 21:11:06 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:50499 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762085AbXFKBLF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 21:11:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070611011104.IBUR12207.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Jun 2007 21:11:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id A1B21X00E1kojtg0000000; Sun, 10 Jun 2007 21:11:03 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49809>

Johan Herland <johan@herland.net> writes:

> If the "tag" line remains mandatory, I'll have to construct an
> artificial name for unnamed 'notes'...

Ah, silly me, now I remember.

But let's put this series on hold and see how versioned set of
notes from Johannes turns out.  It seems that people are in
favor of its simplicity, and even though it may be much less
expressive, it might be sufficient for certain class of
applications.  It one certainly is a much smaller and isolated
change that we could easily drop more easily if it does not work
out.
