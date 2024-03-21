Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9988C04
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711063543; cv=none; b=iN7UT45ZZN2jQmmRzYFIam16UI8dDfWF/t/KWXDPEGyTSA0ecWH9oYX4+VIKY6vhAWd64xu8gwf7vNZ+1OaeIldUZNzZdXDyG6gF70rft8K02hOkjcU0jlh1fEI3sRjn5nyGgSdB6oEczFMuAqq1d3Re+Ou4O/9coyKwTtLKhow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711063543; c=relaxed/simple;
	bh=6Y8FtrkodB75bkaavpB6cfPPD3FbfQow7NUyXPYJ36s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r6G93DaVDpqLBAQiymRX9/ReQp1JA5fl0EHtlfpeJ6+60r7p3Ufs6k/rVyVWoSyhrlUoFO4D9T6MrggetAfpHwhkXPxca6+3y8/r+SlMZST890N/hl4tDf6QLf9gyFDFf8zzTN8zVWWsRL7xQOyV6M19JxpV/a9A3jdd4IGdMsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eGs42Bky; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eGs42Bky"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D0D41F2DAB;
	Thu, 21 Mar 2024 19:25:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6Y8FtrkodB75bkaavpB6cfPPD3FbfQow7NUyXP
	YJ36s=; b=eGs42BkyiiYXTDEnblOrczP1Nw5U9Ap36hNkXrf9WX90RaV+SycQp1
	eQRIY5ILsG8X+Ru/YgAjDt9vz0E62n9m8rELgdQLNBYN73M3AE9gVuFLrGN9zmH8
	tZ6/CJG/0OS+JIAAXg1NgtjDyaRWmvZhG9MsJ0o0weKa9W//RQEG4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 34CDB1F2DAA;
	Thu, 21 Mar 2024 19:25:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B7D21F2DA9;
	Thu, 21 Mar 2024 19:25:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sanchit Jindal <sanchit1053@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Sanchit Jindal via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] t9803: update commit messages and description
In-Reply-To: <CAN7Jk_3A5c=5E+CNyncaT9qe_d85_p6ZHNzJPd0E5ZSjG1kQng@mail.gmail.com>
	(Sanchit Jindal's message of "Fri, 22 Mar 2024 01:58:21 +0530")
References: <pull.1691.git.git.1711049963.gitgitgadget@gmail.com>
	<b8d0620d4104106210ecf6a34ada591adf01cff8.1711049963.git.gitgitgadget@gmail.com>
	<CAPig+cRweMree1LJ=qpOJZg7HYvgE9XX8iFvMKcAGYJpAFGFDg@mail.gmail.com>
	<CAN7Jk_3A5c=5E+CNyncaT9qe_d85_p6ZHNzJPd0E5ZSjG1kQng@mail.gmail.com>
Date: Thu, 21 Mar 2024 16:25:33 -0700
Message-ID: <xmqqsf0j5frm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5137167C-E7DA-11EE-859D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Sanchit Jindal <sanchit1053@gmail.com> writes:

> I have created another patch with a more descriptive commit message,
> and after squashing it with the earlier commit. I hope it is satisfactory

Hopefully.  What GGG sent with v2 label still was a 2-patch series,
whose [2/2] patch was an empty patch, though.

> I wanted to ask, Is it possible to send the patches created using
> `git format-patch` manually using gmail, Or the default headers
> applied by `send-email` required.

I do not know where you are using gmail from (I know that Android
version has no way to send text-only e-mail for example), but when
cutting and pasting the output from format-patch, you should make
sure

 * Remove "From <commit object name> Mon Sep 17 00:00:00 2001"
   marker line that signals the beginning of each patch message.  It
   is a mistake to leave this line in the body of your message.

 * Remove "Date: " header.  Do not leave this line in the body of
   your message.

 * Remove "Subject: " header and move its contents to your MUA's
   Subject entry field.

 * Remove "From: " header, and arrange that your MUA puts the same
   "Sanchit Jindal <sanchit1053@gmail.com> on the From header.  If
   your MUA is not cooperating, you can leave that line in the body
   of the message

 * Your cut&paste does not corrupt whitespaces, like squashing two
   consecutive spaces into one, removing the leading whitespaces,
   turning a tab into a run of spaces, folding a line at a
   whitespace in the middle of the message, etc.

 * Your MUA does not turn your text message into HTML gunk.

As long as you do the above carefully, you should be OK.  "git
format-patch --help" has a section on MUA specific hints, which also
might be helpful.

Thanks.
