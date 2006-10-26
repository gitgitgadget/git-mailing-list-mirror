X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: merge-recursive, was Re: What's in git.git
Date: Thu, 26 Oct 2006 11:25:50 +0200
Organization: At home
Message-ID: <ehputm$ch2$3@sea.gmane.org>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0610261114520.3286@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 26 Oct 2006 09:25:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 16
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30164>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd1Ug-0001Iu-Ul for gcvg-git@gmane.org; Thu, 26 Oct
 2006 11:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422893AbWJZJZl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 05:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422910AbWJZJZl
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 05:25:41 -0400
Received: from main.gmane.org ([80.91.229.2]:62414 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1422893AbWJZJZk (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 05:25:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gd1UM-0001Db-ER for git@vger.kernel.org; Thu, 26 Oct 2006 11:25:29 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 11:25:26 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 11:25:26 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> BTW what happened to the builtin shortlog? It is the last Perl script I 
> use regularly... (should make people happy who are stuck with Activision 
> Perl...)

BTW. both Perl version and builtin shorlog have email->real name translation
table built in. In Perl script version it is in __DATA__ section, and we
could update it using Inline::Files module, in C version it was in table.
But in fact this list is project specific. Shouldn't we make it customizable
(::sigh::, yet another file in $GIT_DIR...).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

