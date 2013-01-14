From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/6] cvsimport-3: add a sample test
Date: Sun, 13 Jan 2013 23:25:51 -0800
Message-ID: <1358148351-31552-7-git-send-email-gitster@pobox.com>
References: <7v8v7wiv3a.fsf@alter.siamese.dyndns.org>
 <1358148351-31552-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 08:26:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TueRC-0002XD-Rv
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 08:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755729Ab3ANH0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 02:26:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61431 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755911Ab3ANH0I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 02:26:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E30DB8CF
	for <git@vger.kernel.org>; Mon, 14 Jan 2013 02:26:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6X/O
	m6dKktmkyjrrGwNb6qikNFU=; b=K9UR/L1ua/4azj7xqPTeKCi5kb91fJIpAH4b
	29I+icdfn0a+9na5fL28zTt1Va6Y1cdcBS+WVrXfm9AI+0/yWq5QYn3bfeRGQI5d
	0EmDAm02ufh363/LwGkR7T6dW0/7qgvHttEibY6F1q9yd8jOgPLgkMJnEPjPT8zd
	AzvusCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=uP7KjI
	8iVdN8Txuqq2I/rWlwhFry6iGftXvwjPmDoMRCquhf63IbRLsXWXzT5ItH1ag06D
	zLYFL+XsfcF3jk7HDdOfeny/w2qUqeYaZW30RfrUPhZC4tm4pZBViBljbPuvXQ1n
	LiaJxlkMVjbFSGbnzwXnJWeDUBCCgv/bU3hqg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62B1EB8CD
	for <git@vger.kernel.org>; Mon, 14 Jan 2013 02:26:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFF69B8CB for
 <git@vger.kernel.org>; Mon, 14 Jan 2013 02:26:06 -0500 (EST)
X-Mailer: git-send-email 1.8.1.421.g6236851
In-Reply-To: <1358148351-31552-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A9220A5E-5E1B-11E2-919B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213462>

This is primarily for illustration to show how the support
introduced by the previous step can be used.

Some parts of t9600 needs to be made conditional to the value of
TEST_CVSPS_VERSION to avoid passing options the new cvsimport does
not need or understand, before this can become usable as a real
test.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9650-cvsimport3.sh | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100755 t/t9650-cvsimport3.sh

diff --git a/t/t9650-cvsimport3.sh b/t/t9650-cvsimport3.sh
new file mode 100755
index 0000000..f7ca986
--- /dev/null
+++ b/t/t9650-cvsimport3.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+
+TEST_CVSPS_VERSION=3
+. ./t9600-cvsimport.sh
-- 
1.8.1.421.g6236851
