X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] [Makefile] Export PERL_PATH
Date: Thu, 14 Dec 2006 23:03:03 -0800 (PST)
Message-ID: <456787.73540.qm@web31801.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 15 Dec 2006 07:09:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 02:09:43 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=tgOHMZdp0IRttGLy9Gkux+vjH6v+QWTHmqektGFUZNlnrGTHvoZjrtMiYGX+wWKi4zY48SQ6m7xsXDequjF5O+L/4OPAGDnBxhWUfBub7tI6JtodhOwIXjYAXDIMKtnhpv+zpRvr6hI0pFVsnQ/KLf/w4o/Pps0cvKJhHsnyP8c=;
X-YMail-OSG: bVO3bFwVM1mQshcnayoffs2rvtP1x7PZqKRza434ndpF1tOF96Y6DgPb8v2eOEtBEom9ZWELNZZ10NfBffXD23x0e.mImUe23QiPzIIVs9PVm9s7iPDbtuD3bqv5_CNOa4Nx3dqdiQkGq24-
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34473>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv7CX-00005Z-TL for gcvg-git@gmane.org; Fri, 15 Dec
 2006 08:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751187AbWLOHJo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 02:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWLOHJo
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 02:09:44 -0500
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:31903 "HELO
 web31801.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 SMTP id S1751187AbWLOHJn (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 02:09:43 -0500
Received: (qmail 75318 invoked by uid 60001); 15 Dec 2006 07:03:03 -0000
Received: from [71.84.31.214] by web31801.mail.mud.yahoo.com via HTTP; Thu,
 14 Dec 2006 23:03:03 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

PERL_PATH is used by perl/Makefile so export it.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 6a86132..f016982 100644
--- a/Makefile
+++ b/Makefile
@@ -227,6 +227,8 @@ ifndef PERL_PATH
 	PERL_PATH = /usr/bin/perl
 endif
 
+export PERL_PATH
+
 LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a
 
-- 
1.4.4.2.g9bf39

