From: Kay Sievers <kay.sievers@vrfy.org>
Subject: new gitweb.cgi installed
Date: Sat, 11 Jun 2005 20:05:57 +0200
Message-ID: <20050611180557.GA22027@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jun 11 20:02:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhAIi-0007KV-Rp
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 20:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVFKSGG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 14:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVFKSGG
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 14:06:06 -0400
Received: from soundwarez.org ([217.160.171.123]:18398 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261765AbVFKSF7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jun 2005 14:05:59 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id B58A93F61A; Sat, 11 Jun 2005 20:05:57 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The kernel.org boxes got the new git-binaries installed yesterday, so I've
updated gitweb.cgi:

The cgi itself is available here:
  ftp://www.kernel.org/pub/software/scm/gitweb/

Along with a few cosmetical changes, it:

o shows renames:
    http://www.kernel.org/git/?p=git/git.git;a=commit;h=418aaf847a8b3ffffb4f777a2dd5262ca5ce0ef7

o strips the merge messages down, that they actually readable the commit title
  Thanks to Tony Luck for the hint.

o has new RSS feed format, that hopefully prints the commit in the right
  format while still be valid XML
  Thanks to Jan Blunck for the patch and testing.

o shows now the right 8-space tab indentation for for the blob and diffs.
  Thanks to Matthijs Melchior for his help fixing it.

o has the  diff-link in the history renamed to "diff to current"
  this hopefully makes the intended behavior more obvious
  Thanks to Sean.

o has a link for a text/plain view of files and diffs

o does not use the old environment variables anymore

Best,
Kay
