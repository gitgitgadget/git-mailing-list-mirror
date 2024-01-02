Received: from 3.mo552.mail-out.ovh.net (3.mo552.mail-out.ovh.net [178.33.254.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F38515AC7
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jwilk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jwilk.net
Received: from mxplan6.mail.ovh.net (unknown [10.108.9.140])
	by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 02511280AF;
	Tue,  2 Jan 2024 18:58:45 +0000 (UTC)
Received: from jwilk.net (37.59.142.99) by DAG4EX1.mxp6.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Jan
 2024 19:58:44 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-99G0039fa2761e-9849-43f3-864f-9e1be8bcebbe,
                    4C7888C89FD28E66648C436CEF5321F23560B538) smtp.auth=jwilk@jwilk.net
X-OVh-ClientIp: 5.172.255.201
Date: Tue, 2 Jan 2024 19:58:42 +0100
From: Jakub Wilk <jwilk@jwilk.net>
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-clone.txt: document -4 and -6
Message-ID: <20240102185842.bbcd7sqezsj5locs@jwilk.net>
References: <20230527123849.5990-1-jwilk@jwilk.net>
 <xmqq1qivd8d0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq1qivd8d0.fsf@gitster.g>
X-ClientProxiedBy: DAG8EX1.mxp6.local (172.16.2.71) To DAG4EX1.mxp6.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: cdfbc64d-a02c-45b7-aab2-911609a562a0
X-Ovh-Tracer-Id: 6693756421229107165
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegfedghedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfhfgggtuggjihesthdtredttddtvdenucfhrhhomheplfgrkhhusgcuhghilhhkuceojhifihhlkhesjhifihhlkhdrnhgvtheqnecuggftrfgrthhtvghrnhepuedttdetlefhffduvdehgfefudejledtkeehudevkeekleefudeuvdegjedufffgnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrdelledphedrudejvddrvdehhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjfihilhhksehjfihilhhkrdhnvghtqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhnohhrmhgrlhhpvghrshhonheshihhsghtrdhnvghtpdfovfetjfhoshhtpehmohehhedvpdhmohguvgepshhmthhpohhuth

* Junio C Hamano <gitster@pobox.com>, 2023-06-01 15:06:
>The patch is not _wrong_ per-se, but there are other options that are 
>common among the "fetch" family of commands.  I counted at least these 
>should be shared between "fetch" and "clone", by splitting them out of 
>"fetch-options.txt" into a new file, and including that new file from 
>"fetch-options.txt" and "git-clone.txt".

Agreed such a split would be better, but I don't have energy to 
implement it.

-- 
Jakub Wilk
