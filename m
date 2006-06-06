From: Kenneth Johansson <ken@canit.se>
Subject: Integrity check
Date: Wed, 07 Jun 2006 00:46:27 +0200
Message-ID: <pan.2006.06.06.22.46.26.518589@canit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Jun 07 00:46:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnkJx-0007Ah-5Y
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 00:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWFFWql (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 18:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWFFWql
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 18:46:41 -0400
Received: from main.gmane.org ([80.91.229.2]:20404 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751136AbWFFWqk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 18:46:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FnkJj-00077d-Ev
	for git@vger.kernel.org; Wed, 07 Jun 2006 00:46:31 +0200
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jun 2006 00:46:31 +0200
Received: from ken by 1-1-4-20a.ras.sth.bostream.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jun 2006 00:46:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 1-1-4-20a.ras.sth.bostream.se
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21409>

Iwas doing a git pull that ended badly and I thought that just redoing the
command may help but then git thinks everything is just fine.

After a few failed attempts I still have not find a good way to make sure
that everything is indeed correct. What is the suggested commands to do
that ?

--------
Updating from 7705a8792b0fc82fd7d4dd923724606bbfd9fb20 to
1def630a6a49dda5bc89dfbd86656293640456f0 Checking files out...
 100% (6311/6311) done
Fast forward
*** glibc detected *** malloc(): memory corruption: 0x0a703e80 ***
/home/ken/bin/git-merge: line 56: 14121 Aborted                
git-diff-tree -p --stat --summary -M "$head" "$1" 

>git pull
* refs/heads/origin: same as branch 'master' of
/delta/kernel/git/linux-2.6/ Already up-to-date.
[
