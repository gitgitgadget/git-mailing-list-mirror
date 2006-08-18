From: Jakub Narebski <jnareb@gmail.com>
Subject: Why git-ls-tree has no --stdin option?
Date: Fri, 18 Aug 2006 12:40:11 +0200
Organization: At home
Message-ID: <ec45ca$id8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Aug 18 12:39:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE1l7-0003uF-Fq
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 12:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWHRKjW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 06:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWHRKjW
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 06:39:22 -0400
Received: from main.gmane.org ([80.91.229.2]:28073 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751353AbWHRKjW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 06:39:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GE1kw-0003sS-OE
	for git@vger.kernel.org; Fri, 18 Aug 2006 12:39:14 +0200
Received: from host-81-190-24-244.torun.mm.pl ([81.190.24.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 12:39:14 +0200
Received: from jnareb by host-81-190-24-244.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 12:39:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-244.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25646>

Why git-ls-tree has no --stdin option to give <tree-ish> (feed it from
git-ref-list for example), like git-diff-tree has? The output format could
be similar: treeish, then git-ls-tree output, treeish, tree,...

Also, is there a combination of options which would display only exact
matches to path limit, i.e. tree entry only if path is directory, and file
(blob) entry only if path is ordinary file?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
