From: Andreas Krey <a.krey@gmx.de>
Subject: best practices against long git rebase times?
Date: Fri, 4 Dec 2015 16:05:46 +0100
Message-ID: <20151204150546.GA17210@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 04 16:05:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4rvm-0000Px-Ma
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 16:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbbLDPFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 10:05:50 -0500
Received: from continuum.iocl.org ([217.140.74.2]:59310 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbbLDPFu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 10:05:50 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id tB4F5k717414;
	Fri, 4 Dec 2015 16:05:46 +0100
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281982>

Hi all,

our workflow is pretty rebase-free for diverse reasons yet.

One obstacle now appearing is that rebases simply take
very long - once you might want to do a rebase there are
several hundred commits on the remote branch, and our tree
isn't small either.

This produces rebase times in the minute range.
I suppose this is because rebase tries to see
if there are new commits in the destination
branch that are identical to one of the local
commits, to be able to skip them. (I didn't
try to verify this hypothesis.)

What can we do to make this faster?

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
