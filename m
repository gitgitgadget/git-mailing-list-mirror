From: Jakub Narebski <jnareb@gmail.com>
Subject: reflog doesn't note that commit was --amend-ed, and doesn't record pulls
Date: Mon, 10 Jul 2006 23:49:06 +0200
Organization: At home
Message-ID: <e8uhvg$5o1$2@sea.gmane.org>
References: <e8uele$o7t$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jul 10 23:49:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G03cm-0000bp-0n
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 23:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWGJVtA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 17:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbWGJVtA
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 17:49:00 -0400
Received: from main.gmane.org ([80.91.229.2]:56209 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965050AbWGJVs7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 17:48:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G03cU-0000Yn-RA
	for git@vger.kernel.org; Mon, 10 Jul 2006 23:48:46 +0200
Received: from host-81-190-19-52.torun.mm.pl ([81.190.19.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Jul 2006 23:48:46 +0200
Received: from jnareb by host-81-190-19-52.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Jul 2006 23:48:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-19-52.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23661>

Additionally, while reflog records git-reset invocations, it doesn't
distinguish between an ordinary commit, and commit --amend (which I do
a lot, most time because of forgotten update-index; yes, I know about commit
-a option ;-). Well, you can extract this information looking at current
and previous commit sha1, but it would be nice to have it noted somewhat in
message part of reflog.

Reflog doesn't seem also to record pulls (e.g. master branch): pulls has
empty reflog message part.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
