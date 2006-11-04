X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Kevin Shanahan <kmshanah@disenchant.net>
Subject: Re: Problem with git-apply?
Date: Sat, 4 Nov 2006 20:42:00 +1030
Message-ID: <20061104101200.GC19667@cubit>
References: <20061104072349.GA19667@cubit> <eihmas$8sj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 10:12:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <eihmas$8sj$1@sea.gmane.org>
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30914>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgIVX-0004OX-76 for gcvg-git@gmane.org; Sat, 04 Nov
 2006 11:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965211AbWKDKMG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 05:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbWKDKMG
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 05:12:06 -0500
Received: from whirlwind.netspace.net.au ([203.10.110.76]:60941 "EHLO
 mail.netspace.net.au") by vger.kernel.org with ESMTP id S965191AbWKDKME
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 05:12:04 -0500
Received: from mail.localnet (dsl-202-45-120-45-static.SA.netspace.net.au
 [202.45.120.45]) by mail.netspace.net.au (Postfix) with ESMTP id 790F2131C06;
 Sat,  4 Nov 2006 21:12:00 +1100 (EST)
Received: by mail.localnet (Postfix, from userid 1000) id 750B8BB00D2; Sat, 
 4 Nov 2006 20:42:00 +1030 (CST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Sat, Nov 04, 2006 at 10:26:13AM +0100, Jakub Narebski wrote:
> This I think is a bug, or rather misfeature in git-apply (or at least
> inconsistency between GNU diff and git patch format). But if you change
> from-file line from "--- a/foo" to "--- /dev/null" then git-apply happily
> applies creation patch and creates file.

Thanks. At least that gives me a workaround for now.

Cheers,
