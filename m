From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Improve "git grep" flags handling
Date: Mon, 12 Sep 2005 15:43:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509121542050.3266@g5.osdl.org>
References: <Pine.LNX.4.58.0509121203210.4098@g5.osdl.org>
 <7vbr2y7yfd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509121500400.3266@g5.osdl.org>
 <Pine.LNX.4.58.0509121519310.3266@g5.osdl.org> <7vd5nd7w0x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 00:44:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEx1t-0003fM-QI
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 00:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVILWn7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 18:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVILWn7
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 18:43:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7064 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932323AbVILWn6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 18:43:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8CMhrBo027603
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Sep 2005 15:43:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8CMhq43025337;
	Mon, 12 Sep 2005 15:43:53 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5nd7w0x.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8447>



On Mon, 12 Sep 2005, Junio C Hamano wrote:
> 
> This would not fly well, I am afraid.  --exclude=* are usually
> shell globs which would be expanded before you use them
> unquoted.

Good point. However, since it's unlikely that anybody will use it, maybe 
it's not important - more of a "this is how you could do it if you fixed 
the globbing problem" ;)

It's easy enough to fix if you use bash array variables, but I thought 
adding that was not supposed to be done? Or have people resigned 
themselves to bash extensions ;)

		Linus
