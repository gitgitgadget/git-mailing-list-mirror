From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cogito limitation in tag names?
Date: Sun, 11 Dec 2005 11:36:18 -0800
Message-ID: <7vpso3mnnx.fsf@assigned-by-dhcp.cox.net>
References: <439C7CA9.4030404@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 20:37:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElWzg-00086Q-Ni
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 20:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVLKTgV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 14:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVLKTgV
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 14:36:21 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:55293 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750824AbVLKTgU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2005 14:36:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051211193434.MCLS17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Dec 2005 14:34:34 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <439C7CA9.4030404@zytor.com> (H. Peter Anvin's message of "Sun,
	11 Dec 2005 11:23:21 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13506>

Probably it can safely be updated to use check-ref-format, and I
suspect that the only reason why it does not do so is because
check-ref-format came later.
