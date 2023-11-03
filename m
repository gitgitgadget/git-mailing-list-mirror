Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2818C32
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="opwqtgO/"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACB51BC
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 07:18:27 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 26B393FBA1;
	Fri,  3 Nov 2023 10:18:26 -0400 (EDT)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=qwY+n+bJGPKy2OdA2EfbW6CvydmeaD5kSx3i4F1+7eQ=; b=opwq
	tgO/LBxlCeQVV84ROk4GdBAqiwBQmcvqmt5VcM6nNeN8UALRn/mlhzZciqRKDr5d
	gHx97bZi+AIZG9DHukPXwXvMTGbMskDTSa0HcjP+MRfKqJriEZST1DK0hn80pfnR
	9JredQ1JPz+xknypD/RlzZpGAT5ilKDRgVfbDq0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F89F3FBA0;
	Fri,  3 Nov 2023 10:18:26 -0400 (EDT)
	(envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4CFE73FB9A;
	Fri,  3 Nov 2023 10:18:21 -0400 (EDT)
	(envelope-from tmz@pobox.com)
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH 0/2] RelNotes: minor changes in 2.43.0 draft
Date: Fri,  3 Nov 2023 10:17:49 -0400
Message-ID: <20231103141759.864875-1-tmz@pobox.com>
X-Mailer: git-send-email 2.43.0.rc0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 D7BAFA78-7A53-11EE-B6C0-F515D2CDFF5E-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

These are minor changes from a quick reading of the 2.43.0
release notes draft.

Todd Zullinger (2):
  RelNotes: minor typo fixes in 2.43.0 draft
  RelNotes: improve wording of credential helper notes

 Documentation/RelNotes/2.43.0.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--=20
2.43.0.rc0

