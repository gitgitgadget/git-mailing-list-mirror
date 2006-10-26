X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Question about git-for-each-ref format
Date: Thu, 26 Oct 2006 20:12:43 +0200
Organization: At home
Message-ID: <ehqtph$lcv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 26 Oct 2006 18:12:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 9
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30254>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd9iR-00049W-IS for gcvg-git@gmane.org; Thu, 26 Oct
 2006 20:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423592AbWJZSMP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 14:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161419AbWJZSMP
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 14:12:15 -0400
Received: from main.gmane.org ([80.91.229.2]:21123 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1161436AbWJZSMO (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 14:12:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gd9i5-00046S-6S for git@vger.kernel.org; Thu, 26 Oct 2006 20:12:09 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 20:12:09 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 20:12:09 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

What kind of extra substitution besides %(field) and %% -> % gets
git-for-each-ref format? I've checked that %00 -> \0, is it generic or only
this value? It is not documented, I've remembered it from discussion on git
mailing list...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

