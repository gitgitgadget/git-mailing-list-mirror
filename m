From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] stash: suggest the correct command line for unknown options.
Date: Fri,  5 Mar 2010 19:43:23 +0100
Message-ID: <1267814603-26158-1-git-send-email-Matthieu.Moy@imag.fr>
References: <20100305170841.GA9325@coredump.intra.peff.net>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com,
	Thomas Singer <thomas.singer@syntevo.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 05 19:44:13 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NncVP-0005w1-GJ
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 19:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738Ab0CESoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 13:44:06 -0500
Received: from mx2.imag.fr ([129.88.30.17]:39159 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754151Ab0CESoE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 13:44:04 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o25IeX6g019735
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 5 Mar 2010 19:40:34 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NncUh-0005Fk-Ax; Fri, 05 Mar 2010 19:43:27 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NncUh-0006oS-9v; Fri, 05 Mar 2010 19:43:27 +0100
X-Mailer: git-send-email 1.7.0.231.g9fa6.dirty
In-Reply-To: <20100305170841.GA9325@coredump.intra.peff.net>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 05 Mar 2010 19:40:35 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o25IeX6g019735
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1268419238.26317@jSIpZlixqltpiPv7QydwZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141594>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Oups, as noticed by peff, my proposed command was wrong ...

 git-stash.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 2d69196..aa47e54 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -151,6 +151,7 @@ save_stash () {
 			;;
 		-*)
 			echo "error: unknown option for 'stash save': $1"
+			echo "       To provide a message, use git stash save -- '$1'"
 			usage
 			;;
 		*)
-- 
1.7.0.231.g9fa6.dirty
