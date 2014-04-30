From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/8] CodingGuidelines: call the conditional statement "if ()", not "if()"
Date: Wed, 30 Apr 2014 14:45:10 -0700
Message-ID: <1398894312-30763-7-git-send-email-gitster@pobox.com>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 23:45:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfcK7-0005Df-Vu
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 23:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759544AbaD3Vpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 17:45:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65164 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759485AbaD3Vps (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 17:45:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 914138261D;
	Wed, 30 Apr 2014 17:45:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=QN/R
	QOWyxCktXrzUvieIh7wYq1I=; b=ets52jYeK+wXfZTwf/k9i1jOKNDqkAzTh+c7
	pN5huGZ5+Eg3ZKjZBwusU9Pihfwku9/MbBRecWsWfb0rkA/Z/cqNQ+nLCF3R413E
	yDbcwGkD/BirS5rhRWjO4AMQVwwlD/jypJ9d+9nGaHt3hPQhXbsF32YhBKJ8RzI/
	/r4TLrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=tUgRA2
	Z2qiABd1odhcWufElWa0aeilYHf+9H3i8IeWO8lcDH4ONyPB9+i9/mSKjUELBNGN
	x6JNPObRQpoGa/Pcrxl6nHTbj6hMiQdFRy5x1kpVXewwGioiWUJtj5esJD/0OHK4
	ozg/vuox9Vct4C4Dp/4cQEadE27cTW7DctzoU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BB5F8261B;
	Wed, 30 Apr 2014 17:45:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5318782603;
	Wed, 30 Apr 2014 17:45:41 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-rc1-355-gd6d6511
In-Reply-To: <1398894312-30763-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C6744AC8-D0B0-11E3-BB2F-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247789>

The point immediately before it is about having SP after the control
keyword.  Follow it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 1b0cd2b..21e4272 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -184,7 +184,7 @@ For C programs:
    of "else if" statements, it can make sense to add braces to
    single line blocks.
 
- - We try to avoid assignments inside if().
+ - We try to avoid assignments inside "if ()" condition.
 
  - Try to make your code understandable.  You may put comments
    in, but comments invariably tend to stale out when the code
-- 
2.0.0-rc1-355-gd6d6511
