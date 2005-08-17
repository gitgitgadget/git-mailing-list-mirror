From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC PATCH] Add support for figuring out where in the git archive we are
Date: Tue, 16 Aug 2005 21:30:03 -0700
Message-ID: <7vmznh4244.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0508161536390.3553@g5.osdl.org>
	<7vll315u3w.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508161655460.3553@g5.osdl.org>
	<7vhddp5sfz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508161803250.3553@g5.osdl.org>
	<7vwtml490s.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508161946350.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 17 06:30:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5FZ7-0002hs-Gc
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 06:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVHQEaI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 00:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVHQEaI
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 00:30:08 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:39898 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750827AbVHQEaH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 00:30:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817043004.ZXQD15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 Aug 2005 00:30:04 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508161946350.3553@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 16 Aug 2005 19:50:37 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 16 Aug 2005, Junio C Hamano wrote:
>> 
>> Merged, pushed out, and tested.  Ouch.  Fails on t0000 test.
>
> It's because the new git-diff-files expects there to be a valid readable 
> .git/HEAD, and is unhappy since the test hasn't updated HEAD.

Ah, good catch.  So with this the beginning of the tutorial
should work; I think we introduce diff-files before making a
commit.  Thanks.
