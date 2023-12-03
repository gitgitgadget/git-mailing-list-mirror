Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JxHgkWPA"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D15135
	for <git@vger.kernel.org>; Sun,  3 Dec 2023 05:19:36 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DF151C8A79;
	Sun,  3 Dec 2023 08:19:36 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Nkl3YhryhocMdoWhRcigvD91Zwe9ViJigMLIsP
	FZhGI=; b=JxHgkWPAu/2B3iCJIyqUfU6O647+azvAY4E8tbW+DRO024KrAt14En
	bDr3oskaMP7ufApAxeC0vkVEgA7k5tbvEG57m/vSFN5LPMBBxdb2nHm9PEplz/fb
	zhLcenmOLYPFmE1cF8vsjnNvDtBNhIWCKstITA5fOB1BrjV9WueDU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 36C6D1C8A78;
	Sun,  3 Dec 2023 08:19:36 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A06C21C8A77;
	Sun,  3 Dec 2023 08:19:35 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,  git@vger.kernel.org
Subject: Re: [Patch] test-lib-functions.sh : change test_i18ngrep to test_grep
In-Reply-To: <ZWw6r2EDGkpgyYEM@five231003> (Kousik Sanagavarapu's message of
	"Sun, 3 Dec 2023 13:52:07 +0530")
References: <ZWw6r2EDGkpgyYEM@five231003>
Date: Sun, 03 Dec 2023 22:19:34 +0900
Message-ID: <xmqq34wj4e55.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9A8C918C-91DE-11EE-BB01-25B3960A682E-77302942!pb-smtp2.pobox.com

Kousik Sanagavarapu <five231003@gmail.com> writes:

> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> wrote:
>
>> Subject: [Patch] test-lib-functions.sh : change test_i18ngrep to test_grep
>
> For anyone reading the subject, I think reading
>
> 	change test_i18ngrep to test_grep
>
> would be confusing, as from the looks of it, the patch does remove
> test_i18ngrep() and replace it with test_grep (I mean the plan is to
> remove test_i18ngrep only after we are sure that it doesn't exist in the
> code anywhere, anymore) but only making a change in the wording of an
> error message within test_grep().

;-)  

Yes, that was exactly my reaction to the subject (I'm on
vacation so I only scanned the subject lines of incoming patches
without looking at anything else and thought "hmph, it is good
somebody else is cleaning up new uses of test_i18ngrep that have
been introduced by topics simultaneously in flight").
