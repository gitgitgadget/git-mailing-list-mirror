From: Junio C Hamano <junkio@cox.net>
Subject: Re: Issues with higher-order stages in dircache
Date: Sat, 16 Apr 2005 23:01:49 -0700
Message-ID: <7vll7i0wmq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
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
	<7vll7i95u1.fsf_-_@assigned-by-dhcp.cox.net>
	<7v64ym2dju.fsf@assigne
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 07:58:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN2nG-000189-OF
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 07:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVDQGBw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 02:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVDQGBw
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 02:01:52 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:54009 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261269AbVDQGBv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 02:01:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417060150.VEGC1282.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 02:01:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504162228300.7211@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 16 Apr 2005 22:31:26 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

>> - When merging two trees, i.e. "read-tree -m A B", shouldn't
>> we collapse identical stage-1/2 into stage-0?

LT> How do you actually intend to merge two trees? 

How silly of me.  *BLUSH*

