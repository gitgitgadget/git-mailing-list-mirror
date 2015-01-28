From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Documenting naming rules for configuration variables
Date: Wed, 28 Jan 2015 14:33:10 -0800
Message-ID: <1422484393-4414-1-git-send-email-gitster@pobox.com>
References: <xmqqiofskmfd.fsf@gitster.dls.corp.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 02:12:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGdf1-0002lp-ON
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 02:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbbA2BMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 20:12:32 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751972AbbA2BM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 20:12:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE45633A89;
	Wed, 28 Jan 2015 17:33:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=tFjt
	wX8HWSKvLXi+Q6kTrVCxDtA=; b=tuHD89ij8KVtFtyEOlQRrLkROZejK6QpKhr6
	8k9lq6M0fLGu7+fWfkHymAlOoV2PZ6fB+9oLx9kA7hmmQb/8bh5Ni0tfkFfYNLq4
	EZzWxpRgNXEWFeYlKfbjYFUrDiWjS6sWz4rEDxUupy33xrkDu+XXTefRbihyb+ye
	4fjYe+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=eD5Cmp
	zQd1tfyA9JpzffFjYDHxqM+l+AF3roF7Sz+N6HMAmMmhEIdXDUyfvyYZiewtsdcs
	czSJARjQDlfQ0TQVUVa990Yct4djy6PxMrweE9FON3iX9ZeTCR+UKPZoAQVhifjP
	FTg9mNO9f+Ur3sflSVoaWOukKcAJfxu75usjI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A4B1D33A88;
	Wed, 28 Jan 2015 17:33:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DEAE33A87;
	Wed, 28 Jan 2015 17:33:15 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc2-149-gdd42ee9
In-Reply-To: <xmqqiofskmfd.fsf@gitster.dls.corp.google.com>
X-Pobox-Relay-ID: A6360D64-A73D-11E4-BE25-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263125>

So here is a rewrite of the same but split into three patches,
after seeing "add.ignore-errors" not marked exactly as deprecated.

The update to CodingGuidelines goes a bit beyond how to name things
(i.e. bumpyCase vs dashed-words, the latter of which is strongly
discouraged) but how the names should be structured (i.e. no
unbounded set of things as variable names).

We may have to also be careful about underscores (there is one I
know about: gitweb.remote_heads that is used by instaweb), which
might be a good starter topic for somebody new to the codebase.


Junio C Hamano (3):
  config.txt: clarify that add.ignore-errors is deprecated
  config.txt: mark deprecated variables more prominently
  CodingGuidelines: describe naming rules for configuration variables

 Documentation/CodingGuidelines | 25 +++++++++++++++++++++++++
 Documentation/config.txt       | 15 +++++++--------
 2 files changed, 32 insertions(+), 8 deletions(-)

-- 
2.3.0-rc2-149-gdd42ee9
