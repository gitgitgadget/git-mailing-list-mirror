From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/4] git p4 submit fixes
Date: Sun, 29 Apr 2012 20:57:13 -0400
Message-ID: <1335747437-24034-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 02:57:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOevz-0003Mf-6p
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 02:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656Ab2D3A5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 20:57:20 -0400
Received: from honk.padd.com ([74.3.171.149]:36580 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754629Ab2D3A5U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 20:57:20 -0400
Received: from arf.padd.com (unknown [50.55.155.59])
	by honk.padd.com (Postfix) with ESMTPSA id B3D2560C0;
	Sun, 29 Apr 2012 17:57:19 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8DED3313F8; Sun, 29 Apr 2012 20:57:17 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.572.ged86f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196528>

These patches fix some issues associated with submit.  They add a
good chunk of basic testing for the submit path as well.
The last patch was sent to the list back in February, if it
looks familiar.

Pete Wyckoff (4):
  git p4: bring back files in deleted client directory
  git p4: test submit
  git p4: fix writable file after rename or copy
  git p4: submit files with wildcards

 git-p4.py                     |   96 +++++++++++++++++++++++++------------
 t/t9800-git-p4-basic.sh       |  106 +++++++++++++++++++++++++++++++++++++++++
 t/t9807-git-p4-submit.sh      |  101 ++++++++++++++++++++++++++++++++++++++-
 t/t9809-git-p4-client-view.sh |   40 ++++++++++++++--
 4 files changed, 308 insertions(+), 35 deletions(-)

-- 
1.7.10.366.g90ade
