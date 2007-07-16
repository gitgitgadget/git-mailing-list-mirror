From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/emacs/Makefile: Also install .el files.
Date: Sun, 15 Jul 2007 20:20:57 -0700
Message-ID: <7v8x9havae.fsf@assigned-by-dhcp.cox.net>
References: <403842ba71506c7b194812cd9a4f669c847eb7bc.1184548803.git.dak@gnu.org>
	<09ccbeffdf2ca787844d20fdc3e93d323da206f7.1184548803.git.dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 05:21:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAH8v-0007PI-6O
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 05:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760130AbXGPDVA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 23:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760133AbXGPDU7
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 23:20:59 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:38775 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759680AbXGPDU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 23:20:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070716032058.YSBS1393.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Jul 2007 23:20:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q3Lx1X00H1kojtg0000000; Sun, 15 Jul 2007 23:20:57 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52628>

David Kastrup <dak@gnu.org> writes:

> Signed-off-by: David Kastrup <dak@gnu.org>
>  install: all
>  	$(INSTALL) -d $(DESTDIR)$(emacsdir)
> -	$(INSTALL_ELC) $(ELC) $(DESTDIR)$(emacsdir)
> +	$(INSTALL_ELC) $(ELC:.elc=.el) $(ELC) $(DESTDIR)$(emacsdir)

Ok, thanks.
