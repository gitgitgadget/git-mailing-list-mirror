From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: killing a branch
Date: Tue, 10 Jan 2006 09:12:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601100910530.4939@g5.osdl.org>
References: <20060110102207.GP3389@suse.de> <7vr77g8jm4.fsf@assigned-by-dhcp.cox.net>
 <20060110103533.GT3389@suse.de> <7vy81o73t2.fsf@assigned-by-dhcp.cox.net>
 <20060110112608.GU3389@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 18:13:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwN3T-0001gN-NB
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 18:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWAJRNE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 12:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWAJRND
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 12:13:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49879 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932270AbWAJRNB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 12:13:01 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0AHCsDZ019470
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Jan 2006 09:12:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0AHCrMB002945;
	Tue, 10 Jan 2006 09:12:53 -0800
To: Jens Axboe <axboe@suse.de>
In-Reply-To: <20060110112608.GU3389@suse.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14428>



On Tue, 10 Jan 2006, Jens Axboe wrote:
> 
> Alright, I'll just have to shake the habit of running git prune to rid
> myself of that dirty dirty feeling.

Yeah, I'm slowly shaking it off too. I used to run git-fsck-objects 
religiously just because I worried about bugs. I still do it, but 
especially with the recursive-strategy merging, I get "dangling blob" 
messages every once in a while that are _not_ due to bugs, but just due to 
the temporary merge object.

So I'm learning to ignore them, and prune the tree only occasionally, 
instead of compulsively every time.

		Linus
