Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CBF47F5F
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QCYxuXjV"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0756F1C9674;
	Wed, 10 Jan 2024 17:38:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MR0ZWt321F1nlDMexFaJmOab4tfDrkSy1TtqQv
	9dvCc=; b=QCYxuXjVQdL9md3y3v747NehdSVG8Ec35LpF2toTadUk+AcIVZa3ek
	kE/8oUBgXHAEf9TD/Npkrb19CI1MFAwcz2qou7o6O3mTeNwTfXHYdgdGLRm6qwj/
	8NRqBNM+pIlFhlLDMTCpNdpVZYA1bn05EwMm2Mt4ovwRbPpER5Wkg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E90C61C9673;
	Wed, 10 Jan 2024 17:38:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54A8D1C9672;
	Wed, 10 Jan 2024 17:38:17 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] doc: bisect: change plural paths to singular
 pathspec
In-Reply-To: <ZZWWmXHa8ebtkZQ8@nand.local> (Taylor Blau's message of "Wed, 3
	Jan 2024 12:17:13 -0500")
References: <a5a8c257-8550-492e-a6fa-e88ee59d4d66@smtp-relay.sendinblue.com>
	<6bcbd017-968e-4ac8-a56b-164b163c76d4@smtp-relay.sendinblue.com>
	<ZZWWmXHa8ebtkZQ8@nand.local>
Date: Wed, 10 Jan 2024 14:38:16 -0800
Message-ID: <xmqqbk9s95lz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F2BAF25C-B008-11EE-9731-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Jan 02, 2024 at 07:02:05PM -0900, Britton Leo Kerin wrote:
>> Britton Leo Kerin (2):
>>   doc: use singular form of repeatable path arg
>>   doc: refer to pathspec instead of path
>>
>>  Documentation/git-bisect.txt | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> Range-diff against v1:
>> 1:  90c081dcab ! 1:  da40e4736b doc: use singular form of repeatable path arg
>>     @@ Commit message
>>          later document text mentions 'path' arguments, while it doesn't mention
>>          'paths'.
>>
>>     -    Signed-off-by: Britton L Kerin <britton.kergin@gmail.com>
>>     +    Signed-off-by: Britton Leo Kerin <britton.kergin@gmail.com>
>>
>>       ## Documentation/git-bisect.txt ##
>>      @@ Documentation/git-bisect.txt: The command takes various subcommands, and different options depending
>> -:  ---------- > 2:  d932b6d501 doc: refer to pathspec instead of path
>> --
>> 2.43.0
>
> Hmm. The end-state of these two patches looks good to me, but I probably
> would have written this change as a single change from "paths" ->
> "pathspec", not "paths" -> "path" -> "pathspec".

Have we seen a resolution to this comment?  I _think_ it is an OK
approach to take to do this in two steps, if the use of technical
term "pathspec" could be controversial, but since it is not, I am
fine with either one or two patches.  Since we already have the
two-patch version, let's take it.

Thanks.
