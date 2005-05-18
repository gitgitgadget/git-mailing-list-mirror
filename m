From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/1] Diff-helper update
Date: Wed, 18 May 2005 16:54:17 -0700
Message-ID: <7vacmsnl92.fsf@assigned-by-dhcp.cox.net>
References: <7v3bslqc94.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505180821470.18337@ppc970.osdl.org>
	<7v64xgpgb0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505181110480.18337@ppc970.osdl.org>
	<Pine.LNX.4.58.0505181134470.18337@ppc970.osdl.org>
	<7vll6cnup4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505181338270.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Thu May 19 01:56:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYYOL-0002by-9T
	for gcvg-git@gmane.org; Thu, 19 May 2005 01:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVERXzh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 19:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbVERXyd
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 19:54:33 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:4861 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262424AbVERXyY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2005 19:54:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050518235416.WOLT19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 May 2005 19:54:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505181338270.18337@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 18 May 2005 13:39:21 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Wed, 18 May 2005, Junio C Hamano wrote:
>> 
>> I suspect doing something like this might be saner instead,
>> assuming non raw-diffs come at the end.  

LT> It won't ever trigger, since we only exit the loop once we see EOF.

I was not talking about correctness, but the readability of the
code.  Breaking out from the loop to process raw-diff and
switching to straight copy would make our intent more explicit.

