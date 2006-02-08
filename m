From: Ralf Baechle <ralf@linux-mips.org>
Subject: Shortest path between commits
Date: Wed, 8 Feb 2006 16:03:08 +0000
Message-ID: <20060208160308.GB3484@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 08 17:09:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6rma-00068F-2n
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 17:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbWBHQDA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 11:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWBHQC7
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 11:02:59 -0500
Received: from mipsfw.mips-uk.com ([194.74.144.146]:26122 "EHLO
	bacchus.dhis.org") by vger.kernel.org with ESMTP id S965168AbWBHQC7
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 11:02:59 -0500
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k18G39Bk003881
	for <git@vger.kernel.org>; Wed, 8 Feb 2006 16:03:09 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k18G382a003880
	for git@vger.kernel.org; Wed, 8 Feb 2006 16:03:08 GMT
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15738>

I wonder if there some way to find the shortest path between two commits?
That is if there is a merge between the two commits I only want the merge
commit itself, not the potencially large list of commits that were merged.

I need that for commit notification scripts; I don't want to spam users
with too many emails and aggregating everything that came through a single
merge would be a reaonsable approach.

  Ralf
