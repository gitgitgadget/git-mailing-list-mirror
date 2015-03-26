From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH] Fix two typos
Date: Thu, 26 Mar 2015 21:29:47 +0100 (CET)
Message-ID: <431731492.918875.1427401787310.JavaMail.ngmail@webmail10.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 21:29:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbEPa-0005MD-57
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 21:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbbCZU3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 16:29:50 -0400
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:50737 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752298AbbCZU3t (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2015 16:29:49 -0400
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mx.arcor.de (Postfix) with ESMTP id 3lCdGM2S4wzFBs;
	Thu, 26 Mar 2015 21:29:47 +0100 (CET)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 51F423C58D8;
	Thu, 26 Mar 2015 21:29:47 +0100 (CET)
Received: from webmail10.arcor-online.net (webmail10.arcor-online.net [151.189.8.93])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 3lCdGM2G77z87Pw;
	Thu, 26 Mar 2015 21:29:47 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-07.arcor-online.net 3lCdGM2G77z87Pw
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1427401787; bh=IvhPAEN674n939v5pb5iDxvwCAzurP1cOEpuSK6MNxk=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=F1BANCwwLpg3C4jQiAGLI1CmmjLLM8qaBy9iSDh17Ts/9ORpzyUt7FqbXcb1xb9Qq
	 bTTp/SwpgdmsU7lr2LxtWwIljxIc7TcLsd4limxLMnPEvtX0xsbXBMACCtZd2fbAYr
	 Ip//e9PTdpYWxEYbQ2XYwbPxPE8Rto8coh/JzyXo=
Received: from [188.98.232.65] by webmail10.arcor-online.net (151.189.8.93) with HTTP (Arcor Webmail); Thu, 26 Mar 2015 21:29:47 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.232.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266346>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/RelNotes/2.4.0.txt               | 2 +-
 Documentation/technical/api-error-handling.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.4.0.txt b/Documentation/RelNotes/2.4.0.txt
index 386c75d..cdfd578 100644
--- a/Documentation/RelNotes/2.4.0.txt
+++ b/Documentation/RelNotes/2.4.0.txt
@@ -296,7 +296,7 @@ notes for details).
    (merge 35840a3 jc/conf-var-doc later to maint).
 
  * An earlier workaround to squelch unhelpful deprecation warnings
-   from the complier on Mac OSX unnecessarily set minimum required
+   from the compiler on Mac OSX unnecessarily set minimum required
    version of the OS, which the user might want to raise (or lower)
    for other reasons.
    (merge 88c03eb es/squelch-openssl-warnings-on-macosx later to maint).
diff --git a/Documentation/technical/api-error-handling.txt b/Documentation/technical/api-error-handling.txt
index fc68db1..ceeedd4 100644
--- a/Documentation/technical/api-error-handling.txt
+++ b/Documentation/technical/api-error-handling.txt
@@ -58,7 +58,7 @@ to `die` or `error` as-is.  For example:
 	if (ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 
-The 'err' parameter will be untouched if no error occured, so multiple
+The 'err' parameter will be untouched if no error occurred, so multiple
 function calls can be chained:
 
 	t = ref_transaction_begin(&err);
-- 
1.9.5.msysgit.0
