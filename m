From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: GIT Web Interface
Date: Tue, 19 Apr 2005 17:59:45 +0200
Message-ID: <1113926385.29953.7.camel@localhost.localdomain>
References: <20050419004415.GA10628@vrfy.org>
	 <20050419005244.GR5554@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 17:56:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNv4f-0005F1-E7
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 17:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVDSP7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 11:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVDSP7t
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 11:59:49 -0400
Received: from soundwarez.org ([217.160.171.123]:21706 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261515AbVDSP7r (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 11:59:47 -0400
Received: from dhcp-113.off.vrfy.org (d098254.adsl.hansenet.de [80.171.98.254])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id BC43A17374;
	Tue, 19 Apr 2005 17:59:45 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050419005244.GR5554@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2005-04-19 at 02:52 +0200, Petr Baudis wrote:
> Dear diary, on Tue, Apr 19, 2005 at 02:44:15AM CEST, I got a letter
> where Kay Sievers <kay.sievers@vrfy.org> told me that...
> > I'm hacking on a simple web interface, cause I missed the bkweb too much.
> > It can't do much more than browse through the source tree and show the
> > log now, but that should change... :)
> >   http://ehlo.org/~kay/gitweb.pl?project=linux-2.6
> 
> Hmm, looks nice for a start. (But you have obsolete git-pasky tree there! ;-)

Yeah, it's fresh now. :)

> > How can I get the files touched with a changeset and the corresponding
> > diffs belonging to it?
> 
> diff-tree to get the list of files, you can do the corresponding diffs
> e.g. by doing git diff -r tree1:tree2. Preferably make a patch for it
> first to make it possible to diff individual files this way.

Ah, nice! Got it working.

Thanks,
Kay

