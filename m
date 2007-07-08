From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: don't add multiple Signed-off-by: from the same identity
Date: Sun, 08 Jul 2007 11:44:47 -0700
Message-ID: <7vr6ni20rk.fsf@assigned-by-dhcp.cox.net>
References: <20070706144227.11736.qmail@046ba2bc1a0185.315fe32.mid.smarden.org>
	<7vy7hte717.fsf@assigned-by-dhcp.cox.net>
	<20070708150055.7018.qmail@10e1f648410572.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Sun Jul 08 20:44:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7bka-0001ib-29
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 20:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894AbXGHSou (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 14:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754621AbXGHSot
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 14:44:49 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41701 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592AbXGHSot (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 14:44:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070708184448.VFAG17683.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Jul 2007 14:44:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id M6kn1X00H1kojtg0000000; Sun, 08 Jul 2007 14:44:48 -0400
In-Reply-To: <20070708150055.7018.qmail@10e1f648410572.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Sun, 8 Jul 2007 15:00:55 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51906>

Gerrit Pape <pape@smarden.org> writes:

> with the patch, iff the last line already was the signoff to be added,
> it won't be added again.

Ah, I completely misread the patch.  Thanks.
