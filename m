From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 15/21] pack-protocol doc: typofix for PKT-LINE
Date: Thu,  4 Sep 2014 13:04:51 -0700
Message-ID: <1409861097-19151-16-git-send-email-gitster@pobox.com>
References: <1409861097-19151-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 22:06:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdJ2-0001FP-P9
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417AbaIDUF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:05:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52074 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755414AbaIDUFy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:05:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B6324381DF;
	Thu,  4 Sep 2014 16:05:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xtaF
	UPd3JIoW/TxBRGTvVy375+w=; b=hyLRzdo+NsQ+G8IUmusGTw5ZMZE1nuZmRCCl
	gS+fT+FzHBMoR4Pa0RXHdSbnaklkBBbeOd2V/iKrLInsCgeAXSXQOvBVaVm9trIA
	O9+JUqL9LaVLvqciNZnq0r8tUHF2MbQslH9oCYWxp26v0StwwnjclmXdFrdloaHl
	9ByvV0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=iu6d0n
	32P9yh4W8gXtBewrdVYNKiha6hthwENxmmPg9lQZ6V2/lGkr+2QusHLjYZaMOhfk
	Vyb23aOmCX6LT25cP82Omk8WxmdILeP9vDsoEtVDGsSXPZG35qUy87vl50ablUqT
	qf9iptJ5fjDU3MhjEGzF0YsP6QfK76IUJcoDg=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 597BB381DE;
	Thu,  4 Sep 2014 16:05:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 01E77381D6;
	Thu,  4 Sep 2014 16:05:48 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-399-g1364b4d
In-Reply-To: <1409861097-19151-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DD33A91C-346E-11E4-B718-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256470>

Everywhere else we use PKT-LINE to denote the pkt-line formatted
data, but "shallow/deepen" messages are described with PKT_LINE().

Fix them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/pack-protocol.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 18dea8d..a845d51 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -212,9 +212,9 @@ out of what the server said it could do with the first 'want' line.
   want-list         =  first-want
 		       *additional-want
 
-  shallow-line      =  PKT_LINE("shallow" SP obj-id)
+  shallow-line      =  PKT-LINE("shallow" SP obj-id)
 
-  depth-request     =  PKT_LINE("deepen" SP depth)
+  depth-request     =  PKT-LINE("deepen" SP depth)
 
   first-want        =  PKT-LINE("want" SP obj-id SP capability-list LF)
   additional-want   =  PKT-LINE("want" SP obj-id LF)
-- 
2.1.0-399-g1364b4d
