X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: git-PS1 bash prompt setting
Date: Sun, 26 Nov 2006 09:42:12 -0500
Message-ID: <BAYC1-PASMTP0478559E108A91E0F2A038AEE70@CEZ.ICE>
References: <BAYC1-PASMTP037FDA6C6465F0541AC613AEE90@CEZ.ICE>
	<Pine.LNX.4.63.0611261524130.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 14:42:36 +0000 (UTC)
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061126094212.fde8cce7.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0611261524130.30004@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 26 Nov 2006 14:42:14.0065 (UTC) FILETIME=[0FFA5210:01C71169]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoLD0-0005P5-Mr for gcvg-git@gmane.org; Sun, 26 Nov
 2006 15:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935390AbWKZOmP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 09:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935424AbWKZOmP
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 09:42:15 -0500
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:31766 "EHLO
 BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S935390AbWKZOmO (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006
 09:42:14 -0500
Received: from linux1.attic.local ([65.93.43.74]) by
 BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Sun, 26 Nov 2006 06:42:13 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GoKGo-0004zJ-V4; Sun, 26 Nov 2006 08:42:11 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Sun, 26 Nov 2006 15:27:07 +0100 (CET)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> But there really is no good place to put it: most commands need a git 
> repository, and those which do not, are inappropriate to put an option 
> "--show-ps1" into. Except maybe repo-config. Thoughts?

What about just making it an option to the git wrapper?

