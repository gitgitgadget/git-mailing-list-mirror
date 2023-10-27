Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B79C1EB22
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A8D18F
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 06:08:41 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 3C4B223F67;
	Fri, 27 Oct 2023 09:08:40 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qwMZr-eAD-00; Fri, 27 Oct 2023 15:08:39 +0200
Date: Fri, 27 Oct 2023 15:08:39 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Charvi Mendiratta <charvi077@gmail.com>
Subject: Re: [RESEND v2] git-rebase.txt: rewrite docu for fixup/squash (again)
Message-ID: <ZTu2V/cG35LBtUpo@ugly>
References: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
 <e33f919d-1b6a-4944-ab5d-93ad0d323b68@xiplink.com>
 <ZTg0zXkvSQ6L+4Oj@ugly>
 <b71d066b-104a-4c60-9319-b3c635be6efc@xiplink.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b71d066b-104a-4c60-9319-b3c635be6efc@xiplink.com>

On Fri, Oct 27, 2023 at 08:39:03AM -0400, Marc Branchaud wrote:
>On 2023-10-24 17:19, Oswald Buddenhagen wrote:
>>>> +The commit message for the folded commit is the concatenation of 
>>>> the
>>>> +message of the first commit with those of commits identified by 
>>>> "squash"
>>>
>>> s/message of the first commit/picked commit's message/
>>>
>> that does indeed sound better, but i think it's more confusing (and 
>> potentially even more so when translated directly). i guess one could 
>> use "pick'd commit's", but that's kind of ugly again.
>
>Let the translators worry about how to phrase it in other languages.
>
my experience tells me that this isn't a good idea. translations are 
often done by people who have little domain knowledge of what they 
translate. it's a good idea to guide them.
also, the english text is often read by people who barely understand 
english, and will attempt literal translations in their head.

>In English "picked" is the right choice.
>
the squashed commits also fit the natural use of "picked", because 
"picking" means "selecting". it's not advisable to use this potentially 
ambiguous term when there is an unambiguous alternative way to identify 
the commit available.

>You should not presume that other languages will want to use the word 
>"pick" verbatim.
>
well, i actually should, because it's the command's own name, which 
definitely shouldn't be translated.

regards
