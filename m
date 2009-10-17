From: Steven Noonan <steven@uplinklabs.net>
Subject: git submodules
Date: Sat, 17 Oct 2009 10:15:50 -0700
Message-ID: <f488382f0910171015j1a6d4d9fg690867154334c514@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: crawl-ref-discuss@lists.sourceforge.net
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 17 19:17:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzCtx-0006uH-GI
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 19:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbZJQRPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 13:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbZJQRPq
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 13:15:46 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:34181 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbZJQRPq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 13:15:46 -0400
Received: by pzk26 with SMTP id 26so2316294pzk.4
        for <git@vger.kernel.org>; Sat, 17 Oct 2009 10:15:50 -0700 (PDT)
Received: by 10.142.195.4 with SMTP id s4mr176170wff.51.1255799750185; Sat, 17 
	Oct 2009 10:15:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130568>

One of the open source projects I work on (CC'd) recently moved to
git, but we're having some slight problems, and I believe that it's
the fault of git's UI in this case.

We're using git submodules for the contributing libraries. When I
commit changes to those contribs, it correctly shows in the parent
repository that those folders have different revisions than what's
currently committed. However, if someone pulls those changes, it
doesn't automatically update the contribs to match the committed
version. But doing a pull or merge _should_ update the working tree to
match the committed versions. It does with file data, so why not
update the submodules? Especially if the submodule revision matched
the committed version -before- the pull. Why are we forced into using
'git submodule update'?

- Steven
