From: Alexander Litvinov <lan@ac-sw.com>
Subject: Re: Something looks like CVS modules
Date: Fri, 11 Nov 2005 17:13:57 +0600
Organization: AcademSoft Ltd.
Message-ID: <200511111713.58018.lan@ac-sw.com>
References: <200511111313.27273.lan@ac-sw.com> <200511111642.25908.lan@ac-sw.com> <20051111105820.GN30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 12:14:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaWpz-0002Pq-W7
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 12:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVKKLMx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 06:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVKKLMx
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 06:12:53 -0500
Received: from gw.ac-sw.com ([81.1.223.2]:33213 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S1751139AbVKKLMw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 06:12:52 -0500
Received: from lan.ac-sw.lcl (unknown [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP
	id 31B61BD1B; Fri, 11 Nov 2005 17:12:51 +0600 (NOVT)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id E6629FBF09; Fri, 11 Nov 2005 17:13:58 +0600 (NOVT)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 509BABAD27;
	Fri, 11 Nov 2005 17:13:58 +0600 (NOVT)
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.8
In-Reply-To: <20051111105820.GN30496@pasky.or.cz>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on lan.ac-sw.lcl
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11586>

On Friday 11 November 2005 16:58, Petr Baudis wrote:
> > 1. The problem with checkout - single checkout should checkout all needed
> > modules to build project. Update should also update all modules. The same
> > with commit.
> > 2. Tags should be done on all modules. All modules should be able to be
> > in the same branch.
>
> > And in the same time one module should be able to exists in two or more
> > projects !
>
> Then just have only a bunch of directories in your project root, and
> that shall be your modules. :-)
>
> (CVS modules don't work like that either, do they?)

As far as CVS tracks tags/branches separatly for each file, tags abd branches 
work well for modules.

Bunch of directories is almost what I want except tags/branches/history. CVS 
does not care if two directories have separate root/repos. All it wants -is a 
properly CVS dir.

> But this is troublesome, and doesn't fit into GIT's model at all. Do you
> have any concrete example of a scenario where something like this would
> be useful?

For eaxmle: I have java lib A. I setup project B in this way:
B/src/
B/A/src

Have another project C:
C/src/
C/A/src

Both of them share the same code from library's module. I can tag them, edit, 
commit: do all work I usualy do. If I change something in B/A/src this will 
be updated into C/A/src.

This is what I dreaming about :-)
