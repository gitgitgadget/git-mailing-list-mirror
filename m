From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 21:41:17 +0200
Message-ID: <1113680477.28612.24.camel@tglx.tec.linutronix.de>
References: <20050416131528.GB19908@elte.hu>
	 <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
	 <1113679421.28612.16.camel@tglx.tec.linutronix.de>
	 <20050416183232.GH19099@pasky.ji.cz>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 20:37:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMsAm-0003Jm-41
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 20:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVDPSlV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 14:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbVDPSlV
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 14:41:21 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:62648
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262725AbVDPSlT
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 14:41:19 -0400
Received: from mail.tec.linutronix.de (213-239-205-147.clients.your-server.de [213.239.205.147])
	by mail.tglx.de (Postfix) with ESMTP id 5F25565C003;
	Sat, 16 Apr 2005 20:40:05 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 6CC5328222;
	Sat, 16 Apr 2005 20:41:18 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050416183232.GH19099@pasky.ji.cz>
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-16 at 20:32 +0200, Petr Baudis wrote:
> Dear diary, on Sat, Apr 16, 2005 at 09:23:40PM CEST, I got a letter
> where Thomas Gleixner <tglx@linutronix.de> told me that...
> > One remark on the tree blob storage format. 
> > The binary storage of the sha1sum of the refered object is a PITA for
> > scripting. 
> > Converting the ASCII -> binary for the sha1sum comparision should not
> > take much longer than the binary -> ASCII conversion for the file
> > reference. Can this be changed ?
> 
> Huh, you aren't supposed to peek into trees directly. What's wrong with
> ls-tree?

Why I'm not supposed ? Is this evil ?

My export script has all the data available, so I write the tree refs
directly. The full export runs ~1 hour. Thats long enough :) I tried the
git way and it slows me down by factor "BIG" (I dont remember the
number)

Also for reference tracking all the information might be available e.g.
by a database. Why should the revtool then use some tool to retrieve
information which is already there ?

tglx


