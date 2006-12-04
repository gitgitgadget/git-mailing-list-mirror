X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: latest update to git-svn blows up for me
Date: 03 Dec 2006 20:00:47 -0800
Message-ID: <863b7wnwcw.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 04:01:12 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.15.10; tzolkin = 4 Oc; haab = 3 Mac
Original-Lines: 36
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33163>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr50u-0003VH-JT for gcvg-git@gmane.org; Mon, 04 Dec
 2006 05:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759229AbWLDEAw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 23:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759247AbWLDEAw
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 23:00:52 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:1678 "EHLO
 blue.stonehenge.com") by vger.kernel.org with ESMTP id S1759229AbWLDEAv
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 23:00:51 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id AE07B8F5CE for <git@vger.kernel.org>; Sun,  3 Dec
 2006 20:00:50 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 17627-01-25 for <git@vger.kernel.org>; Sun,  3 Dec 2006 20:00:49 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id A7B658FB77;
 Sun,  3 Dec 2006 20:00:47 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Does this ring a bell?

Fetching git-svn
        M       trunk/lib/Perl/Critic/Policy/TestingAndDebugging/MisplacedShebang.pm
        M       trunk/lib/Perl/Critic/Policy/TestingAndDebugging/ProhibitShebangWarningsArg.pm
        M       trunk/lib/Perl/Critic/Policy/TestingAndDebugging/RequirePortableShebang.pm
        M       trunk/compilers/past-pm/POST/Compiler.pir
        M       trunk/compilers/past-pm/PAST/Compiler.pir
        M       trunk/compilers/past-pm/PAST-pm.pir
        M       trunk/languages/perl6/src/quote.pir
        M       trunk/languages/perl6/src/classes/Str.pir
        M       trunk/languages/perl6/src/classes/Code.pir
        M       trunk/languages/perl6/src/classes/Num.pir
        M       trunk/languages/plumhead/t/selection.txt
        M       trunk/languages/plumhead/t/superglobals.t
        M       trunk/languages/plumhead/t/strings.t
        M       trunk/languages/tcl/runtime/builtin/clock.pir
no blob information
512 at /opt/git/bin/git-svn line 457
        main::fetch_lib() called at /opt/git/bin/git-svn line 328
        main::fetch() called at /opt/git/bin/git-svn line 973
        main::fetch_child_id('git-svn') called at /opt/git/bin/git-svn line 991
        main::rec_fetch('', '/Volumes/UFS/MIRROR/parrot-GITSVN/.git/svn') called at /opt/git/bin/git-svn line 747
        main::multi_fetch() called at /opt/git/bin/git-svn line 187
512 at /opt/git/bin/git-svn line 980
        main::fetch_child_id('git-svn') called at /opt/git/bin/git-svn line 991
        main::rec_fetch('', '/Volumes/UFS/MIRROR/parrot-GITSVN/.git/svn') called at /opt/git/bin/git-svn line 747
        main::multi_fetch() called at /opt/git/bin/git-svn line 187


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
