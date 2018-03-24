Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7FCF1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750825AbeCXHup (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:50:45 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:39809 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeCXHuo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:50:44 -0400
Received: by mail-it0-f47.google.com with SMTP id e98-v6so5223233itd.4
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dRI6rLvnvfKGCDewgc6WGPlg9UW89JAHhPEp/UqUzaw=;
        b=gUWGDqVDjR/xtC6rtVHcLPAcEL9CQ5AhCp0ZYPy749sq+bv/h1K+YvkR1umD/kGlgb
         bY7eOXEv3uTbxQOpnSIzKUBRUMwq6rtU2NYRa1rK+9Mcf5rGqyNzpf6sdODMVqNVfaBp
         BqTOPmPgquCtZM/EkzmBscGsOuCEx/WcFz9ILPFG2zaUWslqBIQmJPP1Gc9St70Eu9+X
         GoCtLVGtt03Hhv9KLYdCZGHisnUg/w3tzqq7oPgqHskMn2H8c1/YutmVAde6qvGvvrvI
         j5KtU+sOiBH69QP++jSwWv6upK2EQuqjO49yQNerJHNCOY0GAdvBRsmjOPvJvwBSVA2e
         8RxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dRI6rLvnvfKGCDewgc6WGPlg9UW89JAHhPEp/UqUzaw=;
        b=ZR5o32I9+/JAwZ2vY8/MXUfFbWIdHhUeTxjdcBFRHWGID/7G1pfmBIf99caPsZ0KDB
         CdnHPuZfBrfaThbeihMP638c1pPMjVZNZfBTznTDD/hoRApPPjQYQzHw5pJ1LOm8fqj2
         07eIRGAGhlx2c39edLkt2nc9CM9N4pxZx46culJh40NfGDXTaaWr9bleA5PuZIuNcath
         OGPiEKHpqxYS/gh6vBHZ3p4A4lfwtA1jwwQshITIzfp+TFOkW+1Q7ZBS6myLadczdWzc
         7RWuPixNGZCOOTYvf5HQwTEM/ekPYW+Zvmd82iMmNqRMO7wgKcKXDgrktQZhuUHPY0Fa
         6HsA==
X-Gm-Message-State: AElRT7HatfM2jqNyJzTMgtee3yg0ei5N+yPx6OXonbnLTE08iu6hMLiQ
        hvwO1mmS3FWSfeyiliMguKtaFMmu8/+fkokXGUs=
X-Google-Smtp-Source: AG47ELukiTPtNtGU7DXKmUEIjIdqkOggDvdZeaUt8a6ACroFSXZ+827QE35OCfaEXLw/8x5Ph6VjHmXC6yt/dcCtH8A=
X-Received: by 2002:a24:fa89:: with SMTP id v131-v6mr16431867ith.40.1521877844224;
 Sat, 24 Mar 2018 00:50:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Sat, 24 Mar 2018 00:50:43 -0700 (PDT)
In-Reply-To: <20180324043205.31976-1-predatoramigo@gmail.com>
References: <20180324043205.31976-1-predatoramigo@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 24 Mar 2018 08:50:43 +0100
Message-ID: <CAP8UFD2D-XU=YeJD7A+9wauu0WKHwkXgVxbEBkOGPyZE7GiOZA@mail.gmail.com>
Subject: Re: [GSoC] Info: git log --oneline improvements
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Mar 24, 2018 at 5:32 AM, Pratik Karki <predatoramigo@gmail.com> wrote:
>
> Hi Christian and Johannes,
>
> I will like to send another proposal on git log --oneline improvements.
> My first proposal[1] was on "Convert scripts to builtins". Can
> you provide me information about "git log --online improvements"
> and point me to resources where I should focus on my proposal.

On the Idea page (https://git.github.io/SoC-2018-Ideas/) there are the
following links:

https://public-inbox.org/git/xmqqeg42fslw.fsf@gitster.mtv.corp.google.com/T/#t
http://public-inbox.org/git/CA+55aFwT2HUBzZO8Gpt9tHoJtdRxv9oe3TDoSH5jcEOixRNBXg@mail.gmail.com/

so a good idea to start writing a proposal would be to summarize the
possible improvements that are discussed in these threads.

Thanks.
