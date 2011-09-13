From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] State commit name explicitly in request-pull messages
Date: Tue, 13 Sep 2011 15:28:14 -0700
Message-ID: <1315952896-17258-1-git-send-email-gitster@pobox.com>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 00:28:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3bSt-0004eG-5K
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 00:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932962Ab1IMW2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 18:28:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46576 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932956Ab1IMW2U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 18:28:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B69443E2
	for <git@vger.kernel.org>; Tue, 13 Sep 2011 18:28:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=G1Vn
	jN6e2b6A87CnEbvgkgj+NnM=; b=u8T+fiP2jedL3kQkjd15ck5N3HfVFURQB/4l
	tXLqJYX7LUUsHBL9hiz3N12L/v6AzoMe0gqshPSuG8bkSYdr6gp3Dco2N4x/pN01
	oZ59ZsZoJdez+tqpaXVaEAuAv6eMi6uR4HNMrrcpz3/3AzTe4l1rQonFM15chAOg
	AwJYnEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=t67oZY
	wkHR1sXslNI+h2PPcxR+z6JH+qoswyxSenQltGKHWh/efH5iRpCweGK3vOFNNZAp
	DEyecQnfrAaP6z/aMBKptV6xNt3Fcmtu09JppYAFWyLsGYjs6OPdee0f5GxP2ZdH
	5IcWdCNLklcFFydVT2q9Q32xlk0kODxJ7Tj1w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4355D43E1
	for <git@vger.kernel.org>; Tue, 13 Sep 2011 18:28:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFC1443DE for
 <git@vger.kernel.org>; Tue, 13 Sep 2011 18:28:17 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc1.1.g1e5814
In-Reply-To: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: ADAFB7FA-DE57-11E0-A7F9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181319>

Here is an alternative approach to the earlier "request-pull" patch.

Junio C Hamano (2):
  fetch: allow asking for an explicit commit object by name
  request-pull: state exact commit object name

 git-request-pull.sh     |    2 +-
 remote.c                |   25 +++++++++++++++++++++++--
 t/t5150-request-pull.sh |   11 +++++++----
 3 files changed, 31 insertions(+), 7 deletions(-)

-- 
1.7.7.rc1.1.g1e5814
