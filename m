From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 19:21:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609271918350.3952@g5.osdl.org>
References: <20060928013914.16514.qmail@web51005.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Pearce <spearce@spearce.org>, Andreas Ericsson <ae@op5.se>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 04:21:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSlWs-0005P9-RN
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 04:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbWI1CVf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 22:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbWI1CVf
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 22:21:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20884 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965201AbWI1CVf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 22:21:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8S2LNnW013888
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Sep 2006 19:21:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8S2LM00026012;
	Wed, 27 Sep 2006 19:21:22 -0700
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060928013914.16514.qmail@web51005.mail.yahoo.com>
X-Spam-Status: No, hits=-0.464 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.154 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27967>



On Wed, 27 Sep 2006, Matthew L Foster wrote:
> 
> From a web display/generic notion of integrity perspective time order 
> matters to me but it looks like I am the only one. Keeping track of 
> _local_ commit time would not add any dependencies.

Actually, I think one problem here is that anybody why looks at just the 
gitweb interface may not realize how git works.

If you use gitk as your primary way of learning about a git problem, the 
whole time issue just goes away, because gitk shows the _real_ 
relationships so well.

I used gitk in all my initial explanations of git, because it turned a 
fairly abstract "here, let me explain how it works" into a "See? Look at 
this" kind of situation.

I think gitweb is great (in a way I have _never_ felt about any of the CVS 
web interfaces I have ever seen), but gitweb doesn't really explain how 
things work as well as gitk does.

		Linus
