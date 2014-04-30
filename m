From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/8] CodingGuidelines: typofix
Date: Wed, 30 Apr 2014 14:45:05 -0700
Message-ID: <1398894312-30763-2-git-send-email-gitster@pobox.com>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 23:45:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfcJl-0004fU-RG
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 23:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759296AbaD3VpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 17:45:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48328 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759041AbaD3VpW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 17:45:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B60F825D7;
	Wed, 30 Apr 2014 17:45:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=dtqo
	DjSqCFFxXS0+NcG2cHuHhSg=; b=SCugrzfXL1ETCcyUXbzhn6TPVouNaxsv1lFE
	w2XaEVKoqrT7wBEv8ZbRHsCN5z/N4HckcA7HPsnLPXhS4eACVSj90j9+fX13vc2X
	9/oOjmcCjo3tkjFLO/h8M3SEmfOxdykFPV9fqSAF2JKlQIGD47er/NtHtQS3yX8y
	AsqYwBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=r5zKE7
	PnM6qS75ivbAavPtnLPn6AvsIq/PiCicOnpfYKfoi5ck8/hECJ159R092s85oepV
	7w0riLQxd1un2KYu1qCBS8GLnFThEzWqJ8ISMBWcgcCNnAHv2Oek5MsRw3tkEENX
	wcmXTTzmP3lkbGbZSPT4lXJZB9Z/9TFV9n+3c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 335C5825D6;
	Wed, 30 Apr 2014 17:45:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00071825D1;
	Wed, 30 Apr 2014 17:45:19 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-rc1-355-gd6d6511
In-Reply-To: <1398894312-30763-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: B9BDF40A-D0B0-11E3-97C1-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247785>

The sentence lacked the necessary verb.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index f424dbd..fdf6269 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -15,7 +15,7 @@ code.  For Git in general, three rough rules are:
    let's use it".
 
    Again, we live in the real world, and it is sometimes a
-   judgement call, the decision based more on real world
+   judgement call, the decision is based more on real world
    constraints people face than what the paper standard says.
 
 Make your code readable and sensible, and don't try to be clever.
-- 
2.0.0-rc1-355-gd6d6511
