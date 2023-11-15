Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZSXndHYZ"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0107D42
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 09:40:15 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FFE81CC635;
	Wed, 15 Nov 2023 12:40:15 -0500 (EST)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=9sf0S2wtFMXyoruJwJgQRqRrT
	A17Mc1tdgXuefhgug0=; b=ZSXndHYZkxB6wF90KbTRkB2TNKUobF8XGKBqUUyFH
	63gnw02fwXS3/ObNkVPhJtzdlSs7mpbIRFa0QeO9LVPsmz+YD0Zmoyj+BxqNTxdF
	m+HjVdseECVMo9mC3Ixdsw9C5PAOLJ+KkFX5W3x3XcF4JwHukr5Kmu5uZpXPOiEh
	Lw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 187F21CC634;
	Wed, 15 Nov 2023 12:40:15 -0500 (EST)
	(envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F1781CC633;
	Wed, 15 Nov 2023 12:40:14 -0500 (EST)
	(envelope-from tmz@pobox.com)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	=?UTF-8?q?Ond=C5=99ej=20Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>
Subject: [RFC PATCH v2 0/2] send-email: avoid duplicate specification warnings
Date: Wed, 15 Nov 2023 12:39:42 -0500
Message-ID: <20231115173952.339303-1-tmz@pobox.com>
X-Mailer: git-send-email 2.43.0.rc2
In-Reply-To: <xmqqy1ezx2mq.fsf@gitster.g>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 088D0932-83DE-11EE-BA60-25B3960A682E-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Changes since v1:

    * Teach `--git-completion-helper` to output the '--no-' options.
      They are not included in the options hash and would otherwise be
      lost.

    * Restore the `--signed-off-cc` alias which was mistakenly removed.

Todd Zullinger (2):
  send-email: avoid duplicate specification warnings
  send-email: remove stray characters from usage

 git-send-email.perl | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

--=20
2.43.0.rc2

