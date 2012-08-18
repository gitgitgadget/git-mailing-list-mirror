From: mhagger@alum.mit.edu
Subject: [PATCH 1/2] git-config.txt: properly escape quotation marks in example
Date: Sat, 18 Aug 2012 19:32:09 +0200
Message-ID: <1345311130-20426-2-git-send-email-mhagger@alum.mit.edu>
References: <1345311130-20426-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 19:39:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2mzw-0003kL-I3
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 19:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758Ab2HRRjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 13:39:39 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:42535 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751379Ab2HRRjh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Aug 2012 13:39:37 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Aug 2012 13:39:37 EDT
X-AuditID: 12074411-b7fa36d0000008cc-67-502fd1b27302
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 69.11.02252.2B1DF205; Sat, 18 Aug 2012 13:32:34 -0400 (EDT)
Received: from michael.fritz.box (p57A25507.dip.t-dialin.net [87.162.85.7])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7IHWF9q002696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 18 Aug 2012 13:32:33 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345311130-20426-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsUixO6iqLvpon6AwYXDmhZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ1xZVo3c8FtjopDfdNYGxi7
	2bsYOTkkBEwkbu7uZYOwxSQu3FsPZHNxCAlcZpTo33KbsYuRA8g5zSRxUhykhk1ASuJlYw9Y
	r4iAmsTEtkMsIDazgIPE5s+NjCC2sIC/xNxPe8BmsgioSuzrmgJWwyvgInF791GoXYoSP76v
	YQaxOQVcJVpOb2eGWOUi8fuOwQRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE31cjNL
	9FJTSjcxQsJEcAfjjJNyhxgFOBiVeHgV1+gFCLEmlhVX5h5ilORgUhLlfX9GP0CILyk/pTIj
	sTgjvqg0J7X4EKMEB7OSCK/uCaBy3pTEyqrUonyYlDQHi5I4L98SdT8hgfTEktTs1NSC1CKY
	rAwHh5IE744LQEMFi1LTUyvSMnNKENJMHJwgggtkAw/QBgZghAnxFhck5hZnpkMUnWJUlBLn
	3QYyQQAkkVGaBzcAFtGvGMWB/hHmvQpSxQNMBnDdr4AGMwENXimiCzK4JBEhJdXAGDG7Ze0J
	+8CuDb+2Ld0de03tWta83b0bb8zU3/zJf6rRcb5yrcwks2yH9bLPL3n61RuLpyd4TLyRW6+5
	oblN+AKfkMSTzT87Ehbw25YeKJn57UpFppjPobrgxn0sxgeOywqqH5kTkBS7YckRyyVFtdeq
	FX/asTZnq71PeWO+tC5mdtD0xXe4lViKMxINtZiLihMBxPY4h8MCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203682>

From: Michael Haggerty <mhagger@alum.mit.edu>

In the example line as written,

        gitproxy="proxy-command" for kernel.org

the quotation marks are eaten by the config-file parser.  From the
history, it looks like this example wanted to have quotation marks in
the actual configured value.  So quote them as required nowadays.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

The bigger question is whether this example is improved by including
quotation marks, or whether they are just a distraction from the main
point.  I abstain.

 Documentation/git-config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 2d6ef32..46775fe 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -267,7 +267,7 @@ Given a .git/config like this:
 
 	; Proxy settings
 	[core]
-		gitproxy="proxy-command" for kernel.org
+		gitproxy=\"proxy-command\" for kernel.org
 		gitproxy=default-proxy ; for all the rest
 
 you can set the filemode to true with
-- 
1.7.11.3
