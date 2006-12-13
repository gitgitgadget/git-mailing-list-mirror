X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: t9100-git-svn-basic.sh fails
Date: Tue, 12 Dec 2006 17:01:03 -0800
Message-ID: <20061213010103.GA18036@localdomain>
References: <20061212232321.GL2476@albany.tokkee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 01:01:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 20:01:14 EST
Content-Disposition: inline
In-Reply-To: <20061212232321.GL2476@albany.tokkee.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34174>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuIUs-00089p-3X for gcvg-git@gmane.org; Wed, 13 Dec
 2006 02:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964863AbWLMBBP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 20:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWLMBBP
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 20:01:15 -0500
Received: from hand.yhbt.net ([66.150.188.102]:54561 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S964863AbWLMBBO
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 20:01:14 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 18F462DC034; Tue, 12 Dec 2006 17:01:12 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 12 Dec 2006
 17:01:03 -0800
To: Sebastian Harl <sh@tokkee.org>
Sender: git-owner@vger.kernel.org

Sebastian Harl <sh@tokkee.org> wrote:
> Hi,
> 
> When compiling git 1.4.4.2 on my Debian Sarge box t9100-git-svn-basic.sh fails
> with the following output:
> 
>   * FAIL 6: detect node change from directory to file #1
>          git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch2
> 
> I'm using subversion 1.3.2.
> 
> Versions up to 1.4.3.2 built fine.
> 
> Any clues what this might be caused by?

Are you using the svn command-line client or are the Perl SVN libraries
installed?  I made a fix for people using version 1.4.x of the the
command-line client, but I recall backwards compatibility was preserved
as far as svn 1.1 goes.

-- 
