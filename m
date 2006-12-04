X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: latest update to git-svn blows up for me
Date: Sun, 3 Dec 2006 23:00:21 -0800
Message-ID: <20061204070021.GG1369@localdomain>
References: <863b7wnwcw.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 07:00:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <863b7wnwcw.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33167>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr7oR-0005uz-5H for gcvg-git@gmane.org; Mon, 04 Dec
 2006 08:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758483AbWLDHAY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 02:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758502AbWLDHAY
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 02:00:24 -0500
Received: from hand.yhbt.net ([66.150.188.102]:31648 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1758483AbWLDHAX (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 02:00:23 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id A449D2DC034; Sun,  3 Dec 2006 23:00:21 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 03 Dec 2006
 23:00:21 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org

"Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> 
> Does this ring a bell?

Nope.

> Fetching git-svn
>         M       trunk/lib/Perl/Critic/Policy/TestingAndDebugging/MisplacedShebang.pm
>         M       trunk/lib/Perl/Critic/Policy/TestingAndDebugging/ProhibitShebangWarningsArg.pm
>         M       trunk/lib/Perl/Critic/Policy/TestingAndDebugging/RequirePortableShebang.pm
>         M       trunk/compilers/past-pm/POST/Compiler.pir
>         M       trunk/compilers/past-pm/PAST/Compiler.pir
>         M       trunk/compilers/past-pm/PAST-pm.pir
>         M       trunk/languages/perl6/src/quote.pir
>         M       trunk/languages/perl6/src/classes/Str.pir
>         M       trunk/languages/perl6/src/classes/Code.pir
>         M       trunk/languages/perl6/src/classes/Num.pir
>         M       trunk/languages/plumhead/t/selection.txt
>         M       trunk/languages/plumhead/t/superglobals.t
>         M       trunk/languages/plumhead/t/strings.t
>         M       trunk/languages/tcl/runtime/builtin/clock.pir
> no blob information
> 512 at /opt/git/bin/git-svn line 457
>         main::fetch_lib() called at /opt/git/bin/git-svn line 328
>         main::fetch() called at /opt/git/bin/git-svn line 973
>         main::fetch_child_id('git-svn') called at /opt/git/bin/git-svn line 991
>         main::rec_fetch('', '/Volumes/UFS/MIRROR/parrot-GITSVN/.git/svn') called at /opt/git/bin/git-svn line 747
>         main::multi_fetch() called at /opt/git/bin/git-svn line 187
> 512 at /opt/git/bin/git-svn line 980
>         main::fetch_child_id('git-svn') called at /opt/git/bin/git-svn line 991
>         main::rec_fetch('', '/Volumes/UFS/MIRROR/parrot-GITSVN/.git/svn') called at /opt/git/bin/git-svn line 747
>         main::multi_fetch() called at /opt/git/bin/git-svn line 187

This is on r15941 of  https://svn.perl.org/parrot/trunk ?  I can't seem
to reproduce this with git svn fetch -r15940:15941

-- 
