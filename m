Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90D0200E0
	for <e@80x24.org>; Thu, 29 Dec 2016 10:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbcL2KHF (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 05:07:05 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:34317 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752399AbcL2KHE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 05:07:04 -0500
Received: by mail-io0-f178.google.com with SMTP id p42so350151881ioo.1
        for <git@vger.kernel.org>; Thu, 29 Dec 2016 02:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t5RUFV4rXkoKCFutDJfW6ZK6iREpklFjb1Y0RDN8+fs=;
        b=m/SYNF79s+lSoO98fjIcLJVlXINnr27knQrzLcDPXZTwzf/bh4QVNHygTfHfh6AaNT
         Bu+QppkT+rytJSo5eNu/UEqVelt8Cq2jZPRvOHFOiJTOXx8GI30LMBYKQH73SKyQ15VQ
         8jHZWqt8mZaf36ffVx6DqLVy8r9AAAo2hAJ0FrCRfECbomx6RYsuDvgi2MpPYURgMuTu
         N/IXJQL6ZjHUmSPX17Iee4Au1N2AEyqt/8kkm0yJLjZjKKtRPKLTQD/B1TLVHN5iJtB2
         plzCzaAjbh/a0vzBTZaF7jP7+fglqsxqfeo/wAiwdmaQino2cfRaBigLEXHfj0vWBBoh
         B6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t5RUFV4rXkoKCFutDJfW6ZK6iREpklFjb1Y0RDN8+fs=;
        b=nmnsTOiaRQuupcQALTy3AUCMAh9UYiUQ1Y7pGNqFAr3HY7wyfPJaKBCTh2jWbTIgbe
         Hs6BQCVLS1scdkwdOY2zgHiFSAr5V0YH9muct433hgKxmH5aHA15i4NW7PrVBYJO0U/r
         o7cyNBeE+DnPe7IfCqv1hglei50RQA3FMrrV+L6w2DlydRK46m2Fn8C0gMZQoZZ8G7z3
         W6lKraWUa6uW/4w6FV2ossMIvX0mxlfqgmwhpe0mip/gUJzTJNwsPBq2+p1hoGNBL/RP
         DqNWeLX/POi00aYQD5iF20VjTOh4XloyeLL7Ouyoov3RoE1o5K4QIjEE9Nl0x2gMR7tP
         APIw==
X-Gm-Message-State: AIkVDXLsZPDspTnE2FZKe6hR+b5r1ZwjGw27FLJL0+ziSWbY5Cj5kQsr6HdnUBT2/nDcGsGuYSbUUWHWH4eBBw==
X-Received: by 10.107.59.9 with SMTP id i9mr35697587ioa.176.1483006023435;
 Thu, 29 Dec 2016 02:07:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 29 Dec 2016 02:06:32 -0800 (PST)
In-Reply-To: <20161228181808.GC33595@google.com>
References: <xmqqy3z155o1.fsf@gitster.mtv.corp.google.com> <20161228181808.GC33595@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 29 Dec 2016 17:06:32 +0700
Message-ID: <CACsJy8CmKBpWa=yi44vGUe56CmeT-Swh_M_XxMeA+xkLLUhQ3Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2016, #08; Tue, 27)
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 29, 2016 at 1:18 AM, Brandon Williams <bmwill@google.com> wrote:
> On 12/27, Junio C Hamano wrote:
>> * bw/pathspec-cleanup (2016-12-14) 16 commits
>>  - pathspec: rename prefix_pathspec to init_pathspec_item
>>  - pathspec: small readability changes
>>  - pathspec: create strip submodule slash helpers
>>  - pathspec: create parse_element_magic helper
>>  - pathspec: create parse_long_magic function
>>  - pathspec: create parse_short_magic function
>>  - pathspec: factor global magic into its own function
>>  - pathspec: simpler logic to prefix original pathspec elements
>>  - pathspec: always show mnemonic and name in unsupported_magic
>>  - pathspec: remove unused variable from unsupported_magic
>>  - pathspec: copy and free owned memory
>>  - pathspec: remove the deprecated get_pathspec function
>>  - ls-tree: convert show_recursive to use the pathspec struct interface
>>  - dir: convert fill_directory to use the pathspec struct interface
>>  - dir: remove struct path_simplify
>>  - mv: remove use of deprecated 'get_pathspec()'
>>
>>  Code clean-up in the pathspec API.
>>
>>  Waiting for the (hopefully) final round of review before 'next'.
>
> What more needs to be reviewed for this series?

I wanted to have a look at it but I successfully managed to put if off
so far. Will do soonish.
-- 
Duy
