From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
Subject: Guilt: Autotagging - aye or nay?
Date: Thu, 10 Apr 2008 20:26:30 -0400
Message-ID: <20080411002630.GD3838@josefsipek.net>
References: <20080411000143.GC3838@josefsipek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
To: guilt@josefsipek.net
X-From: git-owner@vger.kernel.org Fri Apr 11 02:27:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk76s-0004pf-4f
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 02:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757032AbYDKA0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 20:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbYDKA0d
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 20:26:33 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:41629 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbYDKA0c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 20:26:32 -0400
Received: from josefsipek.net (baal.fsl.cs.sunysb.edu [130.245.126.78])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id m3B0QSGn003301;
	Thu, 10 Apr 2008 20:26:28 -0400
Received: by josefsipek.net (Postfix, from userid 1000)
	id 7E3D21C00DD8; Thu, 10 Apr 2008 20:26:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080411000143.GC3838@josefsipek.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79260>

Greetings all!

I was trying to figure out what the default for Guilt's autotagging feature
should be.  Currently, the default is for it to be on, unless it's
overridden by an already existing config setting.

For those who may not be familiar with autotagging, here's an excerpt from
the guilt(7) man page:

	Autotagging is a feature that automatically creates unannotated tags
	for top, bottom, and base of the stack.

	On every push or pop operation (refresh is a pop followed by a
	push), Guilt updates the stack top (${branch}_top), stack bottom
	(${branch}_bottom), and stack base (${branch}_base) tags.

		Top: Top-most applied patch/commit
		Bottom: Bottom-most applied patch/commit
		Base: Commit on top of which the bottom most patch is applied

	Having these three tags, one can easily get the log/diff/other
	information only for commits that are (or are not!) part of the
	patch stack.

So far the few people (including myself for the past few months) I asked
privately, all said that they turn the feature off.

Ideas?  Comments?  Suggestions?

Josef 'Jeff' Sipek.

-- 
I think there is a world market for maybe five computers.
		- Thomas Watson, chairman of IBM, 1943.
