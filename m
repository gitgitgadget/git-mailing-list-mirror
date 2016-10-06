Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273C5207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 12:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755882AbcJFMbT (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 08:31:19 -0400
Received: from mail.javad.com ([54.86.164.124]:60310 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755616AbcJFMbS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 08:31:18 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 3896F633DB;
        Thu,  6 Oct 2016 12:30:59 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1bs7pB-0003Pl-DT; Thu, 06 Oct 2016 15:30:57 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] Documentation/git-merge.txt: improve short description in DESCRIPTION
References: <cover.1475678515.git.sorganov@gmail.com>
        <e74ae8afc1bfc4cd9161ccaa56d926a89439551e.1475678515.git.sorganov@gmail.com>
        <xmqq60p6pt4k.fsf@gitster.mtv.corp.google.com>
        <871szuqyjo.fsf@javad.com>
        <xmqqa8eio4n9.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 06 Oct 2016 15:30:57 +0300
In-Reply-To: <xmqqa8eio4n9.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 05 Oct 2016 14:41:14 -0700")
Message-ID: <87mvihpsla.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> OK, I see. So, what is the best way to handle this? Immediately follow
>> content change patch with another patch that only re-flows?
>
> Or no reflowing at all.
>
>>> the parents".  I do not know if the updated phrasing is better.  The
>>> "name" in the original was meant to be a short-hand for "object name",
>>> and I would support a change to spell it out to clarify; "reference"
>>> can be a vague word that can mean different things in Git, and when
>>> the word is given without context, most Git people would think that
>>> the word refers to "refs", but that is definitely not what the new
>>> commit records, so...
>>
>> I won't insist on the change, but "name" sounded wrong to me, and
>> "reference" was most general term I was able to come up with in this
>> context.
>> ...
>> Last, if "reference" is not good enough and we get to internals anyway,
>> why not say SHA1 then?
>
> Because that is still colloquial? I think s/name/object name/ is a
> sensible change, but not s/name/reference/.

No, "reference" is more sensible here than any of "name", "object name",
or "SHA-1", the same way as here:

$ git help glossary
[...]
chain
        A list of objects, where each object in the list contains a
        reference to its successor (for example, the successor of a
        commit could be one of its parents).
[...]
$

The resulting merge commit is an origin for 2 chains, so it stores 2
references to its successors. No need to be aware of any [object] names
to understand all this.

-- Sergey
