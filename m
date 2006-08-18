From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why git-ls-tree has no --stdin option?
Date: Fri, 18 Aug 2006 10:39:08 -0700
Message-ID: <7v7j16aqpv.fsf@assigned-by-dhcp.cox.net>
References: <ec45ca$id8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 19:39:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE8JQ-0003Nf-5x
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 19:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWHRRjL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 13:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWHRRjL
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 13:39:11 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:52204 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751425AbWHRRjK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 13:39:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060818173909.TBAI554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Aug 2006 13:39:09 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ec45ca$id8$1@sea.gmane.org> (Jakub Narebski's message of "Fri,
	18 Aug 2006 12:40:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25683>

Jakub Narebski <jnareb@gmail.com> writes:

> Why git-ls-tree has no --stdin option to give <tree-ish> (feed it from
> git-ref-list for example), like git-diff-tree has? The output format could
> be similar: treeish, then git-ls-tree output, treeish, tree,...

The only reason is nobody felt need for it so far, hence nobody
bothered.  If you find it useful, go wild.

> Also, is there a combination of options which would display only exact
> matches to path limit, i.e. tree entry only if path is directory, and file
> (blob) entry only if path is ordinary file?

I probably am misunderstanding the question but an empty set is
the combination you want perhaps?

$ git ls-tree HEAD -- t Document sha1 sha1_name.c
100644 blob e9eb6ce882ea92523c9a871c7581457af2dc78c5	sha1_name.c
040000 tree 3fb2bfdfef59e4ed10f525ef10ad8b43b8bc459e	t
