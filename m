From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Terminology] Push vs. upload?
Date: Mon, 19 Sep 2005 17:55:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509191753100.2553@g5.osdl.org>
References: <20050920001136.GK18320@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 02:56:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHWPq-0007UH-Nr
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 02:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVITAzU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 20:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVITAzU
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 20:55:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23488 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964812AbVITAzU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 20:55:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8K0t8Bo022402
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Sep 2005 17:55:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8K0t8tX027190;
	Mon, 19 Sep 2005 17:55:08 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050920001136.GK18320@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8943>



On Tue, 20 Sep 2005, Petr Baudis wrote:
> 
>   I've realized today that I "forgot" to rename cg-push to cg-upload, so
> I impulsively did so right away, but now I'm seeing that the core git
> still has git-push and no git-upload. This is confusing and appears to
> be quite inconsistent - push should be the opposite of pull

No. There is no opposite of pull. You can't update the tree on the other 
end. It's fundamentally an unsafe operation - the other end is by 
definition not a private tree.

(Or, if you want to see it another way: "pull" is "pull"s own opposite:  
"ssh other-end + git pull from that end" ends up being what you mean.)

		Linus
