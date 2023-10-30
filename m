Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426B7626
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q5uTwHlT"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECF19E
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 17:15:22 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BCA471C3E38;
	Sun, 29 Oct 2023 20:15:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCP
	jaYaY=; b=q5uTwHlTUt7tZXFRWTWEMTcVjxcnM8NMYDm7TU+mi4pkoNRc3PsTzp
	AEZC+HzD8YEG6cLmPZnxCBMS1kca5ZehUhjM8pSq49IuqRCJjw7GZxdDICwvHFV+
	dHp23s2AhGOh9oiZksndizdd9ZuGQnamv2QVEne/WNrlDdYSvWCWA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B55F31C3E37;
	Sun, 29 Oct 2023 20:15:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11F1C1C3E35;
	Sun, 29 Oct 2023 20:15:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  emilyshaffer@google.com,
  git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Sheik
 <sahibzone@gmail.com>,  Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v3] bugreport: reject positional arguments
In-Reply-To: <3e15f266-c790-4b71-84b6-1328339425c1@gmail.com> (Phillip Wood's
	message of "Fri, 27 Oct 2023 15:41:44 +0100")
References: <20231026005542.872301-1-nasamuffin@google.com>
	<20231026155459.2234929-1-nasamuffin@google.com>
	<CAPig+cTmYtWR=QN3LeN9yw3HmsKEmD2fUiRjKf=eJHhAZyT-yA@mail.gmail.com>
	<3e15f266-c790-4b71-84b6-1328339425c1@gmail.com>
Date: Mon, 30 Oct 2023 09:15:20 +0900
Message-ID: <xmqqbkchge3r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Pobox-Relay-ID:
 69C999C2-76B9-11EE-9E82-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

