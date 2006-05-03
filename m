From: Theodore Tso <tytso@mit.edu>
Subject: Re: [ANNOUNCE] Git wiki
Date: Wed, 3 May 2006 13:15:38 -0400
Message-ID: <20060503171538.GC9820@thunk.org>
References: <7virooj92i.fsf@assigned-by-dhcp.cox.net> <4d8e3fd30605030139k33c5a404k54861fdd02c87134@mail.gmail.com> <20060503090007.GM27689@pasky.or.cz> <4d8e3fd30605030213r625ce87fw5cbee554f1c20fbd@mail.gmail.com> <Pine.LNX.4.64.0605030934220.28543@localhost.localdomain> <20060503142957.GA9056@spearce.org> <4458C5D7.8010501@op5.se> <Pine.LNX.4.64.0605030817580.4086@g5.osdl.org> <20060503164732.GB9820@thunk.org> <Pine.LNX.4.64.0605030958370.4086@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Shawn Pearce <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 19:17:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbKxs-0002Jk-Jt
	for gcvg-git@gmane.org; Wed, 03 May 2006 19:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWECRQh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 13:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWECRQh
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 13:16:37 -0400
Received: from thunk.org ([69.25.196.29]:64926 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030255AbWECRQh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 13:16:37 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1FbKxh-0001gt-HY; Wed, 03 May 2006 13:16:29 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.60)
	(envelope-from <tytso@thunk.org>)
	id 1FbKws-0003YG-LU; Wed, 03 May 2006 13:15:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605030958370.4086@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19503>

On Wed, May 03, 2006 at 10:06:25AM -0700, Linus Torvalds wrote:
> Even the "everyday git in 20 commands" actually starts out scaring people 
> with listing commands that they don't need to know about immediately. The 
> whole fsck/count-object/pruning thing shouldn't even be mentioned until 
> after you've shown how easy it is to just do
> 
> 	git init-db
> 	git add .
> 	git commit -a
> 
> to import an old project, and then do an example commit or something 
> (one of the early examples).

Yeah, but the fact that you have to use repack and prune in order to
keep the disk space usage from exploding (especially with the Linux
2.6 tree) , means that we have to expose that mess to the beginning
user.  Could git be made to do the repacking automatically when it
makes sense using some hueristic algorithm?

						- Ted
