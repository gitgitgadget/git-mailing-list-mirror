From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC 2/2] Make path-limiting be incremental when possible.
Date: Fri, 31 Mar 2006 12:35:41 -0800
Message-ID: <7vfykyuzc2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603301648530.27203@g5.osdl.org>
	<Pine.LNX.4.64.0603301652531.27203@g5.osdl.org>
	<Pine.LNX.4.64.0603302153350.27203@g5.osdl.org>
	<7v3bgzxgbg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603311135290.27203@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 31 22:39:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPQOe-0005fl-2a
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 22:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWCaUhN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 15:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWCaUhM
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 15:37:12 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:39125 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932110AbWCaUfm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 15:35:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060331203542.BCZD3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 31 Mar 2006 15:35:42 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603311135290.27203@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 31 Mar 2006 11:39:26 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18231>

Linus Torvalds <torvalds@osdl.org> writes:

> The fix is trivial - with the new get_revision() organization, the 
> BOUNDARY case special-case actually goes away entirely, and this trivial 
> patch (on top of my 2/2 patch) should just fix it.

Yes, that is exactly the fix I have in "pu" -- I suspect you
replied before getting to my response last night.
