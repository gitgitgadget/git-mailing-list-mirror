From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not show empty diff in diff-cache uncached.
Date: Sun, 29 May 2005 22:53:53 -0700
Message-ID: <7v8y1x9s3y.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
	<7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
	<7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505291151250.10545@ppc970.osdl.org>
	<7vis11n69l.fsf@assigned-by-dhcp.cox.net>
	<7v3bs5k8d1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505292231580.10545@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 07:51:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcdBS-0002IR-Hu
	for gcvg-git@gmane.org; Mon, 30 May 2005 07:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVE3Fx4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 01:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVE3Fx4
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 01:53:56 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:7815 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261520AbVE3Fxz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 01:53:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050530055354.EBPX26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 May 2005 01:53:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505292231580.10545@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 29 May 2005 22:34:59 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Sun, 29 May 2005, Junio C Hamano wrote:
>> 
>> Please disregard the patches you have already discarded so far;
>> this request-to-discard includes -O and -B enhancements.

LT> I actually like -B, it's just that that patch depended on -O and also came 
LT> with a separate patch that was the reason I liked -B in the first place..

Good.  I actually just finished testing the complete reorder of
the patches and about to start the final review before throwing
the bundle at you again.  In the new set, -B comes before -O.

