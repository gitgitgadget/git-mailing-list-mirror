From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: New feature last_modified_ref.
Date: Fri, 29 Dec 2006 11:12:08 -0800
Message-ID: <7vlkkqms8n.fsf@assigned-by-dhcp.cox.net>
References: <20061229185805.GF6558@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 20:12:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0N9i-00067a-RT
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 20:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbWL2TML (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 14:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWL2TML
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 14:12:11 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:63911 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965129AbWL2TMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 14:12:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061229191209.PGVW97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Dec 2006 14:12:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 4jBP1W00P1kojtg0000000; Fri, 29 Dec 2006 14:11:24 -0500
To: Robert Fitzsimons <robfitz@273k.net>
In-Reply-To: <20061229185805.GF6558@localhost> (Robert Fitzsimons's message of
	"Fri, 29 Dec 2006 18:58:05 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35603>

I somehow suspect this is solving the problem with a wrong
tradeoff.

This change only affects the project list page, which I think is
simpler to deal with more aggressive caching (say, no more than
once every 10 minutes even if some project pushed a new head in
the meantime).

Not a firm refusal, but something to think about.
