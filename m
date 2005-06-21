From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git merging
Date: Tue, 21 Jun 2005 08:53:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506210851260.2268@ppc970.osdl.org>
References: <20050617183914.GX6957@suse.de> <Pine.LNX.4.58.0506171142500.2268@ppc970.osdl.org>
 <42B357D7.6030302@pobox.com> <Pine.LNX.4.58.0506171629320.2268@ppc970.osdl.org>
 <42B36207.3020209@pobox.com> <Pine.LNX.4.58.0506171700200.2268@ppc970.osdl.org>
 <20050620123053.GI15021@suse.de> <Pine.LNX.4.58.0506200844420.2268@ppc970.osdl.org>
 <20050620203821.GC7712@suse.de> <Pine.LNX.4.58.0506201410050.2268@ppc970.osdl.org>
 <20050621145919.GB12271@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 17:48:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dkkyk-0001TU-AD
	for gcvg-git@gmane.org; Tue, 21 Jun 2005 17:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVFUPxk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Jun 2005 11:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVFUPxc
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jun 2005 11:53:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39337 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262152AbVFUPvJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2005 11:51:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5LFotjA022093
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 21 Jun 2005 08:50:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5LFosiC010739;
	Tue, 21 Jun 2005 08:50:55 -0700
To: Jens Axboe <axboe@suse.de>
In-Reply-To: <20050621145919.GB12271@suse.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 21 Jun 2005, Jens Axboe wrote:
> 
> Isn't that a little 'end user' confusing from a usability point of view,
> that it behaves differently depending on which pull script it ends up
> using in the end?

Yes, I'm not claiming it's good, I'm just claiming it explains what you 
see ;)

So it's a bug, but I'm hoping somebody else will fix it. I've not actually
worked on that "intelligent pull" functionality at all (aside from making
the ssh-push thing work for my limited use).

			Linus
