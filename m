From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Cogito-0.15
Date: Mon, 19 Sep 2005 17:51:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509191750480.2553@g5.osdl.org>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net> <7vwtleyml5.fsf@assigned-by-dhcp.cox.net>
 <20050919011428.GF22391@pasky.or.cz> <20050919231538.GA4074@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 02:53:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHWMc-0006sB-FH
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 02:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVITAv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 20:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbVITAv7
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 20:51:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57279 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964811AbVITAv7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 20:51:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8K0pnBo022252
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Sep 2005 17:51:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8K0pmm2027048;
	Mon, 19 Sep 2005 17:51:48 -0700
To: Pavel Machek <pavel@suse.cz>
In-Reply-To: <20050919231538.GA4074@elf.ucw.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8942>



On Tue, 20 Sep 2005, Pavel Machek wrote:
> 
> Could we keep at least the cg-update name? It is certainly not a
> *pull* because it does update local repository (and tree, too).

That _is_ what "pull" means.

"fetch" is the one that only updates the history. A "pull" also does a
merge and updates the current branch _and_ the currently checked out tree.

		Linus
