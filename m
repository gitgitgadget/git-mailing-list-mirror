From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 21:50:21 +0200
Message-ID: <1113681021.28612.29.camel@tglx.tec.linutronix.de>
References: <20050416131528.GB19908@elte.hu>
	 <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
	 <1113679421.28612.16.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.58.0504161135480.7211@ppc970.osdl.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 20:46:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMsJe-00040q-OS
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 20:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVDPSu1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 14:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbVDPSu1
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 14:50:27 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:63672
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262729AbVDPSuW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 14:50:22 -0400
Received: from mail.tec.linutronix.de (213-239-205-147.clients.your-server.de [213.239.205.147])
	by mail.tglx.de (Postfix) with ESMTP id A7DE265C003;
	Sat, 16 Apr 2005 20:49:08 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 06E4128222;
	Sat, 16 Apr 2005 20:50:22 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504161135480.7211@ppc970.osdl.org>
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-16 at 11:44 -0700, Linus Torvalds wrote:

> That level of abstraction ("we never look directly at the objects") is 
> what allows us to change the object structure later. For example, we 
> already changed the "commit" date thing once, and the tree object has 
> obviously evolved a bit, and if we ever change the hash, the objects will 
> change too, but if you always just script them using nice helper tools, 
> you won't ever need to _care_. And that's how it should be.

For the export stuff its terrible slow. :(

I agree that using common tools is good. But we talk also about an open
format, so using a script to speed up certain tasks is not bad at all.

tglx



