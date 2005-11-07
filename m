From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Cogito: Support for implicit remote branches in cloned repositories
Date: Mon, 07 Nov 2005 15:45:52 -0800
Message-ID: <7vhdaoqaxb.fsf@assigned-by-dhcp.cox.net>
References: <200511041701.48881.Josef.Weidendorfer@gmx.de>
	<7vvez8wbpz.fsf@assigned-by-dhcp.cox.net>
	<20051104210820.GM1431@pasky.or.cz>
	<7voe50rskh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511041359050.28804@g5.osdl.org>
	<7v8xw216q9.fsf@assigned-by-dhcp.cox.net>
	<20051107232122.GZ1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 00:47:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZGgq-0005Tj-Cz
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 00:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbVKGXpz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 18:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965610AbVKGXpz
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 18:45:55 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:28917 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965606AbVKGXpy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2005 18:45:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051107234500.IWJT11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Nov 2005 18:45:00 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051107232122.GZ1431@pasky.or.cz> (Petr Baudis's message of
	"Tue, 8 Nov 2005 00:21:22 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11293>

Petr Baudis <pasky@suse.cz> writes:

> This loses the pretty nice property that 'origin' refers to the HEAD
> branch of the remote repository,...

I think the code actually honors what your HEAD points at;
I did not go into that detail in the above description.

>> *1* I say "by default" here; I think there should be an
>> operating mode for git clone that acts as a straight copy, not
>> even the current "HEAD" -> "origin" renaming.  In fact that is
>> what you do with low-level git-clone-pack.
>
> What would it be useful for?

Cheap back-up, Linus style.
