From: Junio C Hamano <junkio@cox.net>
Subject: Re: rev-list --sparse?
Date: Sun, 30 Oct 2005 15:31:25 -0800
Message-ID: <7vll0algz6.fsf@assigned-by-dhcp.cox.net>
References: <7vd5lnztav.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510292204520.3348@g5.osdl.org>
	<7v64rfxuwl.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510301337500.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 00:32:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWMeS-0000sy-95
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 00:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVJ3Xb1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 18:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbVJ3Xb1
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 18:31:27 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:58808 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932408AbVJ3Xb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 18:31:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051030233046.EERE776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Oct 2005 18:30:46 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10842>

Linus Torvalds <torvalds@osdl.org> writes:

> Try "--sparse" together with a pathspec. It will only do the merge 
> follow optimization.

Ah, I saw (paths && dense) everywhere but there indeed is one
that only checks paths to call merge simplification -- I missed
that part.
