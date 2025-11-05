Received: from web23.osl1.nordkapp.net (web23.osl1.nordkapp.net [185.114.57.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E027260F
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.114.57.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382907; cv=none; b=QlO/Q7reLJERCdF2OEuxyDcaV5H1ozS0vZQErHQLrqmTsmsYTvSZ5Iey0XnsZ0K3+PCqOBuICWMKLEkhMinWenwmcixQB/UPCJYE66t/Rlk1Dycpk8HFvTZMSlZXZbKr3yUYrzRQP6jOMWdqjuChPJUHvbLkOWHRQFxz/vhSGDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382907; c=relaxed/simple;
	bh=tgrrFAr6UVyqmA4QIVK6AvdtfAOzGqZvJ71bxdJHl3s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=JCMngN0lg1noib+tgOBuQcFGxuqbKx6HR9mdjjeoPhDDREvwZtECY814MbepYJGKmvkH3cvYIVPDFJE6RyLVqYguUh2mqkSQH7H4jN3/BS5XXnuXOQYHI2rvXLd1EGfeY2uZ60k2iBNj245KplL5cfAkQLuROnrKwHTsuz6NFDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se; spf=pass smtp.mailfrom=softwolves.pp.se; dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b=fX51Z3MF; arc=none smtp.client-ip=185.114.57.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b="fX51Z3MF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=softwolves.pp.se; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:To:
	From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rwrdiCpjJwrqtHer0R3jdD5BTDuqAIVzAGcAgxRLczI=; b=fX51Z3MF6IH8DBKaHYi7nSH3RO
	q5tiX32UqbGHe51CVZSRKoHpcJaqNFp5LPTMhtFgjAYnjhQfvbLZE1JLk2PwSfYurA+Hs/LOtyb3R
	BMTV797kbYxmkl2QfAeuN0QZOdaEUUEalwuCuduXVnULVy4I7weM1nYgIHHUQ0SRa2Zng0xEKLH2R
	+S/Z9tbIP/qM+igsY97QbozcJ+VTj/eQ9qmC1I/REN6XOb6KV1byqQxav/cc1wg3sNaxyzKGaX2GP
	DZl0EkjJwQvNGNTFP3S4NJ3sIQu/AenowUTuz7+vOi27ln+SNMBdrouBAw1OHr9XTZ+fl9LedkuE0
	4xX/WOkQ==;
Received: from mail01.osl1.nordkapp.net ([185.114.57.50] helo=mail.nordhost.no)
	by web23.osl1.nordkapp.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <peter@softwolves.pp.se>)
	id 1vGlLd-0000000GRot-2Ve2
	for git@vger.kernel.org;
	Wed, 05 Nov 2025 22:47:21 +0100
Date: Wed, 5 Nov 2025 22:47:17 +0100 (CET)
From: Peter Krefting <peter@softwolves.pp.se>
To: git@vger.kernel.org
Subject: [PATCH] refs: Add missing space in message
Message-ID: <a8220721-3260-15cb-6960-ca8b6433d7b5@softwolves.pp.se>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: peter@softwolves.pp.se

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
---
 refs/files-backend.c    | 2 +-
 refs/reftable-backend.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 054cf42f4e..1adc4b5182 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3124,7 +3124,7 @@ static int parse_and_write_reflog(struct files_ref_store *refs,
 		if (!(update->flags & REF_HAVE_OLD) ||
 		    !(update->flags & REF_HAVE_NEW) ||
 		    !(update->flags & REF_LOG_ONLY)) {
-			strbuf_addf(err, _("trying to write reflog for '%s'"
+			strbuf_addf(err, _("trying to write reflog for '%s' "
 					   "with incomplete values"), update->refname);
 			return REF_TRANSACTION_ERROR_GENERIC;
 		}
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index d4b7928620..eeec64798f 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1103,7 +1103,7 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 		if (!(u->flags & REF_HAVE_OLD) ||
 		    !(u->flags & REF_HAVE_NEW) ||
 		    !(u->flags & REF_LOG_ONLY)) {
-			strbuf_addf(err, _("trying to write reflog for '%s'"
+			strbuf_addf(err, _("trying to write reflog for '%s' "
 					   "with incomplete values"), u->refname);
 			return REF_TRANSACTION_ERROR_GENERIC;
 		}
-- 
2.47.2

