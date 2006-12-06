X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Explicitly add the default "git pull" behaviour to .git/config on clone
Date: Wed, 06 Dec 2006 18:15:46 +0100
Organization: At home
Message-ID: <el6to1$vhi$1@sea.gmane.org>
References: <200612061207.23437.andyparkins@gmail.com> <200612061800.17087.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 6 Dec 2006 17:14:20 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 14
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33495>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs0LU-0004Rm-LS for gcvg-git@gmane.org; Wed, 06 Dec
 2006 18:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936837AbWLFROI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 12:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936860AbWLFROI
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 12:14:08 -0500
Received: from main.gmane.org ([80.91.229.2]:52722 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S936791AbWLFROE
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 12:14:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gs0L2-0006l4-K5 for git@vger.kernel.org; Wed, 06 Dec 2006 18:13:44 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 18:13:44 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006
 18:13:44 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Josef Weidendorfer wrote:

> I even would go so far to setup
> a default "git-pull" action even for branching off from local branches,
> by setting "branch.<newbranch>.remote = ." to merge from local "upstream".

I wouldn't go that far, as it would forbit perfectly good "git fetch"
from anywhere in the sources meaning "git fetch origin".

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

