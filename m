From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 15/23] pack-protocol doc: typofix for PKT-LINE
Date: Wed, 17 Sep 2014 15:45:50 -0700
Message-ID: <1410993958-32394-16-git-send-email-gitster@pobox.com>
References: <1410993958-32394-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 00:46:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUNzo-0002FS-RQ
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 00:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbaIQWqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 18:46:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55157 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932109AbaIQWqf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 18:46:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 69C0839E1E;
	Wed, 17 Sep 2014 18:46:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xJgy
	KURDf6EzKIAXfTeLGF1xmTs=; b=mNDleBHUtvdNHNrkDl+aI5gt+Kp6C1DK3ruQ
	+cehFfp//G9BlkE+K3y/2Kw3Xiste7s2L8Eb/ZvciOGk0zOfpk3JH/Slt5S3tpqG
	iXaLhupsBRgJPJCnX2OEJp+VOf6UdDkJMNN61jl1MSm45QfBRdbRKLvMKP2lvVfu
	ookF+II=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=O6XPRK
	ZAySeeD4PWeAb45/jJ/L2XKEKIUQn/RvRAWix6Xg3PEuCNe0c7JQ8PHGoiBAWuWK
	VKHw48dSc1OlZ0TfH393Bnf1hyxkzHCOSHutsbb94113GGEMtcQW2bSScSWlglPk
	/H40io6vkrvWaTHnW+etc0+U4pQjJz4txgeJk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E4A639E1D;
	Wed, 17 Sep 2014 18:46:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B508739E14;
	Wed, 17 Sep 2014 18:46:30 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-403-g099cf47
In-Reply-To: <1410993958-32394-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 777E3BD4-3EBC-11E4-A121-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257239>

Everywhere else we use PKT-LINE to denote the pkt-line formatted
data, but "shallow/deepen" messages are described with PKT_LINE().

Fix them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Unchanged since v5.

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
2.1.0-403-g099cf47
