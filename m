From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [guilt] Bug with guilt patchbomb
Date: Tue, 9 Sep 2008 10:12:34 +0200
Message-ID: <20080909101234.070f2fdd@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Wed Sep 10 09:34:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdKDm-0006nQ-Cp
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 09:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbYIJHdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 03:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbYIJHdb
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 03:33:31 -0400
Received: from mail.free-electrons.com ([88.191.76.200]:50684 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbYIJHda (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 03:33:30 -0400
X-Greylist: delayed 4156 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Sep 2008 03:33:30 EDT
Received: by mail.free-electrons.com (Postfix, from userid 106)
	id 8161EE5BB; Tue,  9 Sep 2008 10:13:12 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on
	mail.free-electrons.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from surf (humanoidz.org [82.247.183.72])
	by mail.free-electrons.com (Postfix) with ESMTPA id C7E8EE5A3;
	Tue,  9 Sep 2008 10:13:03 +0200 (CEST)
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95493>

Hi,

I'm using guilt 0.28-1 (Ubuntu package) and git-core 1.5.4.3-1ubuntu2.
When I use guilt patchbomb, I get some scary output from git-rev-list:

Enter all the Cc: email addresses (separated by space): 
usage: git-rev-list [OPTION] <commit-id>... [ -- paths... ]
  limiting output:
    --max-count=nr
    --max-age=epoch
    --min-age=epoch
    --sparse
    --no-merges
    --remove-empty
    --all
    --stdin
    --quiet
  ordering output:
    --topo-order
    --date-order
  formatting output:
    --parents
    --objects | --objects-edge
    --unpacked
    --header | --pretty
    --abbrev=nr | --no-abbrev
    --abbrev-commit
    --left-right
  special purpose:
    --bisect
    --bisect-vars
    --bisect-all
/usr/bin/guilt-patchbomb: 98: Bad substitution
Proceed with patchbomb (this is the last chance to abort)? [y/N] 

Sincerly,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers and embedded Linux development,
consulting, training and support.
http://free-electrons.com
