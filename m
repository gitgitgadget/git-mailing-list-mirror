Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB0E7203E2
	for <e@80x24.org>; Tue, 26 Jul 2016 00:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbcGZAit (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 20:38:49 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:33989 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426AbcGZAiq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 20:38:46 -0400
Received: by mail-it0-f41.google.com with SMTP id j8so15740515itb.1
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 17:38:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i+oMpLreMAhAmsJ+xQPP9DFXbfInEhg/5HNdlUg2duQ=;
        b=Fp3VsLwUW5B+nWIudqIslHw7VeRSKrzKwxUuHKSX9qbBWrD/khGWFIy5H0mrXYAr7g
         Ydt8RxSwj0R1+Esx+AD6fXj3A9sEtZWk4l5H6tvvk0CFSmRtT3332+dYfeTOGmldNUVm
         TmhqcmHA9JnWamSyxFTZxdj/o4kkunkpe5cUejDiBir4bAojev61p3Ltpr2qkOzhdOTp
         Ix3LPKRaf83mOPlUju4Mq/BcYYCo/OtKIrUGTct9XqVxGdmUHjRL4Hld749NYpkUyykH
         uyZmnnwCppfPnaUeiDhNlQHgFzQ9E6J6hGm5PjMLtyhtU9yP6uvwL2Wxz3OK6YI7nnkb
         2gXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i+oMpLreMAhAmsJ+xQPP9DFXbfInEhg/5HNdlUg2duQ=;
        b=mEDa8ezjd1PKu4lK7faK2hVfqTcVUyrIvwSHmmFSMfgzPy3uQtfIzUda8dkTkiCvxN
         o3dhl7k2pOxXClym5FRE7ztAs9Xa1F7sRhWM04MQ0bQXYr/037EJv7FF9NKEtS0fmmsR
         Uw2JfvrRPEVUGrLGTEHEgGF/58M/umy8+fgP1pa0IykklLhh/GC+OcpIS3lKHCAbjaCh
         lJ0K1C34rNB0UQZxe1rLV4sI+LSl/B5PExC2N28sSi2BnMxnVSj5g5z9NfotbKG2Ht8w
         BPC0V5sUdtCJQQZNmEe7O3OFAvBO2bPG/8qU8cL/EplVE7OL0pAEifFu97SSDjkaQ5nt
         ZuYg==
X-Gm-Message-State: AEkoouvTrl8iKAW1tuIIqblNeWrJhb/6h6MgKAyHER+3qqBqV5O2l8VMoSdJqdjYsQzfYK+4hd6Y/YcKPOAyWKfU
X-Received: by 10.36.217.12 with SMTP id p12mr24330705itg.46.1469493525515;
 Mon, 25 Jul 2016 17:38:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 25 Jul 2016 17:38:44 -0700 (PDT)
In-Reply-To: <20160719234508.7717-1-sbeller@google.com>
References: <20160719234508.7717-1-sbeller@google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 25 Jul 2016 17:38:44 -0700
Message-ID: <CAGZ79kaJf9jU-fnicnB+jDTOvqOPTJWBy+9oo=fGm82Z8+eQgg@mail.gmail.com>
Subject: Re: [PATCH] Documentation, git submodule: Note about --reference
To:	"git@vger.kernel.org" <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 4:45 PM, Stefan Beller <sbeller@google.com> wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Any comment here?

>
>  Is it too obvious?
>  I was approached off list and this was only obvious after some discussion,
>  so I think it is a valid warning.
>
>  On the other hand this might show that we want to get worktree working with
>  submodules.
>
>  Documentation/git-submodule.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index bf3bb37..dcbd460 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -373,6 +373,10 @@ the submodule itself.
>  +
>  *NOTE*: Do *not* use this option unless you have read the note
>  for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
> ++
> +*NOTE*: This gives the same reference to all submodules, so it is only useful
> +if you are tracking different versions of a project in submodules instead
> +of different projects.
>
>  --recursive::
>         This option is only valid for foreach, update, status and sync commands.
> --
> 2.9.2.800.g213104a
>
