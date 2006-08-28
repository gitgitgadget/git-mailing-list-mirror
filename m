From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/5] gitweb: Additions to commitdiff view
Date: Mon, 28 Aug 2006 10:26:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608281016380.27779@g5.osdl.org>
References: <11567692943154-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 19:26:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHksh-0006H9-RC
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 19:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWH1R00 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 13:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWH1R0Z
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 13:26:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28636 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750795AbWH1R0Y (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 13:26:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7SHQJnW014583
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 28 Aug 2006 10:26:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7SHQIlN005412;
	Mon, 28 Aug 2006 10:26:19 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <11567692943154-git-send-email-jnareb@gmail.com>
X-Spam-Status: No, hits=-0.937 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26168>



On Mon, 28 Aug 2006, Jakub Narebski wrote:
>
> This series of patches makes signoff lines to be not removed in commitdiff and log 
> views, adds author information to comittdiff view, and adds diff tree with links
> to patches in commitdiff view.
> 
> You will be able to see it at work at
>   http://front.fuw.edu.pl/cgi-bin/jnareb/gitweb.cgi

Goodie, that looks exactly like I envisioned. And the shortcuts to find 
the patch to a specific file (when the patch is larger) works beautifully.

Now I think "commit-diff" is prettier than the "commit" view (the latter 
ends up showing the "--pretty=full" information, which can be useful, but 
usually is just distracting). That's as it should be - I consider 
"commit-diff" to be the _normal_ thing, and then the "commit" view is the 
"give me all the ugly details in just the commit".

I've got _one_ small beef with gitweb still, which is that it seems to 
like always showing things in UTC rather than the "native" timezone, but I 
can see why people would sometimes want that. So I'm not actually sure 
it's wrong.

I think it _may_ be worth showing the native timezone in the "commit-diff" 
view (when you see only one commit), and then show the UTC time in the 
"log" view (when you see a lot of commits, and might want to compare times 
in different timezones more easily).

But I think that timezone thing is probably a matter of taste rather than 
much anything else.

Thanks,

		Linus
