X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Explicitly add the default "git pull" behaviour to .git/config on clone
Date: Fri, 08 Dec 2006 11:36:36 +0100
Organization: At home
Message-ID: <elbf3l$bm7$1@sea.gmane.org>
References: <200612061207.23437.andyparkins@gmail.com> <200612070349.58521.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.63.0612071511440.28348@wbgn013.biozentrum.uni-wuerzburg.de> <200612071544.03306.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 8 Dec 2006 10:35:05 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33679>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsd4H-0001IE-Rs for gcvg-git@gmane.org; Fri, 08 Dec
 2006 11:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425337AbWLHKek (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 05:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425340AbWLHKej
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 05:34:39 -0500
Received: from main.gmane.org ([80.91.229.2]:41915 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1425337AbWLHKei
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 05:34:38 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gsd3t-0004hL-M7 for git@vger.kernel.org; Fri, 08 Dec 2006 11:34:37 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 11:34:37 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 08 Dec 2006
 11:34:37 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Josef Weidendorfer wrote:

> However, as discussed in another thread, branch.*.merge currently has quite
> a strange semantic [*1*], and without changing, users have no way to grasp this
> configuration option.
[...]
> [*1*] Currently, in branch.*.merge you have to specify the remote branch name
> of a refspec which updates a local tracking branch in the fetch phase of git pull.
> I.e. the option value has nothing todo with the merge action itself!

That's (I think) because branch.<name>.merge can be for pull used _without_
tracking branch. So it is not that easy to change semantics, I agree bit
strange for newbie git users, who know git from the begining with
--use-separate-remote and tracking branches.

Perhaps we should extend it so it can take beginning part of refspec
(as now), full refspec, or ':' and local branch.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

