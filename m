From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: [PATCH] imap-send: Remove unused 'use_namespace' variable
Date: Wed, 23 Nov 2011 21:32:37 +0100
Message-ID: <4ECD5865.4080908@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 21:36:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTJY0-0008Uf-Qh
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 21:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395Ab1KWUf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 15:35:56 -0500
Received: from re04.intra2net.com ([82.165.46.26]:55767 "EHLO
	re04.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092Ab1KWUfz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 15:35:55 -0500
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by re04.intra2net.com (Postfix) with ESMTP id A67543013A
	for <git@vger.kernel.org>; Wed, 23 Nov 2011 21:35:54 +0100 (CET)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id 6E6412AC54
	for <git@vger.kernel.org>; Wed, 23 Nov 2011 21:35:54 +0100 (CET)
X-Virus-Scanned: by Intranator (www.intra2net.com) with AMaViS and F-Secure
	AntiVirus (fsavdb 2011-11-23_08)
X-Spam-Status: 
X-Spam-Level: 0
Received: from pikkukde.a.i2n (unknown [192.168.12.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTPS id 9FF952AC53
	for <git@vger.kernel.org>; Wed, 23 Nov 2011 21:35:52 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111115 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185871>

Reported by cppcheck

Signed-off-by: Thomas Jarosch <thomas.jarosch@intra2net.com>
---
 imap-send.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index e1ad1a4..80e0e8c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -161,7 +161,6 @@ static struct imap_server_conf server = {
 struct imap_store_conf {
 	struct store_conf gen;
 	struct imap_server_conf *server;
-	unsigned use_namespace:1;
 };
 
 #define NIL	(void *)0x1
-- 
1.7.6.4
