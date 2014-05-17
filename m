From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH] Documentation/technical/api-hashmap: Remove source
 highlighting
Date: Sat, 17 May 2014 07:08:55 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1405170707260.44324@all-night-tool.MIT.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	745591@bugs.debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 13:09:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlcUE-00057F-PJ
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 13:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbaEQLJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 07:09:01 -0400
Received: from dmz-mailsec-scanner-5.mit.edu ([18.7.68.34]:61443 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932279AbaEQLJA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 May 2014 07:09:00 -0400
X-AuditID: 12074422-f79376d000000c58-cd-5377434b2ba2
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	(using TLS with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by dmz-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id D4.B1.03160.B4347735; Sat, 17 May 2014 07:08:59 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id s4HB8vOJ008214;
	Sat, 17 May 2014 07:08:58 -0400
Received: from localhost (all-night-tool.mit.edu [18.9.64.12])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id s4HB8t4o009856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 17 May 2014 07:08:56 -0400
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixG6nouvtXB5ssLVf3OLK3AKLrivdTBYN
	vVeYLd7eXMLowOJxYeskFo+ds+6ye1y8pOzxeZNcAEsUl01Kak5mWWqRvl0CV8bLh39ZC/rZ
	Kia/WsLYwDiHtYuRk0NCwETiyfJ1jBC2mMSFe+vZuhi5OIQEZjNJNFx7wgySEBLYyCixqS0U
	IrGbSWLTj51sIAkWAW2JG12PwGw2ATWJuRsms4PYIkD2xLZDLCA2s0CcxIsD/8BsYYEgidbn
	78G28Qp4SCy/sRSsV1RAV2JzN4TNKyAocXLmE6heLYnl07exTGDkm4UkNQtJagEj0ypG2ZTc
	Kt3cxMyc4tRk3eLkxLy81CJdU73czBK91JTSTYzgEHRR2sH486DSIUYBDkYlHl4O27JgIdbE
	suLK3EOMkhxMSqK8e74DhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwHrYvDxbiTUmsrEotyodJ
	SXOwKInzvrW2ChYSSE8sSc1OTS1ILYLJynBwKEnwBjsBNQoWpaanVqRl5pQgpJk4OEGG8wAN
	lwOp4S0uSMwtzkyHyJ9iVJQS513mCJQQAElklObB9cJSxCtGcaBXhHlVQdp5gOkFrvsV0GAm
	oMFv9paCDC5JREhJNTDytMS0iJ5g6t/26IHUoiqhjb9V3hYUvdU72TZ5lvYHxt+Lsk32HgjO
	erlT5ou2Ke+Oind/uE98rrscuzz24nm2XRGu8luenUvvlJ+hcPzlu8nsu5841i63vytXp2Zj
	o9Mj90/79u5va7iPydSdsD+g+cX6nN/cV0mv7xWLsh01EVYJz3H+kWusxFKckWio 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249463>

The highlighting was pretty, but unfortunately, the failure mode when
source-highlight is not installed was that the entire code block
disappears.  See https://bugs.debian.org/745591,
https://bugs.launchpad.net/bugs/1316810.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 Documentation/technical/api-hashmap.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
index 42ca234..b977ae8 100644
--- a/Documentation/technical/api-hashmap.txt
+++ b/Documentation/technical/api-hashmap.txt
@@ -166,7 +166,6 @@ Usage example
 -------------
 
 Here's a simple usage example that maps long keys to double values.
-[source,c]
 ------------
 struct hashmap map;
 
-- 
2.0.0.rc3
