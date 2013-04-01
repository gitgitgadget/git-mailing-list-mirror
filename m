From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Merging an annotated tag object
Date: Mon,  1 Apr 2013 12:57:16 -0700
Message-ID: <1364846239-8802-1-git-send-email-gitster@pobox.com>
References: <7v7gl3jmx0.fsf_-_@alter.siamese.dyndns.org>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 01 21:58:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMkrm-0000VT-Fm
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 21:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759552Ab3DAT5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 15:57:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61951 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759518Ab3DAT5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 15:57:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85C1E11050;
	Mon,  1 Apr 2013 19:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=PCzC
	9gSN6UotU+ODDK16LC6RxuA=; b=D68vA3ApoAuxL0s/eQh0NqNh0w3Qfy0Ed62d
	VMqFo2RJuUdtU+mjOKYCiAUg9/3xCTGQahi1sWw8GoBpTvAjw7jYTwyrqdM5YM+u
	+FIn5XDOPwV+/7djM2A1EevWwIXCzGsbJnAFH1vLqwxvPKWM0TqvnTg3dG2CiaDz
	lV/vurY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	qNKfhcHwAm8rMFn3HHGkzrIuwOETwSiTXZH+UhZyhnVOe0qrNsIVAbcwJUAu7vRO
	2EgJ7iG5I9hIKLyS9bLF0m8dXYPXe1BpyxH2UPaks2Yrgbjc0qiGuCgG4MRflBfk
	h3slsNNps1wRgFovp4UBvVOb9bw9lVktskJ7D7zbUlM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7497E1104F;
	Mon,  1 Apr 2013 19:57:21 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD28B1104E; Mon,  1 Apr
 2013 19:57:20 +0000 (UTC)
X-Mailer: git-send-email 1.8.2-480-g064f421
In-Reply-To: <7v7gl3jmx0.fsf_-_@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 5D21D0A8-9B06-11E2-92AB-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219704>

This is a patch I posted as an illustration, and then have been
carrying in my tree a while, with some tests.

Junio C Hamano (3):
  merge: a random object may not necssarily be a commit
  t6200: use test_config/test_unconfig
  t6200: test message for merging of an annotated tag

 builtin/merge.c          |  13 ++++++
 t/t6200-fmt-merge-msg.sh | 100 ++++++++++++++++++++++++++++++++---------------
 2 files changed, 81 insertions(+), 32 deletions(-)

-- 
1.8.2-480-g064f421
