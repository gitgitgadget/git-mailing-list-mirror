From: Miles Bader <miles@lsi.nec.co.jp>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Thu, 23 Jun 2005 15:07:55 +0900
Message-ID: <buofyv9wqpw.fsf@mctpc71.ucom.lsi.nec.co.jp>
References: <42B9E536.60704@pobox.com>
	<Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
	<42BA18AF.2070406@pobox.com>
	<Pine.LNX.4.58.0506221915280.11175@ppc970.osdl.org>
	<07be01c577a7$05108660$03c8a8c0@kroptech.com>
	<Pine.LNX.4.58.0506222146460.11175@ppc970.osdl.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Kropelin <akropel1@rochester.rr.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 08:02:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlKn4-0007pP-6J
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 08:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVFWGIa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 02:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVFWGIa
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 02:08:30 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:25993 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262151AbVFWGIX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2005 02:08:23 -0400
Received: from mailgate3.nec.co.jp (mailgate53.nec.co.jp [10.7.69.162] (may be forged))
	by tyo202.gate.nec.co.jp (8.11.7/3.7W01080315) with ESMTP id j5N681m24407;
	Thu, 23 Jun 2005 15:08:01 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id j5N681Q16877; Thu, 23 Jun 2005 15:08:01 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.50]) by mailsv.nec.co.jp (8.11.7/3.7W-MAILSV-NEC) with ESMTP
	id j5N680C16699; Thu, 23 Jun 2005 15:08:00 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay21.aps.necel.com with ESMTP; Thu, 23 Jun 2005 15:08:00 +0900
Received: from edsgm01.lsi.nec.co.jp ([10.50.208.11] [10.50.208.11]) by relay31.aps.necel.com with ESMTP; Thu, 23 Jun 2005 15:08:00 +0900
Received: from mcsss2.ucom.lsi.nec.co.jp (localhost [127.0.0.1])
	by edsgm01.lsi.nec.co.jp (8.12.10/8.12.10) with ESMTP id j5N67ull023832;
	Thu, 23 Jun 2005 15:07:58 +0900 (JST)
Received: from mctpc71 (mctpc71.ucom.lsi.nec.co.jp [10.30.118.121])
	by mcsss2.ucom.lsi.nec.co.jp (8.12.10/8.12.8/EDcg v2.01-mc/1046780839) with ESMTP id j5N67tKt025960;
	Thu, 23 Jun 2005 15:07:55 +0900 (JST)
Received: by mctpc71 (Postfix, from userid 31295)
	id 7A82B406; Thu, 23 Jun 2005 15:07:55 +0900 (JST)
To: Linus Torvalds <torvalds@osdl.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <Pine.LNX.4.58.0506222146460.11175@ppc970.osdl.org> (Linus Torvalds's message of "Wed, 22 Jun 2005 21:54:23 -0700 (PDT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:
> And if you have more than a few files dirty in your tree, I really think
> it's much better to do "git status" and think about it a bit and select
> the files you do want to commit than it is to just do "git commit" and let
> it rip.
>
> Now, I could well imagine adding an "--all" flag (and not even allow the 
> shorthane version) to both git-update-cache and "git commit". So that you 
> could say "commit all the dirty state", but you'd at least have to think 
> about it before you did so.

I think both modes of operation are useful -- sometimes I want to hack
in the tree and later decide what to commit, and sometimes I know
exactly what sequence of commits I want to make and do a series of
"change-some-files then commit everything" steps.

In the latter case, it's very convenient to have commit just grab
everything and clear the slate for my next step.  Morever, I use the
latter style enough that I think even the requirement of a long option
seems annoying and artificial; a short option would be fine though...

-Miles
-- 
Any man who is a triangle, has thee right, when in Cartesian Space, to
have angles, which when summed, come to know more, nor no less, than
nine score degrees, should he so wish.  [TEMPLE OV THEE LEMUR]
