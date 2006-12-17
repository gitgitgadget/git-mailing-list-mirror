X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-diff: don't add trailing blanks (i.e., do what GNU
 diff -u now does)
Date: Sun, 17 Dec 2006 12:00:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612171200290.3479@woody.osdl.org>
References: <87y7p6nwsh.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 17 Dec 2006 20:01:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87y7p6nwsh.fsf@rho.meyering.net>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34705>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw2CB-0003NJ-Rh for gcvg-git@gmane.org; Sun, 17 Dec
 2006 21:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751078AbWLQUBN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 15:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWLQUBN
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 15:01:13 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55722 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751078AbWLQUBM
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006 15:01:12 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBHK15ID005833
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 17
 Dec 2006 12:01:05 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBHK0x84017726; Sun, 17 Dec
 2006 12:01:02 -0800
To: Jim Meyering <jim@meyering.net>
Sender: git-owner@vger.kernel.org



On Sun, 17 Dec 2006, Jim Meyering wrote:
>
> You may recall that GNU diff -u changed recently so that it no
> longer outputs any trailing space unless the input data has it.

I still consider that to be a bug in GNU "diff -u".

We work around that bug when applying patches, but I don't think we should 
replicate it.

