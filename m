Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DCDF202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 10:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbdJBKQi (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 06:16:38 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37990 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdJBKQi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 06:16:38 -0400
Received: by mail-pf0-f194.google.com with SMTP id a7so5274739pfj.5
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 03:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z308sBf+0iSMFZb4TyZq7GNaNaipdOefQy342GMFycQ=;
        b=gDCQwwi/4Dk49TyWHg7exh4imfkhbHyroeaGS/apXsRlDKNWPThzgVRZKUKKCj1+Le
         2dBSLQqxgNE4tmFQOJNMJf0bpvNqAAnACLbrnwHFQudMBkOdihL9brG9stdYlk+i6Mr1
         qpJ3+94IsIGGCvoaixFpAnvHwA8iVeP+ssOTtl9dw6axfPPMVB59tXM7p4VWZSkB7bSH
         3Ftuf5GoASSkytwK/637R74nN9o7iSdlELbopE8KXtJmya/z9U6N/oGI4z7AGMit3MZ8
         vZjrczrPIimHXJxDcFPQ8Lzj+b3AGqDze+9QNRmCue9JDy3pJHXW0aSvOGqRo9zsjaK7
         GZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z308sBf+0iSMFZb4TyZq7GNaNaipdOefQy342GMFycQ=;
        b=NRCLiOGFwN+Nl/C/WVwJPTMuUspXpZlqGceuxBNCsyxdjE7hrYP1ZRdOX4TTs8Gs+U
         9xxVIimcjdZAEBgIRFDvoJl1rg2pIsbp9KoOkwIf6Vg6LTcm/6GEiAQmIV0Apdz8+xaQ
         M8C6sSub8Ns73k7PsswoprUkvfxbGqYsrJdP+Papn0lZLj2+oZ/bwhaZCIuIADFrGITM
         kRN682QNNOF1ap4Qm4opqwvU+UFlQdaunL9pxoGEQHbqFeeAEzGAUv9dnItTPBroz5ds
         YfZFAUVTy35Fzy0qH9TYckYojqVDjtdmzz9VfWwMBI7gNYaa8OSbv+KHmhocooQ7MFs9
         LPVg==
X-Gm-Message-State: AHPjjUgxMj+eHI/QPYkHrBXvM7LOEJ1jg+7p48l/uqsP0hZpyB2QuCRU
        hSk4bm6FbDAWFGkI+k8Hh8jpaQFAgU46IXBb7rVLhA==
X-Google-Smtp-Source: AOwi7QB/6Hgne4AeFcH4MLIf1lSl/fXsoSS7o7OuUTj4yIhXwyLvFZsumfmsR1pt89HSQk5fTwzlmjloewbfVIP1qKs=
X-Received: by 10.84.129.131 with SMTP id b3mr14124823plb.337.1506939397533;
 Mon, 02 Oct 2017 03:16:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Mon, 2 Oct 2017 03:16:36 -0700 (PDT)
In-Reply-To: <CAN0heSqPVpgYSfUpmiBaCVtZkMiqWC3rgzFcBu2TVr3m7Gq4UA@mail.gmail.com>
References: <cover.1506862824.git.martin.agren@gmail.com> <d912e33a1395ff25c1496715d0a537858daa885a.1506862824.git.martin.agren@gmail.com>
 <xmqqd166qkeg.fsf@gitster.mtv.corp.google.com> <CAN0heSqPVpgYSfUpmiBaCVtZkMiqWC3rgzFcBu2TVr3m7Gq4UA@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 2 Oct 2017 12:16:36 +0200
Message-ID: <CAN0heSpRqicsghBd5WruG9kyPqQbx8MHOP0afW9HNEpNDyp9eg@mail.gmail.com>
Subject: Re: [PATCH 09/11] read-cache: require flags for `write_locked_index()`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2 October 2017 at 06:14, Martin =C3=85gren <martin.agren@gmail.com> wrot=
e:
> On 2 October 2017 at 05:49, Junio C Hamano <gitster@pobox.com> wrote:
>> Martin =C3=85gren <martin.agren@gmail.com> writes:
>>
>>> ... Instead, require that one of the
>>> flags is set. Adjust documentation and the assert we already have for
>>> checking that we don't have too many flags. Add a macro `HAS_SINGLE_BIT=
`
>>> (inspired by `HAS_MULTI_BITS`) to simplify this check and similar check=
s
>>> in the future.
>>
>> I do not have a strong opinion against this approach, but if
>> something can take only one of two values, wouldn't it make more
>> sense to express it as a single boolean, I wonder.  Then there is no
>> need to invent a cute HAS_SINGLE_BIT() macro, either.
>>
>> "commit and leave it open" cannot be expressed with such a scheme,
>> but with the HAS_SINGLE_BIT() scheme it can't anyway, so...
>
> I did briefly consider renaming `flags` to `commit` and re-#defining the
> two flags to 0 and 1 (or even updating all the callers to use literal
> zeros and ones). It felt a bit awkward to downgrade `flags` to a bool
> -- normally we'd to the reverse change. But maybe I shouldn't have
> rejected that so easily. If we have a feeling we won't need other flags
> (or the "don't even close the file") any time soon, maybe it'd be good
> to tighten things up a bit. Thanks for looking at these.

Of course it wouldn't have to be as invasive. It could be "the lock will
always be closed and with COMMIT_LOCK, it will also be committed".
CLOSE_LOCK would be removed and the few current users of CLOSE_LOCK
would be converted to use 0.
