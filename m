X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Question on rerere
Date: Wed, 20 Dec 2006 00:53:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612200045490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 19 Dec 2006 23:53:57 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34864>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwomL-0004o6-HN for gcvg-git@gmane.org; Wed, 20 Dec
 2006 00:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751949AbWLSXxl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 18:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbWLSXxl
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 18:53:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:35055 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1752420AbWLSXxl
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 18:53:41 -0500
Received: (qmail invoked by alias); 19 Dec 2006 23:53:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp039) with SMTP; 20 Dec 2006 00:53:39 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

while studying the code of rerere I found myself wondering if the code of 
compute_conflict_name and record_preimage is correct.

IIUC then each conflict hunk is handled _separately_ like this: the 
lexicographically smaller between the two file sections is displayed 
first, regardless if a previous hunk had a different order. Not that it 
matters most of the time, but isn't this dangerous?

Ciao,
Dscho
