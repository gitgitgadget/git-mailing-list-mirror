X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_05,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Raimund Bauer" <ray@softwarelandschaft.com>
Subject: RE: [PATCH] git-explain
Date: Tue, 5 Dec 2006 10:11:30 +0100
Organization: Softwarelandschaft
Message-ID: <001b01c7184d$5d142c20$0b0aa8c0@abf.local>
References: <7v1wnekh6a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 09:12:15 +0000 (UTC)
Cc: <git@vger.kernel.org>, "'Linus Torvalds'" <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <7v1wnekh6a.fsf@assigned-by-dhcp.cox.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Importance: Normal
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33326>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrWLT-0007dm-Qu for gcvg-git@gmane.org; Tue, 05 Dec
 2006 10:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968137AbWLEJMI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 04:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968138AbWLEJMI
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 04:12:08 -0500
Received: from s15211414.onlinehome-server.info ([87.106.16.196]:44942 "EHLO
 s15211414.onlinehome-server.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S968137AbWLEJMF (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5
 Dec 2006 04:12:05 -0500
Received: (qmail 18995 invoked from network); 5 Dec 2006 10:13:08 +0100
Received: from host-62-245-155-90.customer.m-online.net (HELO swl011)
 (62.245.155.90) by s15211414.onlinehome-server.info with SMTP; 5 Dec 2006
 10:13:08 +0100
To: "'Junio C Hamano'" <junkio@cox.net>, "'J. Bruce Fields'"
 <bfields@fieldses.org>, "'Nicolas Pitre'" <nico@cam.org>
Sender: git-owner@vger.kernel.org

> An issue with this approach is that this can be the beginning 
> of hardwiring the official "right way of doing things" in the 
> set of tools.  Pursuing this approach would enhance the set 
> of state markers like "FAILED_MERGE" in the example, which means:

Wouldn't it be better to create some kind of action-log (that's
cleared at the end of the command if everything was all right)
instead of creating special markers for different commands?

That way there would be only 1 place to check for what happened ...

-- 
best regards

  Ray
