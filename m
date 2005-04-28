From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Built-in diff driver shows Index: line.
Date: Thu, 28 Apr 2005 15:41:34 -0700
Message-ID: <7v3bta5xsx.fsf@assigned-by-dhcp.cox.net>
References: <7vy8b27lyf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504281236090.18901@ppc970.osdl.org>
	<7vacni5z9y.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504281522560.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 00:36:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRHcR-0003IT-UR
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 00:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbVD1Wls (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 18:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVD1Wls
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 18:41:48 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:25555 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262315AbVD1Wlg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 18:41:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428224133.XJEV23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 18:41:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504281522560.18901@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 28 Apr 2005 15:30:36 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Thu, 28 Apr 2005, Junio C Hamano wrote:
>> 
>> So I'd say we'd punt this one for now, unless somebody else has
>> a better idea.

LT> It's trivially easy to do it with a external diff helper.

What I meant to _punt_ is trying to show meaningful dates, not
satisfying the diffstat.

LT> So you can do it with a few lines of GIT_EXTERNAL_DIFF ...

Heh.  I am the one who wrote that stuff and you already know how
to use that effectively far better than I do ;-).

