From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cg-commit does not run pre-commit hook?
Date: Thu, 12 Oct 2006 09:59:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610120957460.3952@g5.osdl.org>
References: <20061012155444.27391353BDE@atlas.denx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 19:01:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY3uR-00061o-B5
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 18:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbWJLQ7s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 12:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbWJLQ7s
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 12:59:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28342 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932644AbWJLQ7r (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Oct 2006 12:59:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9CGxPaX032249
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Oct 2006 09:59:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9CGxOab002009;
	Thu, 12 Oct 2006 09:59:25 -0700
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20061012155444.27391353BDE@atlas.denx.de>
X-Spam-Status: No, hits=-0.467 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28789>



On Thu, 12 Oct 2006, Wolfgang Denk wrote:
> > 
> > git log
> 
> Sorry, this does not work, as I can access the  commit  message  only
> *after* the commit completed, and then it's too late to get it into a
> file that shall be included with the very same commit.

Why? That's just stupid.

If you want to have a ChangeLog file, it's _much_ better to just 
auto-generate it after the fact. When you cut a tar-file, just have the 
script autogenerate the changelog then and there. Why do it inside the 
SCM that keeps track of the data _anyway_.

> True, as long as you can work within the SCM. The changelog file  I'm
> talking  about is mostly for people who just work with exported trees
> (for example, when they download a tarball).

Right - but it's easy enough to add it to the tar-ball, so..

		Linus
