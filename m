From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: use $(FIND) instead of find
Date: Sun, 29 Jul 2007 15:22:27 -0700
Message-ID: <7vfy36n93w.fsf@assigned-by-dhcp.cox.net>
References: <85lkcyvr4f.fsf@lola.goethe.zz> <85ir82vr1v.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 00:22:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFH9l-0006kT-Ts
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 00:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbXG2WWb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 18:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbXG2WWb
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 18:22:31 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:50839 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762694AbXG2WW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 18:22:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070729222229.OFRU1393.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 29 Jul 2007 18:22:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VaNT1X00M1kojtg0000000; Sun, 29 Jul 2007 18:22:28 -0400
In-Reply-To: <85ir82vr1v.fsf@lola.goethe.zz> (David Kastrup's message of "Sun,
	29 Jul 2007 23:27:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54141>

Will apply excluding the install-symlinks bit.  The $(FIND)
thing is a good idea independently.  Thanks.
