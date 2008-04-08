From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: question about git and remote repositories
Date: Tue, 8 Apr 2008 22:08:25 +0200
Message-ID: <200804082208.26220.barra_cuda@katamail.com>
References: <47FBC2C9.6060702@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ittay Dror <ittayd@tikalk.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 22:07:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjK6H-0004Jy-11
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 22:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376AbYDHUGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 16:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757059AbYDHUGj
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 16:06:39 -0400
Received: from smtp.katamail.com ([62.149.157.154]:51426 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1755237AbYDHUGi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 16:06:38 -0400
Received: (qmail 11836 invoked by uid 89); 8 Apr 2008 20:06:29 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host63-56-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.56.63)
  by smtp1-pc with SMTP; 8 Apr 2008 20:06:27 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <47FBC2C9.6060702@tikalk.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79022>

On Tuesday 08 April 2008, Ittay Dror wrote:
> If I want to start working on a project that uses git (and I want to use 
> git also), I first need to clone the project's repo. That is very slow 
> (using the git:// protocol). Are there alternatives? For example, as far 
> as I understand, if all I want is to get the latest commit in HEAD, 
> branch from it and start working, then all git really needs to have is 
> all objects referenced from that commit (commit, trees, blobs) and 
> that's it, right? (as long as I don't expect to see full log of past 
> operations)

In git terms, that is called a "shallow clone". For example:

git clone --depth 5 git://site.com/repo.git

would clone all the heads of repo.git along with their 5 most
recent commits.

You can make history deeper with

git-fetch --depth 20 git://site.com/repo.git branch

See the glossary, technical/shallow.txt, git-clone and git-fetch
man pages.
