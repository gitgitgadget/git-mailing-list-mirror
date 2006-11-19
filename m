X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/3] Fixes for builtin shortlog
Date: Sun, 19 Nov 2006 17:27:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611191725330.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 19 Nov 2006 16:28:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31835>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlpWS-0000lT-QN for gcvg-git@gmane.org; Sun, 19 Nov
 2006 17:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756753AbWKSQ16 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 11:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756754AbWKSQ15
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 11:27:57 -0500
Received: from mail.gmx.de ([213.165.64.20]:20698 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1756753AbWKSQ15 (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 11:27:57 -0500
Received: (qmail invoked by alias); 19 Nov 2006 16:27:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp028) with SMTP; 19 Nov 2006 17:27:55 +0100
To: junkio@cox.net, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

this series brings back support for reading .mailmap, fixes an annoying 
crash, handles the email addresses case-insensitively, and removes the 
in-built Linux specific mailmapping.

Ciao,
Dscho
