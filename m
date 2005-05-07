From: Jonas Fonseca <fonseca@diku.dk>
Subject: Updated versions of previously posted patches
Date: Sat, 7 May 2005 05:38:47 +0200
Message-ID: <20050507033847.GA6258@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 05:32:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUG30-0003E1-76
	for gcvg-git@gmane.org; Sat, 07 May 2005 05:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbVEGDiv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 23:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVEGDiv
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 23:38:51 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:17364 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S262638AbVEGDis (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 23:38:48 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id C85FE6E2658; Sat,  7 May 2005 05:37:39 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 879CC6E263A; Sat,  7 May 2005 05:37:39 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 7D28561FDE; Sat,  7 May 2005 05:38:47 +0200 (CEST)
To: pasky@ucw.cz
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi pasky,

I have updated the patches I have previously posted here. They are
available at http://www.nitro.dk/~jonas/cogito/ and carry the following
changes:

- 0--move-date-to-Xlib.patch

  Move date conversion from cg-log to cg-Xlib so it can be used in the
  next patch.

- 1--human-readable-mkpatch-dates.patch: 

  Show the author and commit date in a human readable format.

- 2--show-changed-files-in-log-output.patch

  Add an -f switch to cg-log controlling whether to list which files
  were changed. The output looks like the following:

	<commit header>

	    * file1, file2, ..., fileN:

	    <log message>

  It doesn't do anything fancy like wrapping long lines and can be quite
  costly to do for big logs.

- 3--add-mkpatch-short-version.patch

  Add an -s option to cg-mkpatch which specifies whether to print a
  short version of the patch without a patch header with meta info such
  as author and committer.

  This was proposed by you after YOSHIFUJI Hideaki pointed out that the
  diffstat is not always useful. However, I don't know if this is
  anywhere near how you intended it to be. Anyway, it prepares for the
  next patch.

- 4--show-diffstat-for-mkpatch.patch

  Show diffstat as part of the patch header if diffstat is available on
  the system.

  I didn't test this since diffstat unfortunately wasn't available on
  the system I updated the patches on.

-- 
Jonas Fonseca
