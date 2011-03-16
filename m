From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/2] git-p4: sync new branch regression
Date: Wed, 16 Mar 2011 16:50:08 -0400
Message-ID: <20110316205008.GA22702@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Horowitz <michael.horowitz@ieee.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 21:50:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzxfg-0006L4-8c
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 21:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675Ab1CPUuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 16:50:15 -0400
Received: from honk.padd.com ([74.3.171.149]:43574 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753145Ab1CPUuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 16:50:14 -0400
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id CEE6020B9;
	Wed, 16 Mar 2011 13:50:12 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 08D1F5AB92; Wed, 16 Mar 2011 16:50:08 -0400 (EDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169193>

Here is another fix for e32e00d (git-p4: better message for
"git-p4 sync" when not cloned, 2011-02-19).  Mike pointed out
that his use case breaks too.

These two patches fix it, and add two new test cases to
check for future breakage.  At least we're coming up with
a good set of tests.

    git-p4: fix sync new branch regression
    git-p4: test sync new branch

 contrib/fast-import/git-p4 |    4 +++-
 t/t9800-git-p4.sh          |   23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletions(-)

These would be good on master, beyond e32e00d that is
in your pw/p4.  Thanks,

                -- Pete
