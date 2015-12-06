From: Andreas Krey <a.krey@gmx.de>
Subject: Re: best practices against long git rebase times?
Date: Sun, 6 Dec 2015 17:43:45 +0100
Message-ID: <20151206164345.GH22288@inner.h.apk.li>
References: <20151204150546.GA17210@inner.h.apk.li> <20151204153103.GP18913@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Dec 06 17:44:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5cQ2-0002zh-Qu
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 17:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbbLFQoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 11:44:10 -0500
Received: from continuum.iocl.org ([217.140.74.2]:33032 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbbLFQoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 11:44:09 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id tB6Ghjf15705;
	Sun, 6 Dec 2015 17:43:45 +0100
Content-Disposition: inline
In-Reply-To: <20151204153103.GP18913@serenity.lan>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282057>

On Fri, 04 Dec 2015 15:31:03 +0000, John Keeping wrote:
...
> I'm pretty sure that you're right and the cherry-pick analysis is where
> the time is spent.

But I'm pretty surprised as to the amount of CPU time that goes there.

I'm now rebasing a single commit with a single blank line added,
and for 3000 new commits to rebase over (with 64 MByte of git log -
for them) it takes twelve minutes, or about for commits per second,
and all user CPU, no I/O. It's pretty linear in number of commits, too.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
