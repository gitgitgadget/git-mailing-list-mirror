From: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] Documentation/config: fix inconsistent label
Date: Fri, 21 Aug 2015 17:06:18 +0200
Message-ID: <87lhd4wuj9.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 17:06:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSntj-0000ZW-Fr
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 17:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbbHUPGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 11:06:23 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:56414 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbbHUPGW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 11:06:22 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3myR4r3J0lz3hhvk
	for <git@vger.kernel.org>; Fri, 21 Aug 2015 17:06:20 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3myR4r2v4WzvktY
	for <git@vger.kernel.org>; Fri, 21 Aug 2015 17:06:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id lM2hLxpoZT7A for <git@vger.kernel.org>;
	Fri, 21 Aug 2015 17:06:19 +0200 (CEST)
X-Auth-Info: cHExmxLj20NhG837OO6BbKEQ8LTnvwS5YwoSLGNIZWUfVoFICMQokEEeoCWrT+dP
Received: from igel.home (ppp-93-104-63-89.dynamic.mnet-online.de [93.104.63.89])
	by mail.mnet-online.de (Postfix) with ESMTPA
	for <git@vger.kernel.org>; Fri, 21 Aug 2015 17:06:19 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id F32612C4487; Fri, 21 Aug 2015 17:06:18 +0200 (CEST)
X-Yow: Two LITTLE black dots and one BIG black dot...nice 'n' FLUFFY!!
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276304>

Change <ref> to <pattern> in the description of
gc.*.reflogExpireUnreachable, since that is what the text refers to.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 75ec02e..b4f7c46 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1329,7 +1329,7 @@ gc.<pattern>.reflogExpire::
 	the refs that match the <pattern>.
 
 gc.reflogExpireUnreachable::
-gc.<ref>.reflogExpireUnreachable::
+gc.<pattern>.reflogExpireUnreachable::
 	'git reflog expire' removes reflog entries older than
 	this time and are not reachable from the current tip;
 	defaults to 30 days. The value "now" expires all entries
-- 
2.5.0

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
