From: Ian Hilt <ian.hilt@gmx.com>
Subject: git rev-list ordering
Date: Sat, 15 Nov 2008 19:44:03 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811151922310.2935@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 16 01:45:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1Vld-0004vS-Gn
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 01:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbYKPAoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 19:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbYKPAoM
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 19:44:12 -0500
Received: from mail.gmx.com ([74.208.5.67]:35562 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751346AbYKPAoM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 19:44:12 -0500
Received: (qmail invoked by alias); 16 Nov 2008 00:44:09 -0000
Received: from cpe-75-185-223-130.woh.res.rr.com [75.185.223.130]
  by mail.gmx.com (mp-us002) with SMTP; 15 Nov 2008 19:44:09 -0500
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX18gMBJmTHkgFGMrQ3XwBAOz4dsIHDCKWmikBbqUvm
	CdEcz2GG8Ob4KA
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.85
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101105>

Why is it that this command,

    git rev-list --reverse --max-count=1 <branch>

results in the same SHA1 as,

    git rev-list --max-count=1 <branch>

So far, the documentation and the mailing list archives haven't helped.
