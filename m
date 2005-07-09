From: Junio C Hamano <junkio@cox.net>
Subject: Re: Converting commits to patch files?  HEAD vs HEAD^
Date: Fri, 08 Jul 2005 19:41:03 -0700
Message-ID: <7vvf3k1z28.fsf@assigned-by-dhcp.cox.net>
References: <20050709013859.GA11947@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 04:42:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dr5IW-0005PP-1a
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 04:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbVGICl6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 22:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263090AbVGICly
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 22:41:54 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:39831 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S263086AbVGIClG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2005 22:41:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050709024105.LVOJ15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 8 Jul 2005 22:41:05 -0400
To: Marc Singer <elf@buici.com>
In-Reply-To: <20050709013859.GA11947@buici.com> (Marc Singer's message of "Fri, 8 Jul 2005 18:38:59 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "MS" == Marc Singer <elf@buici.com> writes:

MS> If I've made several commits, I'd like to be able to gather several
MS> together and produce a patch file.  Better still, I'd like to be able
MS> to pick a set of discontiguous commits an bundle them into a single
MS> patch.  Ought I be using tags?

    You ought to be using ...

Oh, I want to say it because the above is what I do all the time
using my Porcelain on GIT, but on the other hand, officially I
am _not_ working on any Porcelain, so... I am in a dilemma.  I
won't talk about that tool I use myself.

Although I have not looked at it myself, you may want to take a
look at StGIT.

"Keeping patches, tracking upstream by primarily updating,
forward porting and e-mail submitting patches" is often the
development model taken by "individual developers", while
"making commits primarily by accepting patches, merging with
repos of other people who have similar aggregator role" is often
the model used by "project leads".

The core GIT (and "git" barebone Porcelain) is geared towards
"project lead" use, and I suspect Cogito would be so to a
certain extent.  By judging only from its description, StGIT,
with its attitude ancestry of quilt, may be more comfortable to
use with "individual developers" mode of operation.

Well, I'd say what I use anyway, and quickly duck ;-)

    You ought to be using ... JIT.
