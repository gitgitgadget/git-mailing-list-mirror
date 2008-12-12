From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Fri, 12 Dec 2008 19:57:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812121952320.5873@eeepc-johanness>
References: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: torvalds@osdl.org, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: David Howells <dhowells@redhat.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 19:57:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBDCl-00065v-5U
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 19:57:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbYLLS4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 13:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbYLLS4Q
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 13:56:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:44953 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750886AbYLLS4P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 13:56:15 -0500
Received: (qmail invoked by alias); 12 Dec 2008 18:56:12 -0000
Received: from ini-firewall.unizh.ch (EHLO eeepc-johanness) [130.60.5.218]
  by mail.gmx.net (mp015) with SMTP; 12 Dec 2008 19:56:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/T4W1/GxfTOeb2gFYHL6wLzsQhHzf1Ds4x+Kcdn8
	1K5+QySzzuE+Ef
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102926>

Hi,

On Fri, 12 Dec 2008, David Howells wrote:

>  Documentation/git-haters-guide.txt | 1283 ++++++++++++++++++++++++++++++++++++

I am sure we want to have something like that in git.git.

> +I don't really know what I'm doing with GIT either.

Strike the "either".

> +===============
> +OVERVIEW OF GIT
> +===============

Your overview seems to be what "Git from the bottom up" is all about (see 
the Git Wiki for more information where to find it).

>From my experience with new users, this is exactly the wrong way to go 
about it.  You don't introduce object types of the Git database before 
telling the users what the heck they are good for.  And most users do not 
need to bother with tree objects either, anyway.  So maybe you just tell 
them what the heck the object types are good for, without even teaching 
them the object types at all.

So I think that your document might do a good job scaring people away from 
Git.  But I do not believe that your document, especially in the tone it 
is written, does a good job of helping Git newbies.

Ciao,
Dscho

P.S.: No, I haven't read the whole document.  Still, I think I am 
qualified enough to estimate what the average reader's first impression 
would be.
