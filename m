X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: Refactor feed generation, make output prettier, add Atom feed
Date: Mon, 20 Nov 2006 15:45:55 +0100
Organization: At home
Message-ID: <ejsf09$dej$1@sea.gmane.org>
References: <200611171236.19030.jnareb@gmail.com> <11639451221153-git-send-email-jnareb@gmail.com> <11639451253906-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 20 Nov 2006 14:45:28 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31914>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmAOW-0004zN-3o for gcvg-git@gmane.org; Mon, 20 Nov
 2006 15:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934205AbWKTOpF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 09:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934203AbWKTOpF
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 09:45:05 -0500
Received: from main.gmane.org ([80.91.229.2]:18345 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S934209AbWKTOpE (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 09:45:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GmAOC-0004sP-Hq for git@vger.kernel.org; Mon, 20 Nov 2006 15:44:53 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 15:44:52 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 20 Nov 2006
 15:44:52 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:

> Allow for feed generation for branches other than current (HEAD)
> branch, and for generation of feeds for file or directory history.

By the way, which feed format use for branch feeds? Atom or RSS?
Or perhaps leave this configurable? But which way:
  our $default_feed_format = 'atom';
or use 'feedformat' feature?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

