From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/19] pack-protocol doc: typofix for PKT-LINE
Date: Fri, 22 Aug 2014 13:30:19 -0700
Message-ID: <1408739424-31429-15-git-send-email-gitster@pobox.com>
References: <1408739424-31429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 22:33:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKvWM-00006J-Lo
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 22:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbaHVUdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 16:33:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62102 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745AbaHVUdD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 16:33:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F3D6233231;
	Fri, 22 Aug 2014 16:33:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=rMHJ
	923g2e0jBaqWftHQBEzHv1Q=; b=rZCBFuwfbdcGBYXQpAPXpn83EwCzm8P6opg4
	/yAZdv3GuZFNKX5wFqYAmhakwgyQ1zmDiyYbm9qBFfqHgKTPpGNmOfTWXevh3b+r
	EjK3r6wsuGcKd5UnrT39x0gOAXBhz+ghJNVpcsgM4YprsHPft6cwlTdChipqOpmI
	F5uTc1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=QtIGBX
	us734vghFhoeWqVg2txUMWWZS/xI4yCFfZgJeMtZCxLZThNRRBb7gaxXbLyhxlki
	vWTQnyMD7T9Si8zSBXt7Af9Xud8z+LHdOziTmS1sshUKISwfbLR2A1a9vvTVNd63
	0vwklNWUvl3G5mS+M5jYQy+0b8pGaB+eTzGnY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E90AF33230;
	Fri, 22 Aug 2014 16:33:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0BA2B33229;
	Fri, 22 Aug 2014 16:32:53 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-304-g950f846
In-Reply-To: <1408739424-31429-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7E6EC958-2A3B-11E4-9EB7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255714>

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
2.1.0-304-g950f846
