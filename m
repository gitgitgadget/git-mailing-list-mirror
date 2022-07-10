Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C17AC433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 22:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiGJWZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 18:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJWZg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 18:25:36 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920BDE34
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 15:25:35 -0700 (PDT)
Received: from host-78-147-178-211.as13285.net ([78.147.178.211] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oAfMr-0003D2-CX;
        Sun, 10 Jul 2022 23:25:34 +0100
Message-ID: <b9094655-2116-547f-15cb-0a4cce07a960@iee.email>
Date:   Sun, 10 Jul 2022 23:25:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] doc add: renormalize is not idempotent for CRCRLF
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
 <d3b8ed97a105ea1d7e656c964b7eee378e11ede6.1657385781.git.gitgitgadget@gmail.com>
 <xmqqilo6t2qy.fsf@gitster.g> <e45c4fc1-3a30-726c-51f3-00caeca0a552@iee.email>
 <xmqqsfn8pqts.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqsfn8pqts.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/07/2022 23:04, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>>>> +	This option implies `-u`. Lone CR characters are untouched, so
>>>> +	cleaning *^* not idempotent. A CRCRLF sequence cleans to CRLF.
>>> Lack of verb BE somewhere. 
>> '^' It took me three re-reads to see my mistyping as my head knew what
>> I'd meant to write, I've marked above as a note to self.
>> Aside: Are there any guides / suggestions / how-to's for on-line
>> reviewing that you can recommend o
> Sorry, but I do not know of any good "trick" to fight against our
> common tendency to easily miss trivial typoes and thinkos in what we
> ourselves wrote.  We can be surprisingly blind to what a colleague
> can spot immediately, and that is why it helps to have a thorough
> read-through by a reviewer with fresh eyes.  When I was a more
> prolific contributor, I sometimes tried to read aloud what I wrote
> to myself, both docs and code, and caught silly mistakes before
> sending them out to the list, but I do not recommend it to others.

Thanks. There does appear to be a lack of literature or articles in this
area of on-list reviewing

I've not even seen an list of snippets collated from email advice. 
Other than the email etiquette's starter for ten on don't top post ;-)

--
Philip
