X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add git-count-packs, like git-count-objects.
Date: Fri, 03 Nov 2006 13:53:08 +0100
Organization: At home
Message-ID: <eife2p$qqq$1@sea.gmane.org>
References: <20061028040056.GA14191@spearce.org> <7v8xj1axlm.fsf@assigned-by-dhcp.cox.net> <20061028065143.GA14607@spearce.org> <ehvpcs$20j$2@sea.gmane.org> <fcaeb9bf0611020130r70ed6f4cnf67586deff36452e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 3 Nov 2006 12:53:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 17
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30844>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfyXt-0002h1-3m for gcvg-git@gmane.org; Fri, 03 Nov
 2006 13:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751151AbWKCMxK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 07:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWKCMxK
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 07:53:10 -0500
Received: from main.gmane.org ([80.91.229.2]:42377 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1751151AbWKCMxJ (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 07:53:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GfyXR-0002Zh-Rt for git@vger.kernel.org; Fri, 03 Nov 2006 13:52:49 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 13:52:49 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 03 Nov 2006
 13:52:49 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Nguyen Thai Ngoc Duy wrote:

> On 10/28/06, Jakub Narebski <jnareb@gmail.com> wrote:

>> Perhaps to not to add yet another command to already large set, rename
>> git-count-objects to git-count, and enhance it to count both loose objects
>> and packs (or not, and use git-count-objects as command name).
> 
> Oh if so, I'd suggest git-stats over git-count :-)

Or even git-db-stats (as companion to git-db-init).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

