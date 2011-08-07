From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/4] git-p4 test cleanup, commit time change
Date: Sun, 7 Aug 2011 09:31:44 -0400
Message-ID: <20110807133144.GA27521@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 07 15:33:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq3TP-0001Wq-PK
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 15:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab1HGNbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 09:31:49 -0400
Received: from honk.padd.com ([74.3.171.149]:48647 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752303Ab1HGNbs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 09:31:48 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id D8BFD1F9E;
	Sun,  7 Aug 2011 06:31:47 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E94F13143E; Sun,  7 Aug 2011 09:31:44 -0400 (EDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178911>

Here's a small patch series to clean up the git-p4 tests a bit,
make them work on a 2-user eval p4d, and to fix a problem with
the timestamp on the import commit.

 [PATCH 1/4] git-p4: use test_when_finished in tests
 [PATCH 2/4] git-p4: add missing && in test
 [PATCH 3/4] git-p4: one test missing config
 [PATCH 4/4] git-p4: commit time should be most recent p4 change time

 contrib/fast-import/git-p4 |   15 +++++
 t/t9800-git-p4.sh          |  125 +++++++++++++++++++++++++--------------------
 2 files changed, 84 insertions(+), 56 deletions(-)

Luke acked them, and I've been using it for a couple of weeks.  Could you
include them in the next convenient release?  Thanks,

		-- Pete
