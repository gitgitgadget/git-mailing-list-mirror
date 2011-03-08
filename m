From: Alexei Sholik <alcosholik@gmail.com>
Subject: [PATCH 1/2] Documentation: remove redundant colons in git-for-each-ref.txt
Date: Tue,  8 Mar 2011 15:16:09 +0200
Message-ID: <1299590170-30799-2-git-send-email-alcosholik@gmail.com>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
Cc: Alexei Sholik <alcosholik@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 14:13:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwwjd-0006ud-Kx
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 14:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab1CHNNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 08:13:47 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34391 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589Ab1CHNNq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 08:13:46 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so4543793bwz.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 05:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=WQdxDXj6VEPxf+18X6H4aZo97znJ51YiT5US+o42NVw=;
        b=ZAXptEeKBbf3EGbEhpWRdI+0mIUvCGvjxO6sG9zM1l3cxjJ0WcefPp1IgRNtDQznrt
         +lihxlH4LW6jfkqXwMSRG2RJnbUI+rB76dw4JXjCFYV3jkMeAQntiNP4cyHz/uJZzg82
         opxAd10Ibd5kkGV5NttqXnK/zkAX+Ki7WPLiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sask6DeCMH7xyJT70/YPTlmz5Lsq9uX7WsbBITrT+BtJyfJ05ddLLE9xZM1Gazy2SY
         1wv78BDCpt+/i+y7EsVYrIC7oRUgXWkHC+rI0wleewnnkER3aLibw4fbiq1oTsRgVbQn
         9thWOobP5kyrn7lOm5af1JZlsFqrCAzNsL9VU=
Received: by 10.204.20.74 with SMTP id e10mr4490148bkb.148.1299590025796;
        Tue, 08 Mar 2011 05:13:45 -0800 (PST)
Received: from localhost.localdomain ([193.254.233.10])
        by mx.google.com with ESMTPS id u23sm495968bkw.9.2011.03.08.05.13.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Mar 2011 05:13:45 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168661>

Signed-off-by: Alexei Sholik <alcosholik@gmail.com>
---
 Documentation/git-for-each-ref.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index fac1cf5..bffb5d2 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -123,7 +123,7 @@ EXAMPLES
 --------
 
 An example directly producing formatted text.  Show the most recent
-3 tagged commits::
+3 tagged commits:
 
 ------------
 #!/bin/sh
@@ -140,7 +140,7 @@ Ref: %(*refname)
 
 
 A simple example showing the use of shell eval on the output,
-demonstrating the use of --shell.  List the prefixes of all heads::
+demonstrating the use of --shell.  List the prefixes of all heads:
 ------------
 #!/bin/sh
 
@@ -154,7 +154,7 @@ done
 
 
 A bit more elaborate report on tags, demonstrating that the format
-may be an entire script::
+may be an entire script:
 ------------
 #!/bin/sh
 
-- 
1.7.2.3
