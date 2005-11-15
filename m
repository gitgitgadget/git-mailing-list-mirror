From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 10:01:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511150957220.3945@g5.osdl.org>
References: <1132034390.22207.18.camel@dv> <7vveyuqto5.fsf@assigned-by-dhcp.cox.net>
 <1132042427.3512.50.camel@dv> <7vpsp2qpx4.fsf@assigned-by-dhcp.cox.net>
 <7vd5l2mco1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511151207070.21671@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051115121854.GV30496@pasky.or.cz> <7v8xvpn8ne.fsf@assigned-by-dhcp.cox.net>
 <1132075295.25640.59.camel@dv> <Pine.LNX.4.64.0511150931010.3945@g5.osdl.org>
 <20051115174213.GO16061@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pavel Roskin <proski@gnu.org>, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 19:02:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec58I-0002kz-B8
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 19:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbVKOSCG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 13:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbVKOSCF
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 13:02:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24222 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964965AbVKOSCD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 13:02:03 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAFI1YnO023615
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 15 Nov 2005 10:01:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAFI1Wbr011543;
	Tue, 15 Nov 2005 10:01:33 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051115174213.GO16061@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11927>



On Tue, 15 Nov 2005, Petr Baudis wrote:
> 
> If you show me a way how to do git-symbolic-ref over HTTP, I will be
> most grateful. :-)

Hmm, why do you care?

If you do a fetch over http, you'd just fetch HEAD directly. If that's 
just a SHA1 (like it will be with a symlink) you'll just use that as the 
branch (and don't care about what branch it was). And if it's a symref, 
you can see what the branch should be and fetch that. No?

			Linus
