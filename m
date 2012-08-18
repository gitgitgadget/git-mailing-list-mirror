From: mhagger@alum.mit.edu
Subject: [PATCH 2/2] git-config.txt: fix example
Date: Sat, 18 Aug 2012 19:32:10 +0200
Message-ID: <1345311130-20426-3-git-send-email-mhagger@alum.mit.edu>
References: <1345311130-20426-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 19:39:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2n07-0003tR-Nq
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 19:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236Ab2HRRjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 13:39:48 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:49802 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751379Ab2HRRjj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Aug 2012 13:39:39 -0400
X-AuditID: 12074414-b7f846d0000008b8-eb-502fd1b4b0a7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 4A.B2.02232.4B1DF205; Sat, 18 Aug 2012 13:32:36 -0400 (EDT)
Received: from michael.fritz.box (p57A25507.dip.t-dialin.net [87.162.85.7])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7IHWF9r002696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 18 Aug 2012 13:32:36 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345311130-20426-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqLvlon6Awa3n1hZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ3RPHsdc8E7topFbzYwNzDe
	Ye1i5OSQEDCROHz7OBOELSZx4d56ti5GLg4hgcuMEmv2/mSGcE4zSay795YZpIpNQEriZWMP
	O4gtIqAmMbHtEAuIzSzgILH5cyMjiC0sYCCx4c0cMJtFQFXi8f2JYBt4BVwklu7YwQaxTVHi
	x/c1YDM5BVwlWk5vB7I5gJa5SPy+YzCBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0L
	vdzMEr3UlNJNjJBQEdnBeOSk3CFGAQ5GJR5ehTV6AUKsiWXFlbmHGCU5mJREed+f0Q8Q4kvK
	T6nMSCzOiC8qzUktPsQowcGsJMKrewKonDclsbIqtSgfJiXNwaIkzvttsbqfkEB6Yklqdmpq
	QWoRTFaGg0NJgvf7BaChgkWp6akVaZk5JQhpJg5OEMEFsoEHaAMDMMqEeIsLEnOLM9Mhik4x
	KkqJ824DmSAAksgozYMbAIvqV4ziQP8I814FqeIBJgS47ldAg5mABq8U0QUZXJKIkJJqYJSu
	nJn6JeQ3z/4fr3/Jzec58v7NYo1Mz/k3j+35nZjT/PvS3ZeFk71Vk76XTPvdYi7GvO61gkpA
	l6OE7b15l1Yc2vvT8EC9XJrzbeF/uefmxGQ5Hn/oYsD4NuTvoUAZwYMWgXGHDu+aVHiuPO3S
	p4rP8pcMnT+vFJl7qaqOY45GY+B5totiN2YosRRnJBpqMRcVJwIArvIKNsUCAAA= 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203683>

From: Michael Haggerty <mhagger@alum.mit.edu>

The "--add" option is required to add a new value to a multivalued
configuration entry.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 46775fe..584ef51 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -342,7 +342,7 @@ To actually match only values with an exclamation mark, you have to
 To add a new proxy, without altering any of the existing ones, use
 
 ------------
-% git config core.gitproxy '"proxy-command" for example.com'
+% git config --add core.gitproxy '"proxy-command" for example.com'
 ------------
 
 An example to use customized color from the configuration in your
-- 
1.7.11.3
