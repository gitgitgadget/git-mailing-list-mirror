From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCHSET] cg-log cleanups and enhancements
Date: Sat, 4 Jun 2005 16:38:31 +0200
Message-ID: <20050604143831.GD12615@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 16:35:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeZkC-0005K4-N7
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 16:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVFDOih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 10:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVFDOih
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 10:38:37 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:57086 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261315AbVFDOic (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 10:38:32 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id BC7F56E149B; Sat,  4 Jun 2005 16:37:51 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 8706B6E12DE; Sat,  4 Jun 2005 16:37:51 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 9672D61FE0; Sat,  4 Jun 2005 16:38:31 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The patchset contains the following 10 patches:

  [PATCH 1/10] Cleanup conversion to human readable date
  [PATCH 2/10] Separate handling of tree and parent in commit headers
  [PATCH 3/10] Separate handling of author and committer in commit headers
  [PATCH 4/10] First parse all commit header entries then print them
  [PATCH 5/10] Move printing of the commit info line inside the loop
  [PATCH 6/10] Remove the catch all rule
  [PATCH 7/10] Move log printing to separate function
  [PATCH 8/10] Move the username matching inside the loop
  [PATCH 9/10] Move file matching inside the loop.
  [PATCH 10/10] Add -s option to show log summary

-- 
Jonas Fonseca
