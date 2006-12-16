X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Sat, 16 Dec 2006 14:59:40 +0100
Organization: At home
Message-ID: <em0u4k$8hs$1@sea.gmane.org>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 16 Dec 2006 14:00:21 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Followup-To: gmane.comp.version-control.git
Original-Lines: 17
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34617>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gva5F-0006VR-T1 for gcvg-git@gmane.org; Sat, 16 Dec
 2006 15:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753747AbWLPOAJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 09:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbWLPOAI
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 09:00:08 -0500
Received: from main.gmane.org ([80.91.229.2]:57025 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1753749AbWLPOAG
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 09:00:06 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gva4z-00082S-Mi for git@vger.kernel.org; Sat, 16 Dec 2006 14:59:57 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 14:59:57 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 16 Dec 2006
 14:59:57 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Things that need to be done to complete what have been merged to
> 'master' are:

What about discussed but not implemented moving restriction on non-head refs
from git-checkout (forbidding to checkout tags, remotes, and arbitrary
commits like HEAD~n) to git-commit (allowing commiting only to heads refs)?
Probably non-heads refs should be saved in HEAD as explicit sha1 of a
commit; this way we wont run into situation where HEAD changed under us
(because it was for example to remote branch, and we fetched since).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

