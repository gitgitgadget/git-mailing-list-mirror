X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [DRAFT] Branching and merging with git
Date: Sat, 18 Nov 2006 01:32:25 +0100
Organization: At home
Message-ID: <ejlk82$av5$1@sea.gmane.org>
References: <20061117182157.GC11882@fieldses.org> <20061118001355.23488.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 18 Nov 2006 00:31:39 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 17
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31741>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlE7N-0003U0-BJ for gcvg-git@gmane.org; Sat, 18 Nov
 2006 01:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756106AbWKRAbY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 19:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756111AbWKRAbX
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 19:31:23 -0500
Received: from main.gmane.org ([80.91.229.2]:41658 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1756106AbWKRAbW (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 19:31:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GlE6z-0003Pp-6w for git@vger.kernel.org; Sat, 18 Nov 2006 01:31:13 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 18 Nov 2006 01:31:13 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 18 Nov 2006
 01:31:13 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

linux@horizon.com wrote:

[...]
> (Are there any octopus merges in git's history?  If not, could I ask
> for one for pedagogical value?)

See commit d425142e2a045a9dd7879d028ec68bd748df48a3 (most legged octopus
I found in git.git repository). Doing git-rev-parse --parents -all, or 
git log --all and greppoing for merges is a good idea to find octopi.

The commit is both v1.1.2-gd425142 (git describe) and tags/v1.2.0^0~143 
(git name-rev --tags)
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

