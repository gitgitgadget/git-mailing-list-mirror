From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/8] CodingGuidelines: give an example for case/esac statement
Date: Wed, 30 Apr 2014 14:45:06 -0700
Message-ID: <1398894312-30763-3-git-send-email-gitster@pobox.com>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 23:45:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfcJm-0004fU-BY
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 23:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759433AbaD3Vp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 17:45:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65142 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759042AbaD3Vp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 17:45:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CDB8825E0;
	Wed, 30 Apr 2014 17:45:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=eSWL
	qitEMo8s2GfzHrpctj0n2wg=; b=jwsEyhH+b+j1u4SDN+fdouTADyTzdkxJnL89
	Q1o7GpXrNcPqUx5TUFckXebEy5wRrQtUrx2QZfXhCF9BYlwfZtjpeXiTKGeStR4U
	H4yjiPOV4620QXBPE1pgvwzXGIehooqpO2TDuf5PLQd5CNRKyEzd/wuJDIXCh9/N
	b+Geh2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=W1hLoz
	wivCjO2zxdyGKQpyOnZRGRfYx/ogHxKJrTnKexodlNnLXPP7d+RhefmPcMwb4ujc
	9emp1Iq9tZV0wtSekm5Rblo8PqYCGPlIclNyNa68onTnxPzMEJVNuG43NkO0CR7L
	I0K6JNM020cDFwaCt93tyjWMWsI9jqfZQIvUw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65112825DF;
	Wed, 30 Apr 2014 17:45:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 881DA825D9;
	Wed, 30 Apr 2014 17:45:23 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-rc1-355-gd6d6511
In-Reply-To: <1398894312-30763-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BBDAF01C-D0B0-11E3-92DC-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247786>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index fdf6269..9b103cb 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -34,7 +34,17 @@ For shell scripts specifically (not exhaustive):
 
  - We use tabs for indentation.
 
- - Case arms are indented at the same depth as case and esac lines.
+ - Case arms are indented at the same depth as case and esac lines,
+   like this:
+
+	case "$variable" in
+	pattern1)
+		do this
+		;;
+	pattern2)
+		do that
+		;;
+	esac
 
  - Redirection operators should be written with space before, but no
    space after them.  In other words, write 'echo test >"$file"'
-- 
2.0.0-rc1-355-gd6d6511
