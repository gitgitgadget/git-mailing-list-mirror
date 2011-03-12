From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/2] git-p4: fix clone @all regression
Date: Sat, 12 Mar 2011 11:22:46 -0500
Message-ID: <20110312162246.GA8509@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 12 17:22:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyRaj-0005ns-Nn
	for gcvg-git-2@lo.gmane.org; Sat, 12 Mar 2011 17:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898Ab1CLQWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2011 11:22:50 -0500
Received: from honk.padd.com ([74.3.171.149]:44936 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754293Ab1CLQWu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2011 11:22:50 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id A22A920B3;
	Sat, 12 Mar 2011 08:22:48 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 136CC3207D; Sat, 12 Mar 2011 11:22:46 -0500 (EST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168946>

My commit e32e00dc88948a730b8b1f3b8129f30c313713e7
"git-p4: better message for "git-p4 sync" when not cloned"
broke clone @all.  This fixes it per Tor Arvid's patch
and adds a test to make sure it doesn't happen again.

    git-p4: fix clone @all regression
    git-p4: test clone @all

 contrib/fast-import/git-p4 |    2 +-
 t/t9800-git-p4.sh          |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

Please queue to maint.  Thanks,

		-- Pete
