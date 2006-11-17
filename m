X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.18.2
Date: Fri, 17 Nov 2006 01:49:30 +0100
Message-ID: <20061117004930.GC7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 00:49:41 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31648>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkrvF-0002tz-6p for gcvg-git@gmane.org; Fri, 17 Nov
 2006 01:49:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424824AbWKQAtd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 19:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424826AbWKQAtd
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 19:49:33 -0500
Received: from w241.dkm.cz ([62.24.88.241]:14793 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1424824AbWKQAtc (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 19:49:32 -0500
Received: (qmail 10719 invoked by uid 2001); 17 Nov 2006 01:49:30 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

  Hello,

  I've released cogito-0.18.2, bringing a couple of bugfixes and a trivial new
feature to cogito-0.18.1. Still nothing too groundshattering.

* cg-log does not follow history across renames anymore; it never really
  actually worked and was instead causing problems and random error
  messages. There needs to be git-core support for this funcionality,
  hacking it with a perl filter is bad design, so I'm not going to fix
  the filter (but I'd take patches if someone else did ;).

* Fix cg-init not letting you edit the initial commit message by default
* Fix cg-clone -l which would not setup alternates properly in some cases
* Fix cg-merge not picking the right base when following volatile branches
* Fix cg-log -d sometimes showing "% @" in diff output
* Some other minor fixes

* New cg-object-id -b to print the current branch name

* Documentation improvements (better documented ignoring mechanism,
  ~/.gitconfig mentioned, GIT_COMMITTER_* bogus information fixed, ...)
* Some testsuite fixes

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
