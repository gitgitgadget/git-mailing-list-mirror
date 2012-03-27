From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH] documentation: fix alphabetic ordered list for git-rebase
 man page
Date: Tue, 27 Mar 2012 12:40:52 +0200
Message-ID: <4F719934.1050500@seap.minhap.es>
References: <4F6C5F1B.6010603@seap.minhap.es><7vd383t8vp.fsf@alter.siamese.dyndns.org> <4F7059B7.8080406@op5.se> <7vwr67p8sw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 11:43:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCSvs-0004ON-Jm
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 11:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757892Ab2C0JnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 05:43:11 -0400
Received: from luthien2.map.es ([213.9.211.102]:50603 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752069Ab2C0JnK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 05:43:10 -0400
Received: from correo.map.es (unknown [10.1.31.23])
	by luthien2.map.es (Postfix) with ESMTP id 09DABF84FE;
	Tue, 27 Mar 2012 11:43:01 +0200 (CEST)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 435B8203910;
	Tue, 27 Mar 2012 11:42:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <7vwr67p8sw.fsf@alter.siamese.dyndns.org>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 09DABF84FE.3EDD2
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1333446181.79055@EzHi25ZmnWLFESG826NNtA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194034>

An alphabetic ordered list (a.) is converted to numerical in
the man page (1.) so context comments naming 'a' were confusing,
fix that by not using ordered list notation for 'a' anb 'b' items.

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
---
Sorry for the delay and forgetting the sign-off, should have made
an alias for that, hope to keep contributing as I found things that
need to be improved. thanks!

 Documentation/git-rebase.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 504945c..520aaa9 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -409,10 +409,13 @@ The interactive mode is meant for this type of workflow:
 
 where point 2. consists of several instances of
 
-a. regular use
+a) regular use
+
  1. finish something worthy of a commit
  2. commit
-b. independent fixup
+
+b) independent fixup
+
  1. realize that something does not work
  2. fix that
  3. commit it
-- 
1.7.7.6
