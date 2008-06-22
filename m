From: Allan Wind <allan_wind@lifeintegrity.com>
Subject: Why does diff --binary include content of files being deleted?
Date: Sat, 21 Jun 2008 23:34:54 -0400
Message-ID: <20080622033454.GA10578@lifeintegrity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 05:36:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAGNW-0007CP-M9
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 05:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbYFVDe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 23:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbYFVDe5
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 23:34:57 -0400
Received: from aeol.lifeintegrity.com ([209.135.157.90]:37048 "EHLO
	lifeintegrity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbYFVDe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 23:34:56 -0400
Received: from vent.lifeintegrity.com (pool-71-174-251-18.bstnma.fios.verizon.net [71.174.251.18])
	by submission.lifeintegrity.com (Postfix) with ESMTP id D53B1D5C0EB
	for <git@vger.kernel.org>; Sun, 22 Jun 2008 03:34:55 +0000 (UTC)
Received: by vent.lifeintegrity.com (Postfix, from userid 1000)
	id B808D304362; Sat, 21 Jun 2008 23:34:54 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85746>

Between tag1 and tag2 I am deleting a number of binary files, and I was 
surprised seeing the binaries being added to the diff when said files
are to be deleted:

git diff --binary tag1 tag2 > /tmp/diff && ls -l /tmp/diff
-rw-r--r-- 1 allan users 555135993 2008-06-21 22:37 /tmp/diff

git diff tag1 tag2 > /tmp/diff2 && ls -l /tmp/diff2
-rw-r--r-- 1 allan users 12862 2008-06-21 23:33 /tmp/diff2



/Allan
