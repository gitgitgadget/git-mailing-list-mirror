X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/5] gitweb: Protect against possible warning in git_commitdiff
Date: Sat, 18 Nov 2006 23:38:42 +0100
Organization: At home
Message-ID: <ejo1uq$40s$1@sea.gmane.org>
References: <1163889342877-git-send-email-jnareb@gmail.com> <11638893431855-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 18 Nov 2006 22:37:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 7
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31810>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlYoS-0002QR-U2 for gcvg-git@gmane.org; Sat, 18 Nov
 2006 23:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755279AbWKRWhZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 17:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755331AbWKRWhZ
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 17:37:25 -0500
Received: from main.gmane.org ([80.91.229.2]:44771 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1755279AbWKRWhZ (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 17:37:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GlYoO-0002Px-9k for git@vger.kernel.org; Sat, 18 Nov 2006 23:37:24 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 18 Nov 2006 23:37:24 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 18 Nov 2006
 23:37:24 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Possible _undefined value_ warning.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

