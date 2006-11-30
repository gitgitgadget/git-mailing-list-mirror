X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Theodore Tso <tytso@mit.edu>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 15:01:22 -0500
Message-ID: <20061130200122.GD10999@thunk.org>
References: <ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de> <456CA981.4010808@onlinehome.de> <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org> <456CB197.2030201@onlinehome.de> <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org> <Pine.LNX.4.63.0611291149440.30004@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611290922410.3513@woody.osdl.org> <456DD76C.4010902@gmx.net> <456ECDAF.4050102@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 20:02:19 +0000 (UTC)
Cc: Marko Macek <marko.macek@gmx.net>, git@vger.kernel.org,
	bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <456ECDAF.4050102@op5.se>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32794>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gps6A-0004W1-F4 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 21:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031172AbWK3UBb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 15:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031279AbWK3UBb
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 15:01:31 -0500
Received: from thunk.org ([69.25.196.29]:24716 "EHLO thunker.thunk.org") by
 vger.kernel.org with ESMTP id S1031172AbWK3UBa (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 15:01:30 -0500
Received: from root (helo=candygram.thunk.org) by thunker.thunk.org with
 local-esmtps  (tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1
 (Debian)) id 1Gps9h-0003eg-T8; Thu, 30 Nov 2006 15:05:14 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
 (envelope-from <tytso@thunk.org>) id 1Gps5y-0003or-EO; Thu, 30 Nov 2006
 15:01:22 -0500
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

On Thu, Nov 30, 2006 at 01:25:19PM +0100, Andreas Ericsson wrote:
> Unless you do "git update-index" (and thus are already using the index) 
> on any files, "git diff" shows you exactly the changes between your last 
> commit and the working tree. There's nothing magic, odd or confusing 
> about it, no matter which scm you come from.

Until you make the mistake of reading the git-diff man page, at which
point the novice git user runs screaming into the night...

       Show changes between two ents, an ent and the working tree, an
       ent and the index file, or the index file and the working
       tree. The combination of what is compared with what is
       determined by the number of ents given to the command.

       * When no <ent> is given, the working tree and the index file
          is compared, using git-diff-files.

       * When one <ent> is given, the working tree and the named tree
          is compared, using git-diff-index. The option --cached can
          be given to compare the index file and the named tree.

       * When two <ent>s are given, these two trees are compared using
          git-diff-tree.

Looking at the man page, it does raise one interesting question ---
So exactly what is the difference between Treebeard and Quickbeam?

And how many working trees do we need before we call it an Entmoot?  :-)

