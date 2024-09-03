Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF8018A6A7
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380271; cv=none; b=GyxUEHLepK6XRxOOI7M+UNV67k/UrpYjUDJ7GOjDqMJ1SkSe7s4h6sHewYBJYEy7ArGMyhIPiJP7wLNtJleGbwXuARxGah290uKInHZO9/p2YAa03q8n6VBxFnQJvG6scAeke7b95KkkDCIC8cXh7EXo4cdJLl4sZJOOEEO7uR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380271; c=relaxed/simple;
	bh=Too4aAYVRTstFJPRKcfxUSZm2pGTqOZ4r7XeO/KmzPs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gABHu4Mj483/pmtRMKIOzojuuNb5j0J/C/bZw3ebgt//5CEqUQVwEFh6HOCNU3HcC+ROo3F8p8300fjafU83bnzXMVvJTeckMUQTzVQypWgQkonS0pXUNZK0kGMv3v9AT9K9sCGmXW0vHkiRTuMnqi+3lW0NHrsgQ1yLnk+WWak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QHeOTGtt; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QHeOTGtt"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 85FBA264EA;
	Tue,  3 Sep 2024 12:17:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Too4aAYVRTstFJPRKcfxUSZm2pGTqOZ4r7XeO/
	KmzPs=; b=QHeOTGttgQ0lx5hGL/DaZ6qe1XJxu0SiBa9e3n1kdMSyFuUFEJzEGD
	w0uM60JtyyUFRtHsHsqQHlTn5AvZTULX+D/1A8PrvKRSeNUah+rJk5I+r9aMgM/w
	Zs5qF1iE+NaG5tiYznT0djKGqj8EWIqpG1MAV5DV4QjK9kNpqYRXA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D1F9264E9;
	Tue,  3 Sep 2024 12:17:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E1DA7264E8;
	Tue,  3 Sep 2024 12:17:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Pedro Rijo <pedrorijo91@gmail.com>
Subject: Re: [ANNOUNCE] git-scm.com running on heroku-24
In-Reply-To: <ZtcgdJmVunVwwCmk@nand.local> (Taylor Blau's message of "Tue, 3
	Sep 2024 10:43:00 -0400")
References: <ZtcgdJmVunVwwCmk@nand.local>
Date: Tue, 03 Sep 2024 09:17:46 -0700
Message-ID: <xmqq1q20n239.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0F3C7B46-6A10-11EF-AA3F-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> There is some work ongoing to move the site away from Heroku [3], but
> this change should keep the site running smoothly in the meantime until
> that work is complete.

Thanks.










