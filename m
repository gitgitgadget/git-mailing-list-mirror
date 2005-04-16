From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/2] merge-trees script for Linus git
Date: Sat, 16 Apr 2005 10:14:29 -0700
Message-ID: <7v64ym8wzu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<20050414193507.GA22699@pasky.ji.cz>
	<7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
	<20050414233159.GX22699@pasky.ji.cz>
	<7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
	<20050414223039.GB28082@64m.dyndns.org>
	<7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
	<20050415062807.GA29841@64m.dyndns.org>
	<7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net>
	<7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
	<7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net>
	<7vfyxrhfsw.fsf_-_@assigned-by-dhcp.cox.net>
	<7vmzrzfwe4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151755590.7211@ppc970.osdl.org>
	<7v7jj3fjky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504152152580.7211@ppc970.osdl.org>
	<Pine.LNX.4.58.0504152256520.7211@ppc970.osdl.org>
	<7vis2ncf8j.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504160820320.72
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 19:12:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMqpm-0004ur-RJ
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 19:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbVDPRO7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 13:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbVDPRO6
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 13:14:58 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:35999 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262708AbVDPROd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 13:14:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050416171430.FEWB15592.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 13:14:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504160928250.7211@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 16 Apr 2005 09:36:25 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Anyway, with the modified read-tree, as far as I can tell it will now 
LT> merge all the cases where one side has done something to a file, and the 
LT> other side has left it alone (or where both sides have done the exact same 
LT> modification). That should _really_ cut down the cases to just a few files 
LT> for most of the kernel merges I can think of. 

LT> Does it do the right thing for your tests?

Yes.


