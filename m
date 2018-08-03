Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62B3C208E9
	for <e@80x24.org>; Fri,  3 Aug 2018 14:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbeHCQZm (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 12:25:42 -0400
Received: from mout.web.de ([212.227.15.3]:48227 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732090AbeHCQZm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 12:25:42 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGiLB-1fhSKn3ycb-00DTmw; Fri, 03
 Aug 2018 16:28:49 +0200
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive
 filesystems
To:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Pawe=c5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20180729092759.GA14484@sigill.intra.peff.net>
 <20180730152756.15012-1-pclouds@gmail.com>
 <CABPp-BG+nB+ifRbCdMpXnnxQ+rzhM8W-=sfQf8TYmXvuPy5WXg@mail.gmail.com>
 <xmqqo9enb4n9.fsf@gitster-ct.c.googlers.com>
 <20180731192931.GD3372@sigill.intra.peff.net>
 <xmqqva8v9nc1.fsf@gitster-ct.c.googlers.com>
 <20180731203746.GA9442@sigill.intra.peff.net>
 <xmqqin4v9l7u.fsf@gitster-ct.c.googlers.com>
 <xmqq1sbh7phx.fsf@gitster-ct.c.googlers.com>
 <CACsJy8DFX2=CaTomc33uuHQ-nBvgfutVbaQ2DxT_p8-hzj6PsA@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <c4ce4d55-ad10-55b0-0cb0-89025102210c@web.de>
Date:   Fri, 3 Aug 2018 15:28:38 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8DFX2=CaTomc33uuHQ-nBvgfutVbaQ2DxT_p8-hzj6PsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:GweqBmx/Mt5DpfV50x6WXEr6APrNS34bIRCdts2xuJz21klxTR2
 0oR6QeAV55kvmIz8GwwZ91wex734nQlaVOcWbvFJ5JYQzGnFhO4X+t1gNmF1uCi/kszndws
 eyr7VMOJ4ObhVpLBtq/uQ/CoPL548+QJqNYFdQVtE/ntJ6ygvT/64i+AjLE8uaGjYOj4/TS
 aT+U3/MV6nCavbbrfUJrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dm+mDMQ+Ou0=:zfZmDKAZEZF7tvEIZXdMZk
 Ld4ZE7hKSyntgIFnQJsG5+bDc29Lj8n3fsQ4B7QHyMNorsEpijZ8TmBXKTW9UfVuY3EUvb5nh
 elN63cyM8e/Nseya5HDsGegHjdjq2elE+jxiJzfss9GX+I3Nnl7yiZZF+W1Oz5gjyFyI72HIn
 aAI7IpcNOubkitvSpwj9eCDBTPMoQZq5vnycib89go63jfDhwvxlfCB2Pb6oSRa47rO0D1EX3
 9v8cnQoeqLTEPghpA926RIjhAwcaECO4t+sjiri8Xn0+i+YIl+TNGB1gBEuN39cN8b2gjnVH1
 4RrhmqHeP/0aXVT1EjxsoLrcd/3uJspkD7lC6rlz1yT1wNOb8iZNZkO2bUL15Eikph46L/wNt
 LNvDYlc3V9l8t6W3UhxRG//RlhqxBoEr0qCMEui0041VfDhi1zgbNZyGJ1IFUfXIpbg/XEwCX
 KluCZmRxZ7mVsItGTW+Tzevpz6F4vAFyL3xo1fyGI92/LUKwltMrz3rbxtwCgH7cY/Ajdg+a2
 YgF1sas/9cG/tCa8uPfPAJchXoChe7mXrLdFZk9v8N9hcdYAweL8ggi0vX3IeJDovPgG1Irnk
 qIwlSBw5hsqnmjucrDZs1NynowllryNDMI4MMpV1S4ouoYgNgDjnY/A3bLntK7+KFJC9BNDVL
 toELcrPhVxgarvn9nc8FkXXgRLnpc+un1nO2N1krFlAKbppxYynpzhxicfY4dc7p542lrIO//
 eid1zwFaAS2SEbM6zAn2HdUNfHxwnfCG+ikOMUVcKNPnKyuoRGtQVYtbHmlLpxhsL+xvhat/S
 BK4EbYZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-08-02 15:43, Duy Nguyen wrote:
> On Wed, Aug 1, 2018 at 11:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Jeff King <peff@peff.net> writes:
>>>
>>>>> Presumably we are already in an error codepath, so if it is
>>>>> absolutely necessary, then we can issue a lstat() to grab the inum
>>>>> for the path we are about to create, iterate over the previously
>>>>> checked out paths issuing lstat() and see which one yields the same
>>>>> inum, to find the one who is the culprit.
>>>>
>>>> Yes, this is the cleverness I was missing in my earlier response.
>>>>
>>>> So it seems do-able, and I like that this incurs no cost in the
>>>> non-error case.
>>>
>>> Not so fast, unfortunately.
>>>
>>> I suspect that some filesystems do not give us inum that we can use
>>> for that "identity" purpose, and they tend to be the ones with the
>>> case smashing characteristics where we need this code in the error
>>> path the most X-<.
>>
>> But even if inum is unreliable, we should be able to use other
>> clues, perhaps the same set of fields we use for cached stat
>> matching optimization we use for "diff" plumbing commands, to
>> implement the error report.  The more important part of the idea is
>> that we already need to notice that we need to remove a path that is
>> in the working tree while doing the checkout, so the alternative
>> approach won't incur any extra cost for normal cases where the
>> project being checked out does not have two files whose pathnames
>> are only different in case (or checking out such an offending
>> project to a case sensitive filesytem, of course).
>>
>> So I guess it still _is_ workable.  Any takers?
> 
> OK so we're going back to the original way of checking that we check
> out the different files on the same place (because fs is icase) and
> try to collect all paths for reporting, yes?

I would say: Yes.

> I can give it another go
> (but of course if anybody else steps up, I'd very gladly hand this
> over)
> 

Not at the moment.


