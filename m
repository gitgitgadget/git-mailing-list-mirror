From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] Clarify "refs"
Date: Thu, 23 Jun 2011 09:52:33 -0700
Message-ID: <1308847958-3429-1-git-send-email-gitster@pobox.com>
References: <7vy60s36mm.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 18:52:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZn99-0007A5-8P
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 18:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759770Ab1FWQwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 12:52:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759754Ab1FWQwl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 12:52:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 910BC5B7D
	for <git@vger.kernel.org>; Thu, 23 Jun 2011 12:54:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=EyDt
	4poXnEruuphfqTWUycNu5hU=; b=qDvvBwrRUMH+BdlTjwFfqBs4qfHR8nrCXEbU
	NhHBkfouj8sxZ33291OK6VAqvAo+V3Mj3Fx4jrNLgt0YSR4a7BFw+RkvcDo/dGYP
	ZvrWcrMS8qvOnqndvddVIwRuFVD5WdYBcfcBPfzO4At7ECeutt5KGkDjzbebz8N3
	V0zVjtY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=m0OVCg
	fo/Uc1mVnMpOKPjUyaJHo3Wpwy1ELkyz1jIrqPl55hhNdAkdD8vcLkFKdHfo4n0T
	zrTBXpfxK0qZGY8kqRUikVVoFzm3W6RiYrh15E3QVTDijfQhm1QXZ3u6M+dK+Zcs
	iDoJx4/Plfwi0XJ649VUI7sdWXMZSYTGbQWCc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 89CC55B7B
	for <git@vger.kernel.org>; Thu, 23 Jun 2011 12:54:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E238D5B7A for
 <git@vger.kernel.org>; Thu, 23 Jun 2011 12:54:51 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.rc3
In-Reply-To: <7vy60s36mm.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 835A2FD2-9DB9-11E0-B7A4-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176275>

So here is a miniseries to update various parts of the documentation
that still talk about $GIT_DIR/refs/. They are split into small and
non-overlapping pieces so that any of them can be discarded more or
less independently.

Thanks in advance for comments.

Junio C Hamano (5):
  check-ref-format doc: de-emphasize the implementation detail of a ref
  git.txt: de-emphasize the implementation detail of a ref
  glossary: update description of "tag"
  glossary: update description of head and ref
  glossary: clarify description of HEAD

 Documentation/git-check-ref-format.txt |    9 ++++++---
 Documentation/git.txt                  |    7 +++----
 Documentation/glossary-content.txt     |   27 ++++++++++++++-------------
 3 files changed, 23 insertions(+), 20 deletions(-)

-- 
1.7.6.rc3
