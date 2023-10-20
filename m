Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E382132C82
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Eq8fdoyh"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41998A3
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 15:07:25 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A26F8338F7;
	Fri, 20 Oct 2023 18:07:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Pao3oojFecnWQBiogGzGE/gAttRezXO3Fr9Mgr
	DNYmU=; b=Eq8fdoyho964iz3eLU3idGSkOPwFzdGmAy5yTqFMMSJ9WoIxQnQCmO
	rpaCEQqjNmwbiHGPbxXX+k01qld/z7LJK6ONZ72l+WLXt4rxqUNkKNO0ry5XhdQP
	oe1rz8Pv7lIIs31g1ys7XUXWUgTljHBC8UadmX24CFcXr+X6klxtA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C218338F6;
	Fri, 20 Oct 2023 18:07:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3631F338F5;
	Fri, 20 Oct 2023 18:07:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] rebase refactoring
In-Reply-To: <20231020093654.922890-1-oswald.buddenhagen@gmx.de> (Oswald
	Buddenhagen's message of "Fri, 20 Oct 2023 11:36:51 +0200")
References: <20230809171531.2564844-1-oswald.buddenhagen@gmx.de>
	<20231020093654.922890-1-oswald.buddenhagen@gmx.de>
Date: Fri, 20 Oct 2023 15:07:19 -0700
Message-ID: <xmqq5y31osmg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0A8501F2-6F95-11EE-9C88-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> broken out of the bigger series, as the aggregation just unnecessarily holds it
> up.
>
> v3: removed "stray" footer. so more of a RESEND than an actual new version.
>
> Oswald Buddenhagen (3):
>   rebase: simplify code related to imply_merge()
>   rebase: handle --strategy via imply_merge() as well
>   rebase: move parse_opt_keep_empty() down
>
>  builtin/rebase.c | 44 ++++++++++++++------------------------------
>  1 file changed, 14 insertions(+), 30 deletions(-)

Looking quite straight-forward and I didn't see anythihng
potentially controversial.

Will queue.  Thanks.
