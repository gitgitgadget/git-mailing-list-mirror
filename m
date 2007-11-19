From: Jonas Juselius <jonas.juselius@chem.uit.no>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 14:33:15 +0000 (UTC)
Message-ID: <loom.20071119T142453-421@post.gmane.org>
References: <1195477504.8093.15.camel@localhost> <fhs33j$eg9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 15:40:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu7nZ-00033F-Mx
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 15:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbXKSOkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 09:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753430AbXKSOkM
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 09:40:12 -0500
Received: from main.gmane.org ([80.91.229.2]:47528 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbXKSOkL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 09:40:11 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Iu7n8-0003Lu-Pb
	for git@vger.kernel.org; Mon, 19 Nov 2007 14:40:02 +0000
Received: from snowflake.chem.uit.no ([129.242.24.54])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 14:40:02 +0000
Received: from jonas.juselius by snowflake.chem.uit.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 14:40:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 129.242.24.54 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8) Gecko/20071022 Ubuntu/7.10 (gutsy) Firefox/2.0.0.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65449>

Jakub Narebski <jnareb <at> gmail.com> writes:
> 
> A few comments (from what I checked so far):
> 
> 1. It is "man git-checkout" (or "git checkout --help"),
>    not "man git checkout"
> 
> 2. Instead of using 'verbatim' environment directly to show example CLI
>    session it would be I think better to define verbatim-like environment
>    for this ('example', 'commands', 'CLI', 'session'); perhaps replacing
>    verbatim by lstlisting from the listings/lstlisting package for syntax
>    highlighting.
> 

First, it seems that it was not entirely clear to everybody that it's possible
to clone the repository:

git clone http://git.jonas.iki.fi/git_guides.git

Thanks for the comments: 

1. I did a global subst from the git-command to git
command instead form, and forgot about the man pages ;)

2. You are entirely right of course, but I was a bit lazy. I'll fix it at some
point. lstlistings is a very nice package.
