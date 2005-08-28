From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/9] New option --ignore-whitespace for git-apply.
Date: Sun, 28 Aug 2005 14:06:48 -0700
Message-ID: <7vu0h9kbyv.fsf@assigned-by-dhcp.cox.net>
References: <11252426793534-git-send-email-robfitz@273k.net>
	<1125242692932-git-send-email-robfitz@273k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 23:09:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9UNA-0002S5-1j
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 23:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVH1VGu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 17:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVH1VGu
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 17:06:50 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:49864 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750817AbVH1VGt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 17:06:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050828210647.CGHD15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 Aug 2005 17:06:47 -0400
To: Robert Fitzsimons <robfitz@273k.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7888>

Robert Fitzsimons <robfitz@273k.net> writes:

> Allow the user to force a patch to be applied even though there might
> be whitespace differences.  Added a test case for the new option.

It might be worth doing fuzz in general, but treating
whitespace-only fuzz specially is a good idea, since they are
usually more benign.
