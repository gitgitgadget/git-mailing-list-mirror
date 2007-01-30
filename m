From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 10:41:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701301040200.3611@woody.linux-foundation.org>
References: <17855.35058.967318.546726@lisa.zopyra.com> <epo1tn$9sl$1@sea.gmane.org>
 <17855.35845.922009.364704@lisa.zopyra.com> <20070130182237.GC26415@spearce.org>
 <17855.36470.309129.391271@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 19:41:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBxuv-000058-LF
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 19:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbXA3SlK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 13:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbXA3SlK
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 13:41:10 -0500
Received: from smtp.osdl.org ([65.172.181.24]:41984 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbXA3SlI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 13:41:08 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0UIf41m018777
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 30 Jan 2007 10:41:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0UIf3XM025267;
	Tue, 30 Jan 2007 10:41:03 -0800
In-Reply-To: <17855.36470.309129.391271@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.458 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38184>



On Tue, 30 Jan 2007, Bill Lear wrote:
> 
> % cd /repos/git/project
> % ls
> branches  description  HEAD   info     refs
> config    FETCH_HEAD   hooks  objects  remotes
> % cat HEAD
> ref: refs/heads/master

Ok, HEAD points to "master".

> This repository was created like this:
> 
> % mkdir /repos/git/project
> % cd /repos/git/project
> % git --bare init-db --shared
> % GIT_DIR=. git fetch git://xiphi/public/project topic:topic

...but you don't _have_ any such branch. You only have a "topic" branch.

		Linus
