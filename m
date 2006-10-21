From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] Syntax highlighting for combined diff
Date: Sat, 21 Oct 2006 02:35:41 +0200
Organization: At home
Message-ID: <ehbq0k$24l$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Oct 21 02:36:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb4qZ-0004PM-4j
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 02:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992756AbWJUAgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 20:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992758AbWJUAgQ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 20:36:16 -0400
Received: from main.gmane.org ([80.91.229.2]:8888 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S2992756AbWJUAgP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 20:36:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gb4qR-0004NQ-Ja
	for git@vger.kernel.org; Sat, 21 Oct 2006 02:36:12 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 02:36:11 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 02:36:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29566>

Linus Torvalds wrote in "Re: VCS comparison table"

> And "gitweb" does consider the first parent special, since it shows diffs 
> against that one (although I've argued that it probably shouldn't, and 
> that there should be some way to show branches against arbitrary parents)

So the question is how to color combined diff format (what should be syntax
highlighting for combined diff format). If branches columns have only
pluses we use the same color as for adding line in ordinary diff; if
branches column consist only of minuses we use the same color as for
removing line in ordinary diff. Can there be mixture of plusses and
minuses? How git-diff --color solves this?

Should we in gitweb output change color slightly depending on number of
plusses or minuses?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
