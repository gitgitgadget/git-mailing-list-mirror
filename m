X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,BODY_URI_ONLY,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Serge van den Boom <svdb@stack.nl>
Subject: LDFLAGS ignored from the environment
Date: Sat, 11 Nov 2006 16:33:09 +0100 (CET)
Message-ID: <20061111160630.N39296@frog.stack.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
NNTP-Posting-Date: Sat, 11 Nov 2006 15:33:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31231>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Giur6-0001L4-EH for gcvg-git@gmane.org; Sat, 11 Nov
 2006 16:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424017AbWKKPdN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006
 10:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424018AbWKKPdM
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 10:33:12 -0500
Received: from vaak-mk4.stack.nl ([131.155.140.160]:13815 "EHLO
 vaak-mk4.stack.nl") by vger.kernel.org with ESMTP id S1424017AbWKKPdL (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 10:33:11 -0500
Received: from frog.stack.nl (frog.stack.nl [IPv6:2001:610:1108:5010::136])
 by vaak-mk4.stack.nl (Postfix) with ESMTP id 8C6F3B8E1 for
 <git@vger.kernel.org>; Sat, 11 Nov 2006 16:33:09 +0100 (CET)
Received: by frog.stack.nl (Postfix, from userid 1106) id 7AF7160EE; Sat, 11
 Nov 2006 16:33:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by frog.stack.nl (Postfix)
 with ESMTP id 6DF8160E1 for <git@vger.kernel.org>; Sat, 11 Nov 2006 16:33:09
 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

GIT's configure ignores LDFLAGS in the environment.
To solve the issue, add
 	LDFLAGS = @LDFLAGS@
to config.mak.in
