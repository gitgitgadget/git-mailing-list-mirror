From: James Pickens <james.e.pickens@intel.com>
Subject: More symlink/directory troubles
Date: Tue, 28 Jul 2009 15:13:16 -0700
Message-ID: <1248819198-13921-1-git-send-email-james.e.pickens@intel.com>
Cc: barvik@broadpark.no
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 29 00:13:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVuvc-0004Pq-Fk
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 00:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755785AbZG1WNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 18:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755783AbZG1WNd
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 18:13:33 -0400
Received: from mga10.intel.com ([192.55.52.92]:60556 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755775AbZG1WNd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 18:13:33 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP; 28 Jul 2009 15:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.43,284,1246863600"; 
   d="scan'208";a="711923178"
Received: from sedona.ch.intel.com ([143.182.201.200])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jul 2009 15:16:34 -0700
Received: from chlr11231.ch.intel.com (chlr11231.ch.intel.com [143.182.208.231])
	by sedona.ch.intel.com (8.12.11.20060308/8.14.3/Standard MailSET/Hub) with ESMTP id n6SMDJd2004413;
	Tue, 28 Jul 2009 15:13:19 -0700
Received: from chlr11231.ch.intel.com (localhost [127.0.0.1])
	by chlr11231.ch.intel.com (8.13.6/MailSET/client) with ESMTP id n6SMDIIr014102;
	Tue, 28 Jul 2009 15:13:18 -0700
Received: (from jepicken@localhost)
	by chlr11231.ch.intel.com (8.13.6/8.13.6/Submit) id n6SMDItS014098;
	Tue, 28 Jul 2009 15:13:18 -0700
X-Mailer: git-send-email 1.6.2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124287>

This is a follow up to the original thread and patch at
http://article.gmane.org/gmane.comp.version-control.git/122297.  There was
a bug report about problems when a directory is replaced with a symlink.  I
said that the patch fixed the bug for me, but I didn't test thoroughly
enough, because it turns out there are 3 bugs, and the patch only fixed one
of them.

I am sending some test scripts to demonstrate the bugs in hopes of spurring
some activity here.  I think the convention is to use test_expect_failure
for this sort of test, so that's what I did.

Unfortunately I have very little time in the next 2 weeks, so I probably
won't be able to do much more than send the tests, and fix them up if
necessary.  In 2 weeks I can take a look at the C code, if it isn't already
fixed by then.

James
