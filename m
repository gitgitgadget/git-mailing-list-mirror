X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han Boetes <han@mijncomputer.nl>
Subject: curl with ares support
Date: Sun, 10 Dec 2006 18:26:24 +0100
Message-ID: <20061210172647.GD19139@boetes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 17:27:01 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33904>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtSRy-0004W3-Q0 for gcvg-git@gmane.org; Sun, 10 Dec
 2006 18:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762276AbWLJR0w (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 12:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762277AbWLJR0w
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 12:26:52 -0500
Received: from boetes.org ([213.84.147.9]:55667 "HELO boetes.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1762276AbWLJR0v
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 12:26:51 -0500
Received: (qmail 7590 invoked by uid 1000); 10 Dec 2006 17:26:48 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

This is what my libcurl libs looks like:

~% pkg-config --libs libcurl                              
-lcurl -lcares -lidn -lssl -lcrypto -ldl -lz

But the git Makefile assumes '-lcurl' will do.

Bug identical to: https://trac.xiph.org/ticket/1092



# Han
-- 
 _/| VK                                                        |\_
// o\    Decision maker, n.: The person in your office who    /o \\
|| ._)   was unable to form a task force before the music    (_. ||
//__\                        stopped.                         /__\\
