From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 15/23] pack-protocol doc: typofix for PKT-LINE
Date: Mon, 15 Sep 2014 15:24:16 -0700
Message-ID: <1410819864-22967-16-git-send-email-gitster@pobox.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:25:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTeho-0006RL-Be
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758727AbaIOWY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:24:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54008 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755836AbaIOWY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:24:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E5E033B1C2;
	Mon, 15 Sep 2014 18:24:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=dsnb
	a0bsBuHy3Gr98huSdHpeWU0=; b=p+4YVJtaH0TiokoV2vuemTSQ07eTzkoTjS2S
	8MaSKajo3P7p6Ou8UaQDh2ZOkp9wQXNdtFguh724msMMRKO2aVAAZ4HjIVIfkpnc
	b9I2s5yKz/H4ErDidzMhlxegzOihDi85gKKM6miajcm9zIUfXC9LIdOsGsMy3mph
	ewsFGn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=JovgLe
	OUv1Y8Q8VLDVKfGm1UdoTm8wAM9ai4T2hOpwACxske2W7YJcMZ9ticqH3vWyNIfS
	SrdDHRq5EuK+dTlsGZKWBBpAkR2NtFPxqT322KU/QNjrOFlicOV5uBziFR6gggUG
	qydokpxvVjP+tcLlw0b+kSNACqkRSN7ucNOXM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DA4B53B1C1;
	Mon, 15 Sep 2014 18:24:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5F78F3B1C0;
	Mon, 15 Sep 2014 18:24:55 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-420-g23b5121
In-Reply-To: <1410819864-22967-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1E93ECA8-3D27-11E4-AE72-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257100>

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
2.1.0-410-gd72dacd
