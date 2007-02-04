From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git rebase: unexpected conflict
Date: Sun, 04 Feb 2007 20:33:50 +0100
Organization: At home
Message-ID: <eq5cc6$al2$1@sea.gmane.org>
References: <20070204190519.GB29029@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 04 20:32:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDn6O-0001V7-4g
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 20:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbXBDTcj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 14:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbXBDTcj
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 14:32:39 -0500
Received: from main.gmane.org ([80.91.229.2]:39026 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496AbXBDTci (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 14:32:38 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HDn6D-0003MS-9n
	for git@vger.kernel.org; Sun, 04 Feb 2007 20:32:29 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 20:32:29 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 20:32:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38702>

Michael S. Tsirkin wrote:

> git rebase seems to see conflicts where there shouldn't be any.

Were you on a branch that you wanted to rebase? I had made this error once.
git rebase --onto <newbase> <upstream> <branch> moves <upstream>..<branch>
into <newbase>.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
