From: Eric Wong <normalperson@yhbt.net>
Subject: [PULL] various git-svn updates
Date: Thu, 1 Sep 2011 22:00:06 +0000
Message-ID: <20110901220006.GA18321@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Jacobs <bjacobs@woti.com>, Sam Vilain <sam@vilain.net>,
	H Krishnan <hetchkay@gmail.com>, Ray Chen <rchen@cs.umd.edu>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 02 00:00:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzFJ2-0001Fs-Id
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 00:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133Ab1IAWAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 18:00:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60389 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932082Ab1IAWAH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 18:00:07 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DF36219F2;
	Thu,  1 Sep 2011 22:00:06 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180576>

Please pull from "master" on git://bogomips.org/git-svn.git

  Bryan Jacobs (1):
        git-svn: Teach dcommit --mergeinfo to handle multiple lines

  Eric Wong (1):
        git-svn: fix fetch with moved path when using rewriteRoot

  Ray Chen (1):
        git-svn: New flag to emulate empty directories

commit 85f022e9c124ffeda31a50cab878e1418d694d87 (fix fetch with moved path)
is also suitable for cherry-picking into maint.  All tests pass on
Debian 6.0 (x86_64).

-- 
Eric Wong
