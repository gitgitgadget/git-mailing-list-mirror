From: Marc Weber <marco-oweber@gmx.de>
Subject: marking (cherry-pick) commits ?
Date: Fri, 6 Mar 2009 15:41:25 +0100
Message-ID: <20090306144125.GA14569@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 15:43:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfbGO-0004H7-GZ
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 15:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbZCFOlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 09:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbZCFOlb
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 09:41:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:47190 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751221AbZCFOlb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 09:41:31 -0500
Received: (qmail invoked by alias); 06 Mar 2009 14:41:26 -0000
Received: from pD9E088F7.dip.t-dialin.net (EHLO mail.gmx.net) [217.224.136.247]
  by mail.gmx.net (mp047) with SMTP; 06 Mar 2009 15:41:26 +0100
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1/FASgfbY3FTQQMbGJWQX+/EWypK/ITX2rqig3Phi
	cPFIz1ZzLC9ypU
Received: by mail.gmx.net (sSMTP sendmail emulation); Fri, 06 Mar 2009 15:41:25 +0100
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112443>

I've this situation:

base --------- branch_A (svn trunk)
  ` ---------- branch_B (svn branch )

Some cherry picks have been done both dirctions.
Is there a way show gitk branch_A branch_B and mark cherry-picks?
I only know about --left-right --cherry-pick and such omitting them.

How does --cherry-pick work? Is it based on git-commit-id?
Probably it would be enough to write a simple script iterating over both
brnaches adding some temporary tags pointing out the pairs of
cherry-picked patches..

Is there another way "marking" patches?
Maybe it would be fun to use 

git tab tmp_dont_commit_red_message
git tab tmp_dont_commit_green_message

and ask gitk to show them in red and green?

Can I tell git push to not push all tags starting with tmp_dont_commit_
?

There are only about 120 patches.. So I can manually handle that case..
But I guess git can do better.

Sincerly
Marc Weber
