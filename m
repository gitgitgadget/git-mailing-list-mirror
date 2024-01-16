Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921361C294
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jHLqRd3H"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 419271E5748;
	Tue, 16 Jan 2024 10:41:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ql7QVCxlVf9A8meHmqRkmDBMlNBWOkH+4WOM0y
	9+Ges=; b=jHLqRd3HgPzsgX7mG3BnB/2Rex9Ebjys1HGGCG/ypq7BqISkk6gjpo
	A+wYZncFjSJueaj9s4gH5Vc2r+Skx0um3lo5jIVRmgFsbvFNuDd0vGzE6LT02bdS
	5euQQtXwaKsQZtMr5WZ7xMrwZ37wIwVF0D8d6x66965kwqExX5IXg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 39DE41E5747;
	Tue, 16 Jan 2024 10:41:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F6451E5746;
	Tue, 16 Jan 2024 10:41:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  christian.couder@gmail.com
Subject: Re: [PATCH v5 1/2] t7501: add tests for --include and --only
In-Reply-To: <20240113042254.38602-2-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Sat, 13 Jan 2024 09:51:54 +0530")
References: <20240112180109.59350-1-shyamthakkar001@gmail.com>
	<20240113042254.38602-1-shyamthakkar001@gmail.com>
	<20240113042254.38602-2-shyamthakkar001@gmail.com>
Date: Tue, 16 Jan 2024 07:41:51 -0800
Message-ID: <xmqqle8p475s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C52C4260-B485-11EE-A939-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Thanks.

"git am" auto-fixed these whitespace breakage.

.git/rebase-apply/patch:25: trailing whitespace.
	
.git/rebase-apply/patch:38: trailing whitespace.
	# 
.git/rebase-apply/patch:40: trailing whitespace.
	# and is not an endorsement to the current behavior, and we may 
.git/rebase-apply/patch:56: trailing whitespace.
do 
.git/rebase-apply/patch:82: trailing whitespace.
	
warning: 5 lines applied after fixing whitespace errors.
Applying: t7501: add tests for --include and --only

