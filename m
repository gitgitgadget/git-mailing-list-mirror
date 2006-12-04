X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: latest update to git-svn blows up for me
Date: 04 Dec 2006 12:04:56 -0800
Message-ID: <86slfvl95j.fsf@blue.stonehenge.com>
References: <863b7wnwcw.fsf@blue.stonehenge.com>
	<20061204070021.GG1369@localdomain>
	<86hcwbnb0o.fsf@blue.stonehenge.com> <20061204181241.GA27342@soma>
	<86zma3lahj.fsf@blue.stonehenge.com> <20061204195452.GB27342@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 20:05:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.15.11; tzolkin = 5 Chuen; haab = 4 Mac
In-Reply-To: <20061204195452.GB27342@soma>
Original-Lines: 47
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33236>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrK44-0004GF-JB for gcvg-git@gmane.org; Mon, 04 Dec
 2006 21:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966377AbWLDUFH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 15:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966387AbWLDUFG
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 15:05:06 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:14223 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S966377AbWLDUE6 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 15:04:58 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id C19228FAF4; Mon,  4 Dec 2006 12:04:57 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 27297-01-66; Mon,  4 Dec 2006 12:04:57 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 1AED48FD65;
 Mon,  4 Dec 2006 12:04:57 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

>>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:

Eric> Can you try:

Eric> git update-ref refs/remotes/git-svn \
Eric>   <last commit successfully imported from git-svn>

Eric> and running rebuild again?

Yes, and now after seeing 14000 lines scroll by, I tried again:

localhost.local:..RROR/parrot-GITSVN % git-svn multi-fetch                     
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

Anything you want me to try now?  I'm not in a fast net place (at
least not for a week), so I can't rebuild from scratch.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
