From: Dave Abrahams <dave@boostpro.com>
Subject: Magit and TRAMP issues
Date: Fri, 1 Jan 2010 06:49:50 +0000 (UTC)
Message-ID: <loom.20100101T074051-542@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 01 07:57:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQbSO-0002Gh-R4
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 07:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206Ab0AAGuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2010 01:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086Ab0AAGuS
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jan 2010 01:50:18 -0500
Received: from lo.gmane.org ([80.91.229.12]:56473 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803Ab0AAGuR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2010 01:50:17 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NQbKv-00016M-HP
	for git@vger.kernel.org; Fri, 01 Jan 2010 07:50:13 +0100
Received: from 141-53-237-24.gci.net ([24.237.53.141])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jan 2010 07:50:13 +0100
Received: from dave by 141-53-237-24.gci.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jan 2010 07:50:13 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.237.53.141 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_2; en-us) AppleWebKit/531.21.8 (KHTML, like Gecko) Version/4.0.4 Safari/531.21.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136003>

1. If shell-file-name points to a shell on the local machine but not
   on the remote server, a remote magit-status fails.  I had to
   create a symlink from /bin/bash to /usr/local/bin/bash on my
   FreeBSD server before it would work

2. Any attempt to stage changes fails for me.  I get a "Git Failed."
   message and see this in the *magit-process* buffer:

  $ git --no-pager add -u .
  fatal: Not a git repository (or any of the parent directories): .git

Any clues for me?

TIA,

--
Dave Abrahams           Meet me at BoostCon: http://www.boostcon.com
BoostPro Computing
http://www.boostpro.com
