Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56D9F1FA14
	for <e@80x24.org>; Sun, 16 Apr 2017 04:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbdDPEjM (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 00:39:12 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:49629 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750896AbdDPEjL (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 00:39:11 -0400
X-AuditID: 1207440f-129ff70000003517-01-58f2f56c1b0c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 09.18.13591.C65F2F85; Sun, 16 Apr 2017 00:39:10 -0400 (EDT)
Received: from [192.168.69.190] (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G4d5SY020898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 00:39:06 -0400
Subject: Re: [PATCH v2 03/20] refs_ref_iterator_begin(): new function
To:     Duy Nguyen <pclouds@gmail.com>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
 <840b199ad58f11a690c684ad110807ed81d3b0eb.1490966385.git.mhagger@alum.mit.edu>
 <CACsJy8CECcC1EDpr8u39Pzq75E5KXrYwm_Bz+UTXobWvgV5weA@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Git Mailing List <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <3b508517-80fc-d759-d27f-a582a36286ba@alum.mit.edu>
Date:   Sun, 16 Apr 2017 06:39:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CECcC1EDpr8u39Pzq75E5KXrYwm_Bz+UTXobWvgV5weA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42IRYndR1M37+inCYOYNdou1z+4wWXRd6Way
        aOi9wmyx5OFrZovuKW8ZLX609DBbbN7czuLA7rFz1l12jwWbSj262o+weTzr3cPocfGSssfn
        TXIBbFFcNimpOZllqUX6dglcGZMf3mQqeChZMXvfF8YGxrsiXYycHBICJhJ/ug6wdzFycQgJ
        7GCSePP4FxuEc45JYu/KNnaQKmEBV4ld17YxgtgiAkoSbzq2MYPYQgLnGSX2NXuDNDALTGSS
        OPHlIRNIgk1AV2JRTzOQzcHBK2Av8WO7CUiYRUBVYtLXt2C9ogIhEnMWPgCbySsgKHFy5hMW
        EJtTIFBi498NYDXMAuoSf+ZdgrLlJba/ncM8gZF/FpKWWUjKZiEpW8DIvIpRLjGnNFc3NzEz
        pzg1Wbc4OTEvL7VI10QvN7NELzWldBMjJMz5dzB2rZc5xCjAwajEw2vh/ylCiDWxrLgy9xCj
        JAeTkiiva8zHCCG+pPyUyozE4oz4otKc1OJDjBIczEoivD9OA5XzpiRWVqUW5cOkpDlYlMR5
        1Zeo+wkJpCeWpGanphakFsFkZTg4lCR4U74ANQoWpaanVqRl5pQgpJk4OEGG8wAN9wKp4S0u
        SMwtzkyHyJ9iVJQS5038DJQQAElklObB9cLS0CtGcaBXhHnPgbTzAFMYXPcroMFMQIMZJn8A
        GVySiJCSamB0iJrn7dM0UfrKsnqJIiPRlRanogV2Vns7zPGr6LrQs+rUrH1Ll89QFAl08XVm
        Fnts+i/o9f9o/lsXVf+f3Hj5w9FJ8qJJh20uflDp8OjLY57wwC0psjj537NIp/oLj4vvvPhZ
        2lP5vEPblW9VtEbzrqSnZxYsPv7/wO45s78sKI2YzfjKSDpdiaU4I9FQi7moOBEAvAKHrx4D
        AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/07/2017 12:57 PM, Duy Nguyen wrote:
> On Fri, Mar 31, 2017 at 9:11 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Extract a new function from `do_for_each_ref()`. It will be useful
>> elsewhere.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  refs.c               | 15 +++++++++++++--
>>  refs/refs-internal.h | 11 +++++++++++
>>  2 files changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 0ed6c3c7a4..aeb704ab92 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1230,6 +1230,18 @@ int head_ref(each_ref_fn fn, void *cb_data)
>>         return head_ref_submodule(NULL, fn, cb_data);
>>  }
>>
>> +struct ref_iterator *refs_ref_iterator_begin(
>> +               struct ref_store *refs,
>> +               const char *prefix, int trim, int flags)
>> +{
>> +       struct ref_iterator *iter;
>> +
>> +       iter = refs->be->iterator_begin(refs, prefix, flags);
>> +       iter = prefix_ref_iterator_begin(iter, prefix, trim);
> 
> Off topic. This code made me wonder if we really need the prefix
> iterator if prefix is NULL. And in fact we don't since
> prefix_ref_iterator_begin() will return the old iter in that case. But
> it's probably better to move that optimization outside. I think it's
> easier to understand that way, calling prefix_ref_ will always give
> you a new iterator. Don't call it unless you want to have it.

I like this aspect of the design because it is more powerful. Consider
for example that some reference backend might (e.g., a future
`packed_ref_store`) need to use a `prefix_ref_iterator` to implement
`iterator_begin()`, while another (e.g., one based on `ref_cache`) might
not. It would be easy to make `prefix_ref_iterator_begin()` check
whether its argument is already a `prefix_ref_iterator`, and if so, swap
it out with a new one with different arguments (to avoid having to stack
them up). It would be inappropriate for the caller to make such an
optimization, because it (a) shouldn't have to care what type of
reference iterator it is dealing with, and (b) shouldn't have to know
enough about `prefix_ref_iterator`s to know that the optimization makes
sense.

>> +/*
>> + * Return an iterator that goes over each reference in `refs` for
>> + * which the refname begins with prefix. If trim is non-zero, then
>> + * trim that many characters off the beginning of each refname. flags
>> + * can be DO_FOR_EACH_INCLUDE_BROKEN to include broken references in
>> + * the iteration.
>> + */
> 
> Do we need a separate docstring here? I think we document more or less
> the same for ref_iterator_begin_fn (except the include-broken flag).

There is a subtle difference: currently, `ref_iterator_begin_fn()`
doesn't use its full `prefix` argument as prefix, but rather
`find_containing_dir(prefix)`. (This is basically an implementation
detail of `ref_cache` leaking out into the virtual function interface.)

`refs_ref_iterator_begin()`, on the other hand, treats the prefix
literally, using `starts_with()`.

I don't like this design and plan to improve it sometime, but for now
that's an important difference. The fix, incidentally, would motivate
the `prefix_ref_iterator_begin()` optimization mentioned above.

Michael

