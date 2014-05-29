From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] fetch doc: update refspec format description
Date: Thu, 29 May 2014 15:42:30 -0700
Message-ID: <1401403350-7122-6-git-send-email-gitster@pobox.com>
References: <1401403350-7122-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 00:43:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq92V-0003vU-9R
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 00:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbaE2WnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 18:43:03 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65140 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753841AbaE2WnB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 18:43:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 383D21C342;
	Thu, 29 May 2014 18:43:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=rTx+
	6u31Axa5d8Y6kAizzqhWWIk=; b=ok62dokAjHV349y4dh5EestrNvacax+x/XHo
	jMCJw1g5DBvPx70GMrFx8JYsG67Bq4JkGsbOK1y90NNSAJtI+Z/oJEzHbJjeos7P
	OMDuF26VCdgOzzdwxgrNHZZDSJa4HtKycFcrFf0O22Y3/NesElsJJdW02ofZh03T
	hFsfaCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=OTCWo1
	GNWZj3cQ3pU07dZIYHwM+b51ptpT4/oXc7zGGsw/x1XN2Dtzqd5V8yfX4B4x8agl
	EF3oLd3Q1mwK1hTTI3sSsYRozz7hacoYULlZheAnQ2I/gsSVLfs+mYg0W6d2AA0i
	w9OP13cmNcJYrlfrYsE505aK+KkZrkg8icMcw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0B1171C341;
	Thu, 29 May 2014 18:43:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0185D1C339;
	Thu, 29 May 2014 18:42:56 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-479-g59ac8f9
In-Reply-To: <1401403350-7122-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 943EC7C0-E782-11E3-9FCE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250416>

The text made it sound as if the leading plus is the only thing that
is optional, and forgot that <lhs> is the same as <lhs>:, i.e. fetch
it and do not store anywhere.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pull-fetch-param.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index ea4c5a6..27cfd5c 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -15,6 +15,7 @@ endif::git-pull[]
 	The format of a <refspec> parameter is an optional plus
 	`+`, followed by the source ref <src>, followed
 	by a colon `:`, followed by the destination ref <dst>.
+	The colon can be omitted when <dst> is empty.
 +
 The remote ref that matches <src>
 is fetched, and if <dst> is not empty string, the local
-- 
2.0.0-479-g59ac8f9
