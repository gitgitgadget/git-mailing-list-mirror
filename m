From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 0/4] Update linux-2.6.git location and related examples
Date: Sat, 22 Jun 2013 10:46:23 -0400
Message-ID: <cover.1371911897.git.wking@tremily.us>
References: <7vppvhye6s.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 16:46:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqP5T-0003WR-2e
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 16:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755139Ab3FVOqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 10:46:33 -0400
Received: from vms173011pub.verizon.net ([206.46.173.11]:50188 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab3FVOqc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 10:46:32 -0400
Received: from odin.tremily.us ([unknown] [72.68.80.60])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MOS0063CUDJZF20@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 22 Jun 2013 09:46:32 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 45950A3D873; Sat,
 22 Jun 2013 10:46:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1371912391; bh=dRSq/foMdqK/vf4iuVYGlllVyAkq9+JgLFdp+1eRrEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i7ENOumBrXv9bT9z61VpcPr7NSCRINYs9agWdRawg32HpqtDS4eacE2w3mWV9VG89
 2S+PjO6TtPFp2645COe34GFhwO4yIgz1tIYaBS+oDgbG3bITTk/8ZMQ8C0x5KBEdpl
 7fVF4O3vazZEV2e9mDxuTYDI6X0EUjjEx8KDE4vE=
X-Mailer: git-send-email 1.8.1.5
In-reply-to: <7vppvhye6s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228712>

From: "W. Trevor King" <wking@tremily.us>

David and Junio mentioned that I'd missed a few 2.6 references in my
initial pass.  Here's a second attempt that does some deeper reworking
of the effected sections.  Each deeper rewrite gets its own patch and
motivation, with the final patch making all the superficial changes
that were not fixed in the earlier patches.

I've dropped the download size update (2/2 in v1), which Junio has
queued separately.  I also rebased the series on maint-1.8.2, since
that's where the size update landed.  I only touch low-churn areas
though, so this series should apply to any recent branch.

W. Trevor King (4):
  doc/clone: Remove the '--bare -l -s' example
  doc/clone: Pick more compelling paths for the --reference example
  Documentation: Update the NFS remote examples to use the staging repo
  Documentation: Update 'linux-2.6.git' -> 'linux.git'

 Documentation/git-clone.txt          | 19 ++++++-------------
 Documentation/git-fast-export.txt    |  2 +-
 Documentation/git-remote.txt         | 25 ++++++++++++++++---------
 Documentation/technical/racy-git.txt |  6 +++---
 Documentation/user-manual.txt        | 34 ++++++++++++++++++++--------------
 t/perf/README                        |  2 +-
 6 files changed, 47 insertions(+), 41 deletions(-)

-- 
1.8.3
