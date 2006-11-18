X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: [BUG] gitk: fails while unfolding dir in tree-view
Date: Sun, 19 Nov 2006 00:17:39 +0100
Message-ID: <20061118231739.GG5443@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 23:18:43 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31812>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlZSK-00011Z-Ls for gcvg-git@gmane.org; Sun, 19 Nov
 2006 00:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755363AbWKRXSh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 18:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755369AbWKRXSh
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 18:18:37 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:38125 "EHLO
 smtp5-g19.free.fr") by vger.kernel.org with ESMTP id S1755363AbWKRXSh (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 18:18:37 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp5-g19.free.fr (Postfix) with ESMTP id B8791279C9 for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 00:18:15 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id 1B4CB1F066;
 Sun, 19 Nov 2006 00:17:40 +0100 (CET)
To: GIT list <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

When using the "tree" view and trying to unfold a particular dir, I got
the following error:

can't read "treeheight(lib/)": no such element in array
can't read "treeheight(lib/)": no such element in array
    (reading value of variable to increment)
    invoked from within
"incr treeheight($x) $n"
    (procedure "treeopendir" line 15)
    invoked from within
"treeopendir $w $e"
    (procedure "treeclick" line 20)
    invoked from within
"treeclick .ctop.cdet.right.cfiles 18 233"
    (command bound to event)

This occurs with 1.4.3.3 as well as current master.  The tree exhibiting
the problem is from http://git.debian.org/git/deps/deps.git - select any
revision, switch to tree view, and attempt to unfold "lib" (the last
entry in the list).

Best regards,
-- 
Yann.
