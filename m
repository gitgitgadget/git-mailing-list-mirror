From: Tikhon Tarnavski <t.t@unixforum.org>
Subject: how to delete from history some files, and commits with them?
Date: Wed, 14 Jul 2010 15:46:48 +0000 (UTC)
Message-ID: <loom.20100714T170722-272@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 18:10:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ4XT-0002IC-9J
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 18:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756807Ab0GNQKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 12:10:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:35986 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756788Ab0GNQKH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 12:10:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OZ4X6-00024a-2q
	for git@vger.kernel.org; Wed, 14 Jul 2010 18:10:04 +0200
Received: from lifeboatness.extreme.volia.net ([93.74.14.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 18:10:04 +0200
Received: from t.t by lifeboatness.extreme.volia.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 18:10:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 93.74.14.197 (ELinks/0.12~pre4-1 (textmode; Debian; Linux 2.6.21-omap1 armv6l; 40x12-3))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151002>

Hello.

I'm using git for several small
projects, and now one of those pgojects
have to be divided into two independent
parts. So I want to divide git history
respectively. I can create two clones
and run filter-branch in both to delete
files. But I can't find how I may
delete empty commits after that.
Naturally, I'd prefer to do all process
automatically: removing unnecessary
files and deleting empty commits
without searching to its' hashes.

Can you suggest any solution?
