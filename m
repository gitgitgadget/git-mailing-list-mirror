From: Peter Osterlund <petero2@telia.com>
Subject: Re: Fix interesting git-rev-list corner case
Date: 31 Jul 2005 01:11:19 +0200
Message-ID: <m3ack3nb3c.fsf@telia.com>
References: <Pine.LNX.4.58.0507291542060.29650@g5.osdl.org>
	<m31x5gob8k.fsf@telia.com>
	<Pine.LNX.4.58.0507300913000.29650@g5.osdl.org>
	<m3fytwm313.fsf@telia.com>
	<Pine.LNX.4.58.0507301354000.29650@g5.osdl.org>
	<Pine.LNX.4.58.0507302259140.26128@telia.com>
	<Pine.LNX.4.58.0507301428300.29650@g5.osdl.org>
	<Pine.LNX.4.58.0507301507390.29650@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 01:12:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dz0Uc-0002Uh-Dg
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 01:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbVG3XLj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 19:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbVG3XLj
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 19:11:39 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:27632 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S263183AbVG3XLi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2005 19:11:38 -0400
Received: from r3000.localdomain (212.181.179.130) by pne-smtpout2-sn2.hy.skanova.net (7.2.060.1)
        id 42B94E29005FCCBE; Sun, 31 Jul 2005 01:11:27 +0200
Received: from r3000.localdomain (r3000.localdomain [127.0.0.1])
	by r3000.localdomain (8.13.1/8.13.1) with ESMTP id j6UNBLM5015237;
	Sun, 31 Jul 2005 01:11:21 +0200
Received: (from petero@localhost)
	by r3000.localdomain (8.13.1/8.13.1/Submit) id j6UNBK0I015231;
	Sun, 31 Jul 2005 01:11:20 +0200
X-Authentication-Warning: r3000.localdomain: petero set sender to petero2@telia.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507301507390.29650@g5.osdl.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 30 Jul 2005, Linus Torvalds wrote:
> > 
> > Yup, it's git-merge-base, and it is confused by the same thing that 
> > confused git-rev-list.
> > 
> > Thanks, I'll fix it.
> 
> Hmm.. Here's a tentative fix. I'm not really happy with it, and maybe
> somebody else can come up with a better one. I think this one ends up
> being quite a bit more expensive than the old one (it will look up _all_
> common parents that have a child that isn't common, and then select the
> newest one of the bunch), but I haven't really thought it through very
> much.
> 
> I bet there is a smarter way to do this, but this _should_ fix the problem
> Peter sees. Peter?

Yes, it does fix the problem. Thanks.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
