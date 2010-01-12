From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/18] submodule.c: mark file-local function static
Date: Mon, 11 Jan 2010 23:52:54 -0800
Message-ID: <1263282781-25596-12-git-send-email-gitster@pobox.com>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:55:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbaY-00056x-0T
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457Ab0ALHxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753329Ab0ALHxc
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413Ab0ALHxa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D4D1A8E89F
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zAxo
	fDW5Bo+HQOc5jceDVaM0fqk=; b=IcScwJB/TJ7t/tgo3HFNFAz3uJRJPF6N+/Xl
	2SxijhCFyr0DdXanqlzbbZql1JgbR2fu56X8epBfn76TE6m7vUuRtf7N+NcfCLEu
	ZGSm7pbdqqOT+/GVAhdT6B0Rs+mj+zQ/l3eSPIDPiYkQb9scwf1Uae1qCi+tuGQ8
	6cRl62w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=J7S+2z
	QfyvyUPW5PNc+q4hkwRSxAwFH2joBwRVa7DtGsplNmkH/0/mkacRg64QmjqIU7mW
	sa7oey27y0LtE9ffieYc8XpCPXaRGWou6i6NWsorvLNnqAaafLRLv8Jq05PfcmrI
	mZuMnWVs960RQCLmuIfbScskCYGAUY6vSUt+Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D0B9E8E89E
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6693C8E89D for
 <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:29 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
In-Reply-To: <1263282781-25596-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 92CEFCAE-FF4F-11DE-8A02-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136702>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/submodule.c b/submodule.c
index 86aad65..3007f7d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -5,7 +5,7 @@
 #include "commit.h"
 #include "revision.h"
 
-int add_submodule_odb(const char *path)
+static int add_submodule_odb(const char *path)
 {
 	struct strbuf objects_directory = STRBUF_INIT;
 	struct alternate_object_database *alt_odb;
-- 
1.6.6.280.ge295b7.dirty
