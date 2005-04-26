From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] diff-cache buglet
Date: Tue, 26 Apr 2005 11:22:31 -0700
Message-ID: <7vsm1do0t4.fsf@assigned-by-dhcp.cox.net>
References: <7v7jippjky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504261005360.18901@ppc970.osdl.org>
	<7vy8b5o211.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504261103550.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 20:19:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQUdN-0007f0-Bn
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 20:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVDZSWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 14:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVDZSWy
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 14:22:54 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:14748 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261608AbVDZSWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 14:22:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050426182233.MBLW19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 26 Apr 2005 14:22:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504261103550.18901@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 26 Apr 2005 11:06:48 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Well, except for the fact that that isn't machine-readable
LT> either, since the "1 " thing might just be part of the
LT> filename..

Well, I somehow thought these things are in fixed column format;
mode, ->, sha, stage, and filename are all seperated with either
' ' or '\t'.  So if I copy MN to "1 MN", presumably you would
see this:

    100644 a716d58de4a570e0038f5c307bd8db34daea021f 0 MN
    100644 a716d58de4a570e0038f5c307bd8db34daea021f 0 1 MN

So while I agree that // would also work, I fail to see why you
would even need that.

