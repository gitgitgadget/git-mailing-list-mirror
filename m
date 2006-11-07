X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC] git-gui: A commit / fetch / push interface
Date: Wed, 8 Nov 2006 09:46:47 +1100
Message-ID: <17745.3287.358673.265578@cargo.ozlabs.ibm.com>
References: <20061107083603.GB9622@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 22:47:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061107083603.GB9622@spearce.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31097>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhZim-0006TX-KY for gcvg-git@gmane.org; Tue, 07 Nov
 2006 23:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753408AbWKGWrE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 17:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753417AbWKGWrE
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 17:47:04 -0500
Received: from ozlabs.org ([203.10.76.45]:19666 "EHLO ozlabs.org") by
 vger.kernel.org with ESMTP id S1753408AbWKGWrC (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 17:47:02 -0500
Received: by ozlabs.org (Postfix, from userid 1003) id 7688F67D72; Wed,  8
 Nov 2006 09:47:01 +1100 (EST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce writes:

> I liked it and wanted to start making it available to some folks I
> work with who are more comfortable with the mouse than they are with
> the keyboard.  At first I tried fixing a few of the outstanding bugs
> in gitool but I eventually wound up rewriting the thing from scratch.

Cool!

> I have posted a repository with the source on pasky's service:
> 
> 	http://repo.or.cz/w/git-gui.git

Shouldn't the "w" be "r" there?  It gave me an error "Can't lock ref"
with the "w".

> My goal is to have enough operations available through git-gui that
> the average user won't need to leave it, unless he/she needs to do a
> cherry-pick, am, etc. type of operation.  Or they want to browse the
> history, in which case they can just start gitk from within git-gui.
> I'm hoping to have most of it done this week.  :-)

One thing I have been meaning to do is to integrate gitool into gitk,
now that gitk can display a fake commit showing the local changes.  I
intend to add a menu item to gitk saying "Commit local changes" or
something, which would invoke gitool, or maybe now git-gui instead. :)
The nice thing is that then gitk could update the graph to show the
new commit once it was created.

My current version of gitool also has menus that let you revert
modified files, and delete or ignore untracked files.  Have you
considered adding that to git-gui?

Regards,
