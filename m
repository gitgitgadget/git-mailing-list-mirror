From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 16/23] fetch-options.txt: simplify ifdef/ifndef/endif usage
Date: Wed, 30 Oct 2013 06:33:05 +0100
Message-ID: <1383111192-23780-17-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:41:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOXI-0007RQ-RW
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013Ab3J3Flk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:41:40 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49291 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752985Ab3J3Flj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:41:39 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2013 01:41:39 EDT
X-AuditID: 12074411-b7f426d000005455-5d-52709a65b802
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id BE.CA.21589.56A90725; Wed, 30 Oct 2013 01:34:29 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIR014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:34:27 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqJs6qyDI4NFFDYvpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE7487qwIL/rBV9Kw6zNDC2s3YxcnJICJhInD7xhxHCFpO4cG89G4gtJHCZUWL+W6suRi4g
	+wqTxJaOuUwgCTYBXYlFPc1gtoiAmsTEtkMsIEXMAhOZJY5PX8QCkhAW8JNYc6AFbAOLgKrE
	wtVP2UFsXgFXiWuHJ0NtVpC40TwVzOYEin/adZMdYrOLRFP7Z/YJjLwLGBlWMcol5pTm6uYm
	ZuYUpybrFicn5uWlFuma6uVmluilppRuYoQEreAOxhkn5Q4xCnAwKvHwGjzIDxJiTSwrrsw9
	xCjJwaQkyps2pSBIiC8pP6UyI7E4I76oNCe1+BCjBAezkgjv9ONA5bwpiZVVqUX5MClpDhYl
	cV6+Jep+QgLpiSWp2ampBalFMFkZDg4lCV7lmUBDBYtS01Mr0jJzShDSTBycIIILZAMP0AYe
	kELe4oLE3OLMdIiiU4yKUuK8CiAJAZBERmke3ABYennFKA70jzBEOw8wNcF1vwIazAQ0eA9L
	HsjgkkSElFQD48x/535/fL9CL6Nq40O9GkMtLYH1MTP2Odj8iVvv/uJ7WALbSebD1buz/zmr
	fTKZKf9DP+q9bgfnR73Ma5H3Pk9v73s1/ZeY0jybkli212eOlTs4HvlSeStKoPvu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236972>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/fetch-options.txt | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 12b1d92..f0ef7d0 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -51,13 +51,10 @@ ifndef::git-pull[]
 	subject to pruning.
 endif::git-pull[]
 
-ifdef::git-pull[]
---no-tags::
-endif::git-pull[]
 ifndef::git-pull[]
 -n::
---no-tags::
 endif::git-pull[]
+--no-tags::
 	By default, tags that point at objects that are downloaded
 	from the remote repository are fetched and stored locally.
 	This option disables this automatic tag following. The default
-- 
1.8.4.1
