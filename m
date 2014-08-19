From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 14/18] pack-protocol doc: typofix for PKT-LINE
Date: Tue, 19 Aug 2014 15:06:23 -0700
Message-ID: <1408485987-3590-15-git-send-email-gitster@pobox.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 00:09:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJrai-0006jD-Jc
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbaHSWI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:08:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58776 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030AbaHSWIy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:08:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A51E833174;
	Tue, 19 Aug 2014 18:08:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qxPS
	eRTong+NKkZBaClfBIrMyiY=; b=ASswwnYIp5QabavfH8/8noD0v4azZvINxibo
	+5XbRIrOrZaSL4VTw/W3233qg75/dmD4ojqgPHSkGEtI+fTCCYZ6auDQwlSCs5El
	Nh3lYKLclrEguyRozv0rGxi+mmfnM2vDWuYEUR3MU+1p12bBtR2CQep41AbfV5UJ
	kYFvTAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=bzhUFM
	lfr4jdWV/S9Y6cfpkSOXBRZNsvV7BMXPHgJTsCFzyxgStoT4h4Zp0lQXGIy2pCgv
	6mXs2zmWpR7cSaqRwO/Hssk+60M9DK/5HjL4k3w3Mz02slxCk+PaBUnPv5J9y4Pu
	LWLOP8XmMKct7AapCgZv2NBPewUWmWVJTW+4g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9A2D233173;
	Tue, 19 Aug 2014 18:08:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2B2FD3316A;
	Tue, 19 Aug 2014 18:08:46 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-301-g54593e2
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 63BAB69E-27ED-11E4-AFC4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255536>

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
2.1.0-301-g54593e2
