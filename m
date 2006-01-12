From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linus repository at git.kernel.org???
Date: Thu, 12 Jan 2006 07:58:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601120754490.3535@g5.osdl.org>
References: <2cd57c900601112153t2d85895bg@mail.gmail.com>
 <7vr77dud41.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Coywolf Qi Hunt <coywolf@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 16:58:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex4qG-0004Gr-2y
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 16:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWALP6R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 10:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWALP6R
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 10:58:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37025 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751423AbWALP6Q (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2006 10:58:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0CFw7DZ025569
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Jan 2006 07:58:08 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0CFw6Ap023577;
	Thu, 12 Jan 2006 07:58:07 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr77dud41.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14566>



On Wed, 11 Jan 2006, Junio C Hamano wrote:

> Coywolf Qi Hunt <coywolf@gmail.com> writes:
> 
> > gemini:~/linux/linux-2.6> git-pull
> > fatal: unexpected EOF
> > Fetch failure: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> The failure does not seem to happen on all repositories, but
> just is with Linus repository, so I doubt "git update" on either
> your end or kernel.org public machines have anything to do with
> this.  And Linus repository from gitweb is also missing.

The mirroring was delayed for a while, but seems to be ok now.

I repacked my archive (exactly because mirroring was so slow) and while 
the result was always a valid archive on the master site, if you pulled 
when mirroring was starting to delete the unpacked objects but had not yet 
mirrored the new pack, you'd get something like the above - git-daemon 
would exit because of a "missing" object).

I think it should be ok now (at least it seems to have mirrored out things 
over-night, and gitweb now matches my local head again).

		Linus
