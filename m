X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Merging in commits from a non-common ancestors
Date: Tue, 21 Nov 2006 15:28:03 +0000
Organization: Insert Joke Here
Message-ID: <1164122884.28560.210.camel@okra.transitives.com>
Reply-To: kernel-hacker@bennee.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 15:28:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Evolution 2.6.0 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31993>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmXXq-0006hV-AV for gcvg-git@gmane.org; Tue, 21 Nov
 2006 16:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934378AbWKUP2K (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 10:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934379AbWKUP2K
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 10:28:10 -0500
Received: from mx.transitive.com ([217.207.128.220]:23980 "EHLO
 pennyblack.transitives.com") by vger.kernel.org with ESMTP id S934378AbWKUP2J
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 10:28:09 -0500
Received: from [192.168.1.82] (helo=okra.transitives.com) by
 pennyblack.transitives.com with esmtp (Exim 4.50) id 1GmXPv-0003wE-4u for
 git@vger.kernel.org; Tue, 21 Nov 2006 15:20:11 +0000
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Hi,

I've been experimenting with using git alongside our CVS to manage my
own development. In an ideal world I would have a full git tree with all
the baselines tagged in it so merging is painless. However for the time
being I have written a script to import a cvs tag into a git tree (that
ignores the CVS gubbins). However one of the things I want to achieve is
the ability to easily move hacks/patches from one tree to another.

The problem is that these tree's don't have common ancestor's in the git
tree as I haven't imported all our baselines. However the individual
commits should apply, I'm just not sure how to tell git to apply the
commits as patches rather than try and work out the full differences
between the two trees. Of course I'd like git to keep the commit
messages.

Am I missing something blindingly obvious?

-- 
Alex, homepage: http://www.bennee.com/~alex/
In seeking the unattainable, simplicity only gets in the way. --
Epigrams in Programming, ACM SIGPLAN Sept. 1982
