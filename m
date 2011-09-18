From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/5] git-p4 filetype handling
Date: Sat, 17 Sep 2011 21:26:34 -0400
Message-ID: <20110918012634.GA4578@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 03:26:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R569c-0005zJ-QO
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 03:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951Ab1IRB0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Sep 2011 21:26:39 -0400
Received: from honk.padd.com ([74.3.171.149]:50722 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755845Ab1IRB0i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 21:26:38 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 3EAFBBFC;
	Sat, 17 Sep 2011 18:26:37 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 74F3731448; Sat, 17 Sep 2011 21:26:34 -0400 (EDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181592>

Here's a series that includes some changes to make
git-p4 handle p4 filetypes better.  This work was
inspired by Chris Li, and includes some refactoring
of the git-p4 tests that grew out of looking at
Vitor's branch changes.

It could use review for generic test beauty, as well
as for the git-p4 filetype specifics in the code.

 contrib/fast-import/git-p4 |   91 +++++++++++++-----
 t/lib-git-p4.sh            |   55 +++++++++++
 t/t9800-git-p4.sh          |  108 ++--------------------
 t/t9801-git-p4-branch.sh   |  221 ++++++++++++++++++++++++++++++++++++++++++++
 t/t9802-git-p4-filetype.sh |  107 +++++++++++++++++++++
 5 files changed, 457 insertions(+), 125 deletions(-)

Thanks,

		-- Pete
