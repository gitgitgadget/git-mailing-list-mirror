Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A112547F63
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tlz9eDiJ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 09091279A6;
	Fri, 15 Dec 2023 17:28:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ogNYytJKCz/xSMpgRkX4xNJmm3dzfKbRdth3ay
	mYXQg=; b=tlz9eDiJlzrig+mF2u1LXSEJAWemuNYpa0AZYJ2YU3LqXod8J83lQr
	e2A5DBmjAGOKVU51UqYlBXJnKHxb2/f8ByW/luQNfkZqy5Rfp/aehe7R/e4GpJMi
	1/+t7O5ngMMrnbRH4Vw5w/3dMECuPMgj4WOq8ynOX+uoYA5r1StSk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 01BB9279A5;
	Fri, 15 Dec 2023 17:28:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E1E332794D;
	Fri, 15 Dec 2023 17:28:01 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] doc: format.notes specify a ref under refs/notes/ hierarchy
In-Reply-To: <xmqqttojjegr.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	15 Dec 2023 14:19:48 -0800")
References: <20231215203245.3622299-1-gitster@pobox.com>
	<20231215203245.3622299-2-gitster@pobox.com>
	<0c93d426-17c3-434c-bbd0-866c31c23f9d@ramsayjones.plus.com>
	<xmqq1qbnktnl.fsf@gitster.g> <xmqqttojjegr.fsf@gitster.g>
Date: Fri, 15 Dec 2023 14:28:00 -0800
Message-ID: <xmqqjzpfje33.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 352AB3C2-9B99-11EE-8B8B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

There is no 'ref/notes/' hierarchy.  '[format] notes = foo' uses notes
that are found in 'refs/notes/foo'.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * According to my eyeballing "git grep refs/ Documentation" result,
   this was the only remaining mention of "ref/" in Documentation/
   hierarchy that misspells "refs/".

 Documentation/config/format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/Documentation/config/format.txt w/Documentation/config/format.txt
index c98412b697..7410e930e5 100644
--- c/Documentation/config/format.txt
+++ w/Documentation/config/format.txt
@@ -119,7 +119,7 @@ format.notes::
 	`--notes=<ref>`, where `ref` is the non-boolean value. Defaults
 	to false.
 +
-If one wishes to use the ref `ref/notes/true`, please use that literal
+If one wishes to use the ref `refs/notes/true`, please use that literal
 instead.
 +
 This configuration can be specified multiple times in order to allow
