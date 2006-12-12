X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Tracking a repository for content instead of history
Date: Tue, 12 Dec 2006 14:04:51 +0100
Organization: At home
Message-ID: <elm993$rf1$1@sea.gmane.org>
References: <200612121235.09984.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 12 Dec 2006 13:02:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 25
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34096>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu7HV-0004xb-Jk for gcvg-git@gmane.org; Tue, 12 Dec
 2006 14:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751302AbWLLNCq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 08:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWLLNCq
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 08:02:46 -0500
Received: from main.gmane.org ([80.91.229.2]:48197 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751302AbWLLNCp
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 08:02:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gu7HK-0004Sv-PQ for git@vger.kernel.org; Tue, 12 Dec 2006 14:02:38 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 14:02:38 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 12 Dec 2006
 14:02:38 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

> For interests sake I'd like to track the kernel.org linux repository.  
> However, I'm not that bothered about tracking the history - it's more that I 
> like to have the latest kernel release lying around.
> 
> Is there a way that I could just pull individual commits from a git 
> repository?  In particular - could I make a repository (obviously not a 
> clone, because it wouldn't have all the history) that contained only the 
> tagged commits from an upstream repository?

As of beta (in 'next') you can do 'shallow clone'm i.e. clone/fetch
only N commits depth history.
 
> Is it even sensible to want that?  It strikes me that it's possible that there 
> isn't that much space/bandwidth saving to be made.  Should I just clone the 
> repository and shut up?  :-)

I've had similar idea: search for "sparse clone" keyword. But no code.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

