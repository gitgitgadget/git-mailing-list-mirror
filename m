From: Yann Dirson <ydirson@free.fr>
Subject: Missing tags v1.0.1 and v1.0.2 on kernel.org
Date: Sun, 5 Dec 2010 16:04:16 +0100
Message-ID: <20101205150416.GC2803@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 05 16:04:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPG8b-0006EN-PW
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 16:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518Ab0LEPEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 10:04:24 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:57219 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755282Ab0LEPEX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 10:04:23 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 118F3D480C8
	for <git@vger.kernel.org>; Sun,  5 Dec 2010 16:04:17 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PPG8O-0002sA-NM
	for git@vger.kernel.org; Sun, 05 Dec 2010 16:04:16 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162950>

When fetching from git://github.com/gitster/git.git in my local repo
originally cloned from git://git.kernel.org/pub/scm/git/git.git, I
notice 2 unexpected new tags: v1.0.1 and v1.0.2.

It looks like those 2 old tags were not pushed to kernel.org:

$ git ls-remote origin|grep '1\.0\.[0-4]$'
f665776185ad074b236c00751d666da7d1977dbe        refs/tags/v1.0.0
ccefd6e899a861f911052e47eabe4f77c09163ec        refs/tags/v1.0.3
1e6455d0c3f9ee79c461bd68aafad8b7f8765c8a        refs/tags/v1.0.4

OTOH there are v1.0.0a and v1.0.0b on kernel.org, which match the same
revs:

$ git rev-parse v1.0.1^{}
e4e79a217576d24ef4d73b620766f62b155bcd98
$ git rev-parse v1.0.0a^{}
e4e79a217576d24ef4d73b620766f62b155bcd98
$ git rev-parse v1.0.2^{}
8d712aafd2df3c1f5147a28947f98cefe667cf76
$ git rev-parse v1.0.0b^{}
8d712aafd2df3c1f5147a28947f98cefe667cf76

Don't we want those 2 tags on kernel.org too for consistency ?
