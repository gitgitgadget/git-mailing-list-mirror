From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: USE_SYMLINK option
Date: Sat, 30 Jun 2007 11:46:52 -0700
Message-ID: <7v7iplcmar.fsf@assigned-by-dhcp.cox.net>
References: <20070630181456.GA15035@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jun 30 20:46:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4hyC-0001qq-MN
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 20:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406AbXF3Sqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 14:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754376AbXF3Sqy
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 14:46:54 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:49920 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914AbXF3Sqy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 14:46:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070630184653.JCZR1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 14:46:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Hums1X00B1kojtg0000000; Sat, 30 Jun 2007 14:46:52 -0400
In-Reply-To: <20070630181456.GA15035@moooo.ath.cx> (Matthias Lederhofer's
	message of "Sat, 30 Jun 2007 20:14:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51244>

Matthias Lederhofer <matled@gmx.net> writes:

> I found no real drawback using symlinks and symlinks are sometimes
> more practical, for example when copying/creating a tarball of the
> installation.

Well, tar handles hard links just fine, thanks.  The real
drawbacks of doing symlinks people often cite (and I agree to)
are that they can become dangling, and they consume i-nodes.
