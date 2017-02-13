Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8C01FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 21:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbdBMV1a (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 16:27:30 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33357 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbdBMV12 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 16:27:28 -0500
Received: by mail-lf0-f54.google.com with SMTP id x1so57278361lff.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 13:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xdewBFWcL+B7sjoCaGLdopiAfp7ip1rUSY3SmH3+J04=;
        b=d3azoskeJBDFcInx6PkI6FEnjt8V/SLePcMDWUMQ6Om/OkT2bH2NsWjeI9E7rVrrOo
         iwvWGI89yApqUinpd1hY+lUji/hpmv8b07BLvZ+zS3qg/+yhvBf5OT3Cz1l7SGl1DwZY
         UDYxE57hgWjWNgfIIFvSv6rQpFIeMaiaWxtqxIl09JxgcHyYiGtwEi8iDbFoI1a+QEsM
         NTO0S3lyZmFf1rdWnpLRA1G0dSIoog+wxpeTkx8j5tpDAyPwQ86oNiLxBUhnyPoHbnd3
         YS69BXBfKJVflBUFjuiR+SXH43F/3SzMykWm6EeC11yySY6aJXMVTazfTHFWdbW0n1UN
         q3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xdewBFWcL+B7sjoCaGLdopiAfp7ip1rUSY3SmH3+J04=;
        b=shv5pVf8cUgkQFnYsnlpiVKiO4ya9GOEosFtdJygW147J61U89zSN6W3sk18R5G6Eh
         uPkZ+BkZrWofG6SRiAO4GHhof1qhsswFfmKjG9wfGD0rgIyFpOduoiADslooHdBoVu+x
         Xo1ZXPluOqvVzYYdnaxSxO4V5xm3FZMDTztleYwr4BrHiM+3okM8AD/KYU+iJgRb76F3
         sOHl1+1jbH+tsVj6PPACC/fwzxuGHetPU2baeyDXs6F3DiQ17/dJOSOB/IeEq3nMUq8k
         M+vxpLFrDRpaFVSAKkpf4U4+C8dERxhGikKuwFGxpoTFuTc9/kSWvED2xE4pfXinAtuN
         Gilw==
X-Gm-Message-State: AMke39n3sfxo1PLhiwvTyjpu+ju+JD5K2V1K47adGD+6C7X8ARkqeL3ZLVkVa6T5ghAlRfRULkQk9euL6IHKrA==
X-Received: by 10.25.67.83 with SMTP id m19mr6029712lfj.24.1487021247090; Mon,
 13 Feb 2017 13:27:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Mon, 13 Feb 2017 13:27:26 -0800 (PST)
In-Reply-To: <8b6e998d-2bea-924b-42e3-936dcd9a2995@gmail.com>
References: <8b6e998d-2bea-924b-42e3-936dcd9a2995@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 13 Feb 2017 22:27:26 +0100
Message-ID: <CAP8UFD3N0Qme51T-dWs5DxL-FowEBaFBzHCAi=U3UG1Sbh4O7g@mail.gmail.com>
Subject: Re: [RFH] Request for Git Merge 2017 impressions for Git Rev News
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Feb 11, 2017 at 5:33 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> Hello,
>
> Git Rev News #24 is planned to be released on February 15. It is meant
> to cover what happened during the month of January 2017 (and earely
> February 2017) and the Git Merge 2017 conference that happened on
> February 2nd and 3rd 2017.

Yeah, I would have liked to release Git Rev News #24 on February 15
but I was busy and tired this week end, so let it be on Wednesday
February 22.

> A draft of a new Git Rev News edition is available here:
>
>   https://github.com/git/git.github.io/blob/master/rev_news/drafts/editio=
n-24.md
>
> I would like to ask everyone who attended the conference (and the
> GitMerge 2017 Contributors=E2=80=99s Summit day before it), or watched it=
 live
> at http://git-merge.com/watch to write his or her impressions.
>
> You can contribute either by replying to this email, or by editing the
> above page on GitHub and sending a pull request, or by commenting on
> the following GitHub issue about Git Rev News 24:
>
>   https://github.com/git/git.github.io/issues/221
>
> If you prefer to post on your own blog (or if you have did it
> already), please send an URL.

Yeah, any material (link, short impression, article, ...) would be very nic=
e.
Thanks Jakub for the links you already added to the draft, by the way!

> P.S. I wonder if there should be not a separate section on
> https://git.github.io/ about recollection from various Git-related
> events, with Git Merge 2017 as the first one.  This way we can wait
> for later response, and incorporate videos and slides from events, as
> they begin to be available.

Jakub, if you are willing to create and maintain this section, that
would be great!

> P.P.S. Please distribute this information more widely.

Thanks,
Christian.
