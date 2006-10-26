X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Check git base URLs before generating URL from it
Date: Thu, 26 Oct 2006 19:39:12 +0200
Organization: At home
Message-ID: <ehqrqm$co1$1@sea.gmane.org>
References: <200610261226.44960.jnareb@gmail.com> <7vr6wvkn66.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 26 Oct 2006 17:39:49 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 13
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30251>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd9CK-0006Le-2e for gcvg-git@gmane.org; Thu, 26 Oct
 2006 19:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161218AbWJZRjQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 13:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbWJZRjQ
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 13:39:16 -0400
Received: from main.gmane.org ([80.91.229.2]:2767 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1161218AbWJZRjP (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 13:39:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gd9Bu-0006Gj-IB for git@vger.kernel.org; Thu, 26 Oct 2006 19:38:55 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 19:38:54 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 19:38:54 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Wouldn't this be simpler and more to the point, I wonder?

> -our @git_base_url_list = ("++GITWEB_BASE_URL++");
> +our @git_base_url_list = grep { $_ ne '' } ("++GITWEB_BASE_URL++");

Yes, that would be cartainly better.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

