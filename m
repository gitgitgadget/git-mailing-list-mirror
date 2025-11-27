Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0BC2F90E0
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764240690; cv=none; b=ZNhGlgd145aI3pztlgGpUEdfJEUbiZKEM2iVHG2dVjY5AFZ2QqMaeEO6w6vVdilE3jDjtLZikAxVobtyj8aJr4XylklO6HUprUHMQBVSZBvUwQSclAia7hJzElWGvKxQsonTKBvvsKZlsVB8/85QWb41xSTTlItNyLFvgNocVmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764240690; c=relaxed/simple;
	bh=Ew9WC39Y1tPN/5tYvSP4Xp8CLzlNSKsFyODg54W+h7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqJkweL15tQ+WkClddP2eqKUcmdlRfeEHn3FTF1mNCbB1lg1puWw4mWvrOgCnLgYzpRsMT35Y+mvxX7X0SHG1kC8RcZDt3zI/4mNbiA/0LofrcW2f7TjDzbfv3QHVz+ozE7A7aF60WlNVr1w6rkEilGFjjwR2ACcQU+OW4Dj0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4dHCsS4XfdzRnDC;
	Thu, 27 Nov 2025 11:51:24 +0100 (CET)
Message-ID: <8800e796-77f4-4613-8c68-25bfa091d424@kdbg.org>
Date: Thu, 27 Nov 2025 11:51:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] diff: "lisp" userdiff_driver
To: "Scott L. Burson" <Scott@sympoiesis.com>,
 "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Jaydeep P Das <jaydeepjd.8914@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
References: <pull.2000.git.1763201865025.gitgitgadget@gmail.com>
 <pull.2000.v2.git.1764211096.gitgitgadget@gmail.com>
 <da99bb0bcd8c92e0d6de8b929b67095fae251f88.1764211096.git.gitgitgadget@gmail.com>
 <CAF5LJ4B2PeLPZi5gD6Htqdwhj5T-5U9Od_NhDe-8kXTN1-v6_Q@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAF5LJ4B2PeLPZi5gD6Htqdwhj5T-5U9Od_NhDe-8kXTN1-v6_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 27.11.25 um 11:32 schrieb Scott L. Burson:
> On Wed, Nov 26, 2025, 6:38 PM Scott L. Burson via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> [duplicate of first message]
> 
> Hmm.  Somehow I have screwed things up so that GitGitGadget sends out
> only the first commit, not including the changes in the second, nor
> using the PR title and the text in the description.  Sorry for the
> noise.  Is there an easy fix, or do I need to make a new PR?
I think all went as expected as far as GGG is concerend. You made a new
commit on top of the one in the earlier round, and then asked GGG to
submit the PR to the mailing list. GGG made a patch series with a cover
letter and the two patches. That's expected, because the first patch
hasn't been integrated in upstream Git, yet.

If you intended to send just the second patch (as a fixup of the first
one), then GGG cannot help you, not even if you make another pull request.

But you shouldn't have sent a fixup commit anyway, but that is a matter
I'll address in a separate message.

-- Hannes

