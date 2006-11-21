X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 15:01:57 +0100
Organization: At home
Message-ID: <ejv0pq$g2d$1@sea.gmane.org>
References: <200611211341.48862.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 21 Nov 2006 14:01:20 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 18
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31989>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmWBV-0000nM-VE for gcvg-git@gmane.org; Tue, 21 Nov
 2006 15:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030971AbWKUOBE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 09:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030974AbWKUOBE
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 09:01:04 -0500
Received: from main.gmane.org ([80.91.229.2]:32970 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1030971AbWKUOBC (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 09:01:02 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GmWB2-0000hh-2G for git@vger.kernel.org; Tue, 21 Nov 2006 15:00:44 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 15:00:44 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 21 Nov 2006
 15:00:44 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

> I'm sure this one will be known about already.  git-show --stat on the the 
> first commit doesn't show anything.  I assume it's because git-diff-tree has 
> nothing to diff against (although shouldn't that be an everything-new diff?).

Yes, and git-diff-tree requires --root option if you want to generate
creation diff for initial (parentless, root) commit.
 
> Given the above; does anyone have a suggestion for what I could use as a 
> replacement?  Even just a list of the new files would be useful.

git show --stat --root
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

