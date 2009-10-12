From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Filesystem has no item: Working copy path [...] does not exist
	in repository at /usr/bin/git-svn line 3856
Date: Mon, 12 Oct 2009 15:45:42 -0700
Message-ID: <20091012224542.GB14143@dcvr.yhbt.net>
References: <9accb4400910120848n6a1e4036l5e45ce3882deb5aa@mail.gmail.com> <20091012182018.GA14143@dcvr.yhbt.net> <1255382764.15646.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 00:52:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxTkx-0006B9-Ok
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 00:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933110AbZJLWqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 18:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933179AbZJLWqV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 18:46:21 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40184 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933110AbZJLWqT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 18:46:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 34CDC1F78E;
	Mon, 12 Oct 2009 22:45:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1255382764.15646.5.camel@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130087>

Daniele Segato <daniele.bilug@gmail.com> wrote:
> In this case the repo was public, what should I do to debug some git-svn
> issue like that if I encounter a problem with a non-public repo?
> May be there is some debug flag I could enable? Or I had to
> guess/explore the svn tree?

I rely on the output of "svn log -v" extensively.

I'll also use strace, ltrace, tcpdump and/or put print statements
(combined with Data::Dumper) in various places of git-svn.
Unfortunately the git-svn code is quite ugly and I still haven't had the
time or energy to clean it up myself :<

-- 
Eric Wong
