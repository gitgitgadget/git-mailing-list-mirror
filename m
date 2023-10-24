Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCACD3F4A8
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049211701
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:20:00 -0700 (PDT)
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4SFQ1q2H5pz5tnw
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 23:19:59 +0200 (CEST)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4SFQ1l3hn3z5tl9;
	Tue, 24 Oct 2023 23:19:54 +0200 (CEST)
Message-ID: <59731c05-c3f6-4815-8411-783bb1c2aac4@kdbg.org>
Date: Tue, 24 Oct 2023 23:19:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: using oldest date when squashing commits
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <YjXRM5HiRizZ035p@ugly>
 <9fae5292-d58f-95da-245b-6e205383cb50@kdbg.org>
 <a99b16a8-a06c-4d38-bb78-46ce17411597@gmail.com> <ZTeZ3KEQLIVU/sq2@ugly>
 <138631cd-ead3-4f22-95ce-61afccfa409f@gmail.com> <xmqqpm143p46.fsf@gitster.g>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqpm143p46.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 24.10.23 um 19:30 schrieb Junio C Hamano:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> "fixup -c/-C" were conceived as a way to reword a commit message at
>> the same time as optionally fixing up the commit's content.
> 
> Yup, it still is a "fix", meaning the identity and the spirit of the
> commit being fixed are unchanged.

That's a pitty, because that is not at all what *I* use "fixup -C" for.
To update the commit message, I use "squash" (or occasionally "reword").
I use "fixup -C" after the following events:

1. Commit unfinished changes for whatever reason. Usually the commit
message just says "WIP <topic>" because that's what it is.
2. Make a fixup commit for an earlier commit because doing the fixup now
gets it out of the way, and often delaying it until after the completed
change would cause merge conflicts.
3. Complete the WIP including the commit message.

I would now use "fixup -C" on commit 3, because its metadata reflects
reality more accurately than that of 1. Commit 3 often comes days after 1.

-- Hannes

