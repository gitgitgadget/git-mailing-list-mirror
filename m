Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B86F320966
	for <e@80x24.org>; Fri, 24 Mar 2017 12:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbdCXMj5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 08:39:57 -0400
Received: from siwi.pair.com ([209.68.5.199]:53171 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751731AbdCXMjz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 08:39:55 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0404B84626;
        Fri, 24 Mar 2017 08:39:53 -0400 (EDT)
Subject: Re: [PATCH v2 0/7] thread lazy_init_name_hash
To:     Junio C Hamano <gitster@pobox.com>
References: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
 <xmqqh92jev8d.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5f29c3d9-0de5-385e-fda1-fb4380c7bc17@jeffhostetler.com>
Date:   Fri, 24 Mar 2017 08:39:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqh92jev8d.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/23/2017 1:52 PM, Junio C Hamano wrote:
> The API document update in 4/7 is a nice addition and it comes at
> the right spot in the series, just after API enhancement is done.  I
> gave a quick reading on it twice, and all looked reasonable.  Nicely
> done.

Thanks.

> I queued the sparse things Ramsay pointed out in the form of
> "SQUASH???" immediately that follows your original patch while
> applying the series, so please check what I push out (when it
> happens) and if there is no further change needed, just tell me to
> actually squash them in, if you think these SQUASH??? patches are
> good.  That way we do not have to have another reroll only to fix
> these up ;-)

The squashes look fine.

WRT the assert() in name-hash.c, Stefan suggested converting it
to an if-!-die form in an earlier message in this thread.  I'm OK
with that or with removing the assert completely.

> I'll need to re-read "name-hash: perf improvement for lazy_init_name_hash"
> later again to convince myself, but during my initial read (from the
> last round) I didn't spot anything wrong there.
>
> Thanks.
>

Thanks,
Jeff
