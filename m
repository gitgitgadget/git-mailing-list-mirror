From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Terminology] Push vs. upload?
Date: Mon, 19 Sep 2005 18:59:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509191858020.2553@g5.osdl.org>
References: <20050920001136.GK18320@pasky.or.cz> <Pine.LNX.4.58.0509191753100.2553@g5.osdl.org>
 <20050920014448.GA30912@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 04:00:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHXQ9-0002UR-OH
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 03:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbVITB7d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 21:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbVITB7d
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 21:59:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60106 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964833AbVITB7c (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 21:59:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8K1xIBo025903
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Sep 2005 18:59:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8K1xFLN029544;
	Mon, 19 Sep 2005 18:59:16 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050920014448.GA30912@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8949>



On Tue, 20 Sep 2005, Petr Baudis wrote:
> 
> Yes, but I'm just arguing about the naming - if you just take the word
> "pull", "push" is the obvious opposite to that and vice versa, so if we
> are going to use words "pull" and "push" in the same context, this
> relation should be preserved. So "push" really _should_ mean
> 
> 	ssh other-end 'git-pull'

Well, I actually called it "send" as in "git-send-pack".

But anybody who has ever used BK would still type "push", so I'd make that 
an alias anyway.

Not "upload". Upload is the reverse of "download", and we don't do that.

		Linus
