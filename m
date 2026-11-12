Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794452193;
	b=BRuitABGulZyRs0CIgCX5HrucvF/DGjsR4yErxVl14DO6IUl9IrrcSPcJKrAnGqpz6PW
	 cocvcX6qvmHCQ/KAPthtTLQJohkeChr/cC98k9XwzX3+Gw6uD2wvlTxOj5o8iKhSixFMp
	 AuGxlJgBggR3fKUlmf6klYKyux4jFbYzgKba+14vKBmtqQnrVLhDTZAg0qAWGOmyo5Dnz
	 H0Wy+0nCyulIERTVYKPqcz73Z1fetbuoTzkmdeCXNT93RjFUA0bEPlxX1pC8ylfdZKVgu
	 2GRDdoEwFfOew38mqz4yIqKet7ZJ5IEEgPeHABFQfr/p1vKfU1FW16OB6Us40sfXLcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452193;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=d73EyyrfHj5fSu43bGr8mVPdh+lb0OJADX2Cza623hk=;
	b=NLUiPdSmoT1giVp/A8xPUBBVCqQFR3YFYg8iF/IjSznm4RF/nroPWql8YKUZSczYhpDc
	 2MQvSxrSf135YBZn9AzzKe4Sl0DfUOdW/tSQzGC7g/FvjEFl8h+sQpSphyFY1vrmIMqep
	 6dHx+8EresAvsbzVGsUp5jg+Keg9Mzmg0cKgBGw1ZfoyKgfQ5346X5BOqONeoWyxQgoqx
	 qYg8ucFYetMLegUa//JnYpp+uu1GRC//75BC3HMq4ke3Kcq79TIzSpjT7bdtx7VBDU8nT
	 fQ3BMSu4X3GrYx3CptJw8u1j7YH6FKYaSn0kb7GfEsYNkm/bu+m8yFYNcVG8SbF5juQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=eZqX5478;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D3C606A321
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 02:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65D3C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=eZqX5478
ARC-Seal: i=1; a=rsa-sha256; t=1794452187; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jEbdzpE2syQGPmHr8qjIGLdrA/nUQleMjJJMPpkL6t4b/KBmAODhmBoqYIylqZPAC25hbhnkGqNv2e4LSzQw2NvtaHjsjAEgVW/eUlmJycv31l/4bMMGYh24e8WuQRxzvEvKu3LMjEJQh2eCs8Focw1qYF8nlofMalsVXKytgyk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794452187; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=d73EyyrfHj5fSu43bGr8mVPdh+lb0OJADX2Cza623hk=; 
	b=E44hfkwX0QDnzdXRwqvH7Myv0YBFpqDh+d8AxW1HEtRpwJpeaGwb743KyThU7Oebh5LhnL9VWxAA99TBDQ1k371jk2zWMM7TubdU48BAo+Cs9fNK5RakJddcwp6RrnANYABI6pfIJGhIC4MttG8UADWN8E398O+bkAL4w0amems=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=eZqX5478TT6lou2kgO+50aJHNaA2lkpdq72NutXZG7RJjMS1DXoyvdO38/7H0seLmtgfYNIWWI/U9ZUOMdSkIGwIHSfeE+lr3/OP8Xo2+S9UoiOP3/kCRdwyLq+22mTKFEPHlPYfs9yMHK+JefGMCBHmBYL4BFRmuKJXMUd5IZ4=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=d73EyyrfHj5fSu43bGr8mVPdh+lb0OJADX2Cza623hk=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794452186807406.49068897116115;
	Wed, 11 Nov 2026 18:56:26 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC PATCH] fsck: report the real object count in the connectivity message
Date: Wed, 11 Nov 2026 18:55:59 -0800
Message-ID: <20261112025559.83265-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020102134.42151-1-aniketgupta3001@gmail.com>
References: <20261020102134.42151-1-aniketgupta3001@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Thanks for the patch. Looks good to me. I ran t1450 with and without
the patch: the new tests pass with it and fail without.

One thing about the title:

> fsck: report the real object count in the connectivity message

In a partial clone the number counts blobs that were never downloaded.
Setup:

    git init -q -b main src
    git -C src config uploadpack.allowFilter true
    for i in 1 2 3
    do
    	echo $i >src/f$i
    	git -C src add f$i
    	git -C src commit -qm c$i
    done
    git clone -q --no-checkout --filter=blob:none file://$PWD/src pc

Then:

    $ git -C pc fsck --verbose 2>&1 | grep connectivity
    Checking connectivity (9 objects)
    $ git -C pc cat-file --batch-all-objects --batch-check | wc -l
    warning: This repository uses promisor remotes. Some objects may not be loaded.
    6

Would "report the number of objects checked" fit the title better?
