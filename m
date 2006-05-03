From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Git wiki
Date: Wed, 3 May 2006 10:40:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605031037250.4086@g5.osdl.org>
References: <7virooj92i.fsf@assigned-by-dhcp.cox.net>
 <4d8e3fd30605030139k33c5a404k54861fdd02c87134@mail.gmail.com>
 <20060503090007.GM27689@pasky.or.cz> <4d8e3fd30605030213r625ce87fw5cbee554f1c20fbd@mail.gmail.com>
 <Pine.LNX.4.64.0605030934220.28543@localhost.localdomain>
 <20060503142957.GA9056@spearce.org> <4458C5D7.8010501@op5.se>
 <Pine.LNX.4.64.0605030817580.4086@g5.osdl.org> <20060503164732.GB9820@thunk.org>
 <Pine.LNX.4.64.0605030958370.4086@g5.osdl.org> <20060503171538.GC9820@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Shawn Pearce <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 19:40:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbLLI-0006f0-7r
	for gcvg-git@gmane.org; Wed, 03 May 2006 19:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWECRkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 13:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWECRkt
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 13:40:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57477 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030264AbWECRks (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 13:40:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k43HeQtH009352
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 May 2006 10:40:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k43HeLUJ008286;
	Wed, 3 May 2006 10:40:23 -0700
To: Theodore Tso <tytso@mit.edu>
In-Reply-To: <20060503171538.GC9820@thunk.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19505>



On Wed, 3 May 2006, Theodore Tso wrote:
> 
> Yeah, but the fact that you have to use repack and prune in order to
> keep the disk space usage from exploding (especially with the Linux
> 2.6 tree) , means that we have to expose that mess to the beginning
> user.

No you don't. You get it packed when it's cloned, and the disk usage 
doesn't go up _that_ fast. By the time you need to worry about disk usage 
you have certainly had time to learn the basics.

No need to start talking about fsck or repacking until the second day.

> Could git be made to do the repacking automatically when it makes sense 
> using some hueristic algorithm?

This was discussed, and yeah, it _could_, but I suspect you really don't 
want to repack in the middle of some op. Even if your repo was _mostly_ 
packed, it's an irritating hickup at a time when you don't need to.

I think it's much better to teach people to repack once a week (if that). 
But to teach them only after they've already _used_ it for a week and 
aren't intimidated by the basic ops any longer.

		Linus
