X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Avoiding uninteresting merges in Cairo
Date: Fri, 15 Dec 2006 15:21:36 +0100
Organization: At home
Message-ID: <eluasq$v7q$3@sea.gmane.org>
References: <20061215020629.GK26202@spearce.org> <87tzzx4zm7.wl%cworth@cworth.org> <20061215032530.GM26202@spearce.org> <87slfh4xkm.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 15 Dec 2006 14:20:15 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 22
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34505>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvDv2-0008Kd-0c for gcvg-git@gmane.org; Fri, 15 Dec
 2006 15:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752618AbWLOOUI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 09:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbWLOOUI
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 09:20:08 -0500
Received: from main.gmane.org ([80.91.229.2]:49828 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1752618AbWLOOUH
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 09:20:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GvDus-00046k-K5 for git@vger.kernel.org; Fri, 15 Dec 2006 15:20:02 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 15:20:02 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 15:20:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Carl Worth wrote:

> On Thu, 14 Dec 2006 22:25:30 -0500, Shawn Pearce wrote:

>>  * gitweb made it appear as though a whole lot of Carl's recent
>>    work was somehow undone in the merge.
> 
> That looks like a simple gitweb bug. None of the other tools, (gitk,
> git log -p), consider a trivial merge commit like this as having
> anything interesting in it worth displaying.

It's not a bug, it is rather lack of feature (or misfeature).

Gitweb deals with multiparent commits (merge commits) that it uses
_first_ parent. No special casing merges (like git-show doesn't
show whatchanged/patch for merges), no support for -c/--cc diff
(combined diff format).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

