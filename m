From: Junio C Hamano <junkio@cox.net>
Subject: Re: Last mile for 1.0
Date: Sun, 05 Jun 2005 23:45:08 -0700
Message-ID: <7vis0sugp7.fsf@assigned-by-dhcp.cox.net>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org>
	<7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506051658100.1876@ppc970.osdl.org>
	<20050606054356.GB3669@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0506052300350.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 08:42:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfBJ6-0006rO-Qp
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 08:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVFFGpX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 02:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVFFGpX
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 02:45:23 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:58613 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261183AbVFFGpL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2005 02:45:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050606064508.JXJO20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Jun 2005 02:45:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506052300350.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 5 Jun 2005 23:13:11 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> By now, I'd really like to have some test-cases. Things like "file dirty 
LT> in working directory, removed by merge" would be good.

Is test 44 in t1000 (the first one in t1000 after the lib-
read-tree-m-3way prepares the test trees) good enough?  Or do
you want more specific tests to make sure the logic catches
individual cases right?


