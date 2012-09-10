From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] gitcli: formatting fix
Date: Mon, 10 Sep 2012 12:53:59 -0700
Message-ID: <1347306840-14007-1-git-send-email-gitster@pobox.com>
References: <7vhar5oemu.fsf@alter.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 10 21:54:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBA3k-0000CU-23
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 21:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822Ab2IJTyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 15:54:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50229 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755849Ab2IJTyC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 15:54:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CA579F85;
	Mon, 10 Sep 2012 15:54:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=30Kt
	fr0dCb7XY9+/Majv2CggPAI=; b=KIZv+vtUctDuNRzsb2v77zUDcMUflRhsICFe
	k5F3jml4nxseNf7rL+xFWkBPDDe8AAJH+k2pWaNUpCF2xrfaGbb72/1puJnry635
	VUba8HuKn0yTzm7lp2qZ9ZxZZdHC67x4lfNGYhJtCae5nOiazCbKHeo/sRcKfrEh
	OeTDpq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	VrDChJEpgi8xNHFbnm0/RuUFkyB8SoedwNbfKV64SA7rUYU9hiMktlPwwGo8vBEB
	H7bx1AsAQSD8yUFXzNKlQ4rqz21xhAHBi5Zqr8hSeSrVqPaUCfAnLhRXf2QgjAIm
	SWHQr/ML6svRVd28tZ5WH8qFsIKRJTAo9DY0sWhbIeg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CD9C9F84;
	Mon, 10 Sep 2012 15:54:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A3E49F83; Mon, 10 Sep 2012
 15:54:01 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.322.g2c7d289
In-Reply-To: <7vhar5oemu.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 446B9032-FB81-11E1-ABCE-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205166>

The paragraph to encourage use of "--" in scripts belongs to the
bullet point that describes the behaviour for a command line without
the explicit "--" disambiguation, not a supporting explanation for
the entire bulletted list.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitcli.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index ea17f7a..c4edf04 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -37,7 +37,7 @@ arguments.  Here are the rules:
    file called HEAD in your work tree, `git diff HEAD` is ambiguous, and
    you have to say either `git diff HEAD --` or `git diff -- HEAD` to
    disambiguate.
-
++
 When writing a script that is expected to handle random user-input, it is
 a good practice to make it explicit which arguments are which by placing
 disambiguating `--` at appropriate places.
-- 
1.7.12.322.g2c7d289
