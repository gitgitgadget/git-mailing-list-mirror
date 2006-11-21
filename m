X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Merging in commits from a non-common ancestors
Date: Tue, 21 Nov 2006 16:41:36 +0100
Organization: At home
Message-ID: <ejv6kk$6uu$1@sea.gmane.org>
References: <1164122884.28560.210.camel@okra.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 21 Nov 2006 15:41:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 25
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31994>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmXkm-00024x-8m for gcvg-git@gmane.org; Tue, 21 Nov
 2006 16:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934386AbWKUPki (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 10:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934379AbWKUPki
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 10:40:38 -0500
Received: from main.gmane.org ([80.91.229.2]:31407 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S934386AbWKUPkg (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 10:40:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GmXjU-0001jU-5n for git@vger.kernel.org; Tue, 21 Nov 2006 16:40:24 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 16:40:24 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 21 Nov 2006
 16:40:24 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Alex Bennee wrote:

> I've been experimenting with using git alongside our CVS to manage my
> own development. In an ideal world I would have a full git tree with all
> the baselines tagged in it so merging is painless. However for the time
> being I have written a script to import a cvs tag into a git tree (that
> ignores the CVS gubbins). However one of the things I want to achieve is
> the ability to easily move hacks/patches from one tree to another.
> 
> The problem is that these tree's don't have common ancestor's in the git
> tree as I haven't imported all our baselines. However the individual
> commits should apply, I'm just not sure how to tell git to apply the
> commits as patches rather than try and work out the full differences
> between the two trees. Of course I'd like git to keep the commit
> messages.

git cherry-pick. It uses patching instead of merging. 

Or git-format-patch plus git-am.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

