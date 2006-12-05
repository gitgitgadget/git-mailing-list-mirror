X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: latest update to git-svn blows up for me
Date: 04 Dec 2006 20:33:49 -0800
Message-ID: <86odqjj70y.fsf@blue.stonehenge.com>
References: <863b7wnwcw.fsf@blue.stonehenge.com>
	<20061204070021.GG1369@localdomain>
	<86hcwbnb0o.fsf@blue.stonehenge.com> <20061204181241.GA27342@soma>
	<86zma3lahj.fsf@blue.stonehenge.com> <20061204195452.GB27342@soma>
	<86slfvl95j.fsf@blue.stonehenge.com>
	<20061204200844.GC30316@hand.yhbt.net>
	<86odqjl8vp.fsf@blue.stonehenge.com>
	<20061204205126.GA23853@hand.yhbt.net>
	<20061205040844.GA6826@localdomain>
	<86slfvj7oi.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 04:34:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.15.11; tzolkin = 5 Chuen; haab = 4 Mac
In-Reply-To: <86slfvj7oi.fsf@blue.stonehenge.com>
Original-Lines: 76
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33299>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrS0O-0006Od-9i for gcvg-git@gmane.org; Tue, 05 Dec
 2006 05:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968163AbWLEEdw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 23:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968318AbWLEEdw
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 23:33:52 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:17413 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S968163AbWLEEdv (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 23:33:51 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id EBF3B8F6B4; Mon,  4 Dec 2006 20:33:50 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 05920-01-89; Mon,  4 Dec 2006 20:33:50 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 2284C8F6D5;
 Mon,  4 Dec 2006 20:33:50 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

>>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:
Eric> Eric Wong <normalperson@yhbt.net> wrote:
>>> Same here..  I'm still waiting for it to fetch and will try to reproduce
>>> it here.

Eric> Update: Nearly 16k revisions later and I still can't reproduce this on
Eric> my computer.

Randal> I still say it was odd that it happened exactly when I did a git-svn
Randal> update in the other window. :)

Randal> So, maybe I'll just toss this archive.  Oh wait, can I back it up a few dozen
Randal> revs and try to roll forward?  That might be interesting.

Randal> git-reset --hard HEAD~10
Randal> blow away everything you had me blow away last time
Randal> make git-svn equal to HEAD
Randal> git-svn rebuild
Randal> git-svn fetch

Randal> Lemme try that.

Nope.  I reset it back 20 revs, and it correctly fast forwarded until
the fatal item again:

            M       trunk/languages/plumhead/past_xml_to_past_pir.xsl
            M       trunk/languages/plumhead/t/hello.t
            A       trunk/languages/plumhead/t/strings.t
            M       trunk/languages/plumhead/t/arithmetics.t
            M       trunk/languages/plumhead/TODO
            M       trunk/languages/plumhead/phc_xml_to_past_xml.xsl
    r15936 = 1933fe5f95d4ff29d9bb086faca9059a765b7abb
            M       trunk/MANIFEST
            M       trunk/MANIFEST.SKIP
    r15937 = 17624a0457339d4eeeecc03632d609b6220ac02d
            M       trunk/languages/plumhead/phc_xml_to_past_xml.xsl
    r15938 = bc577df90b886d8afd89774231cd321a40fd06ed
            M       trunk/languages/tcl/runtime/builtin/string.pir
    r15939 = dddd42d84b38cb5ab9cc8ca377767459f3966a60
            M       trunk/languages/tcl/runtime/builtin/binary.pir
    r15940 = 5cd630a9b67948eb788cb4fdb87998d960977a75
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

It just hates me, perhaps.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
