X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Drake <ddrake@brontes3d.com>
Subject: Re: git-svnimport breakage as of git-1.4.4
Date: Thu, 14 Dec 2006 16:05:00 -0500
Message-ID: <1166130300.21982.0.camel@systems03.lan.brontes3d.com>
References: <1165505193.26874.13.camel@systems03.lan.brontes3d.com>
	 <20061208203230.GA9193@sashak.voltaire.com>
	 <1165847230.13854.2.camel@systems03.lan.brontes3d.com>
	 <20061211204904.GC1003@sashak.voltaire.com>
	 <1166027289.21948.4.camel@systems03.lan.brontes3d.com>
	 <20061214022142.GA14521@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 21:05:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061214022142.GA14521@sashak.voltaire.com>
X-Mailer: Evolution 2.8.2.1 
X-Virus-Scanned: OK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34399>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuxlN-0007Xs-4Q for gcvg-git@gmane.org; Thu, 14 Dec
 2006 22:05:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932910AbWLNVFF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 16:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932900AbWLNVFF
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 16:05:05 -0500
Received: from smtp152.iad.emailsrvr.com ([207.97.245.152]:53866 "EHLO
 smtp152.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932911AbWLNVFD (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 16:05:03 -0500
Received: from [10.20.253.243] (host34.155.212.242.conversent.net
 [155.212.242.34]) (Authenticated sender: ddrake@brontes3d.com) by
 relay5.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id AC6F9647102; Thu,
 14 Dec 2006 16:05:00 -0500 (EST)
To: Sasha Khapyorsky <sashak@voltaire.com>
Sender: git-owner@vger.kernel.org

On Thu, 2006-12-14 at 04:21 +0200, Sasha Khapyorsky wrote:
> Try this please:
> 
> 
> diff --git a/git-svnimport.perl b/git-svnimport.perl
> index cbaa8ab..071777b 100755
> --- a/git-svnimport.perl
> +++ b/git-svnimport.perl

Thanks, it now works for both forms of command line arguments.

-- 
Daniel Drake
Brontes Technologies, A 3M Company
