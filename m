X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Rebasing part of a branch
Date: Thu, 02 Nov 2006 12:15:38 +0100
Organization: At home
Message-ID: <eick03$mh3$1@sea.gmane.org>
References: <200611021045.25423.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 2 Nov 2006 11:15:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 32
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30731>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaXr-0004qx-8R for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752854AbWKBLPg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 06:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbWKBLPg
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:15:36 -0500
Received: from main.gmane.org ([80.91.229.2]:10429 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1752854AbWKBLPf (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:15:35 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GfaXi-0004o5-Ea for git@vger.kernel.org; Thu, 02 Nov 2006 12:15:30 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 12:15:30 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 02 Nov 2006
 12:15:30 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

> Hello,
> 
> Is there a way to rebase part of a branch?  For example
> 
>                         H---I---J topicB
>                        /
>               E---F---G  topicA
>              /
> A---B---C---D  master
> 
> And I want:
> 
>              H---I---J  topicB
>             /
>             | E---F---G  topicA
>             |/
> A---B---C---D  master

We have
 git-rebase [--merge] [--onto <newbase>] <upstream> [<branch>]

Try then
$ git rebase --onto master topicA topicB

(if you checked out topicB, you don't need last topicB in git-rebase).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

