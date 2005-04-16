From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 22:35:30 +0200
Message-ID: <1113683730.28612.34.camel@tglx.tec.linutronix.de>
References: <20050416131528.GB19908@elte.hu>
	 <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
	 <1113679421.28612.16.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.58.0504161135480.7211@ppc970.osdl.org>
	 <1113681021.28612.29.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.58.0504161208410.7211@ppc970.osdl.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 21:32:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMt1c-00005a-51
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 21:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbVDPTfl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 15:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbVDPTfl
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 15:35:41 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:64184
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262734AbVDPTfg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 15:35:36 -0400
Received: from mail.tec.linutronix.de (213-239-205-147.clients.your-server.de [213.239.205.147])
	by mail.tglx.de (Postfix) with ESMTP id C093C65C003;
	Sat, 16 Apr 2005 21:34:22 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 210A928235;
	Sat, 16 Apr 2005 21:35:31 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504161208410.7211@ppc970.osdl.org>
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-16 at 12:15 -0700, Linus Torvalds wrote:
> 
> On Sat, 16 Apr 2005, Thomas Gleixner wrote:
> > 
> > For the export stuff its terrible slow. :(
>
> What kind of _strange_ scripting architecture is so fast that there's a
> difference between "cat-file" and "ls-tree" and can handle 17,000 files in
> 60,000 revisions, yet so slow that you can't trivially convert 20 bytes of 
> data?

Sorry I was neither talking about "cat-file ..." nor about the 20 byte
conversion. I was talking about the bk export script, which writes the
objects itself. Doing this with the git-tools would slow it down, as I
have the retrieved data already in memory. It does not slow me down to
create the binary ref, but its annoying.

I just figured, that some revtools might have the need to use direct
pointers into objects and face the same problem the other way round.

tglx


