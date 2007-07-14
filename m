From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use $(RM) in makefiles instead of rm
Date: Sat, 14 Jul 2007 01:33:18 -0700
Message-ID: <7vejjbjsfl.fsf@assigned-by-dhcp.cox.net>
References: <11843489233943-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Emil Medve <Emilian.Medve@Freescale.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 10:33:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9d47-0006ev-3W
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 10:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbXGNIdU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 04:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbXGNIdU
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 04:33:20 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:33431 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbXGNIdT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 04:33:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070714083319.DESQ1393.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 14 Jul 2007 04:33:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PLZJ1X00E1kojtg0000000; Sat, 14 Jul 2007 04:33:19 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52455>

The title really should read "instead of 'rm -f'".

And who defines "RM = rm -f" when nothing is specified on the
command line?  I'd assume the answer is "GNU make", and it
probably is true for all versions we care about, but I would
feel better if we have that spelled explicitly as the fallback
position, just like we define CC, AR and friends.
