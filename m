Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A3CB20A17
	for <e@80x24.org>; Tue, 17 Jan 2017 01:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750827AbdAQBeH (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 20:34:07 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35971 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbdAQBeH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 20:34:07 -0500
Received: by mail-lf0-f65.google.com with SMTP id h65so14425351lfi.3
        for <git@vger.kernel.org>; Mon, 16 Jan 2017 17:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uDuo3UWzYq1eZ/qfYOwZH3HI4sOxwHlg0J1G1/2Okbo=;
        b=ZIIVebyli31twCDsbyDfgoqIpg0Jzs6+IuBokY1qm0SdgoDjMCT+YPURr5KiK00bAg
         tfWq8mtsay7hJnQGmIhhA18JrhqBCE1vH95B7w5QfrE+vGjyBDaSkPgN7yhqiVK0UeYi
         0DQoSDq0Jdw9h0HvCzPqinT06cVQ8uuPg3E1ezRBva48F7q7YBCSesBLS4pevlQBiUAS
         ByUFjoysChNlLg2jY8w6MwbDjvgn/EsID6kP7zSeurs8c5+v03JE7GFVSAs78PS7K3Oa
         g/YBSXVTE9MF6tnVEISWAiAKYe/puijEhU/Hpgt5gBwh2c0u1ejnn9WgCEgeIQElSP9Q
         odZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uDuo3UWzYq1eZ/qfYOwZH3HI4sOxwHlg0J1G1/2Okbo=;
        b=Lvw8G8FXZEa2xxlF67+Y3KX5rQpA3vAkLlMz64x/ML70VBUahbO9xLKdyWyMOCXT5x
         rq1Q8LJpDPkT4Q9q+6vFlzrh0djWCBFlY5mjk7HCDoy5r5Uc6uc5XcblD28Kj502kZfH
         /cca75XbqEOpIaK5+uzD3MutTxQbBRdILJuI37/pRytgM/Vs+5zSjd0YsEtvtek9DtuO
         kHPIZcMP8KX4LAiUpjEPNezknxcj5dZrY3Z9K1t5IiZdxuRFMDA+eEfNt4GiUGksdW5M
         ik82jOilmxUzjzs+Zy1t6i5ngnzGj59DH9gGJORxDlIM5wMel3hXiytzEUyuGZhkv5P8
         J1zQ==
X-Gm-Message-State: AIkVDXKy//QTd/BvJWy3gPwA5Bhwjlh9flfdVh4fzaITx2xm7O/mzHDcNjwDzXUDLSro53utu15Zwy8rBsEmDQ==
X-Received: by 10.25.10.6 with SMTP id 6mr12114701lfk.88.1484616845232; Mon,
 16 Jan 2017 17:34:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Mon, 16 Jan 2017 17:33:44 -0800 (PST)
In-Reply-To: <20170116220014.bwi5xi2br56lyqsw@sigill.intra.peff.net>
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com> <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
 <alpine.DEB.2.20.1701161251100.3469@virtualbox> <20170116160456.ltbb7ofe47xos7xo@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701161746200.3469@virtualbox> <20170116220014.bwi5xi2br56lyqsw@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 16 Jan 2017 17:33:44 -0800
Message-ID: <CA+P7+xqi8cXK8ZEdvy3U9jJ9wZwkGLYNR0j_xvvCJwq12B4G8g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2017 at 2:00 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jan 16, 2017 at 06:06:35PM +0100, Johannes Schindelin wrote:
>
>> >      And I think that would apply to any input parameter we show via
>> >      error(), etc, if it is connected to a newline (ideally we would
>> >      show newlines as "?", too, but we cannot tell the difference
>> >      between ones from parameters, and ones that are part of the error
>> >      message).
>>
>> I think it is doing users a really great disservice to munge up CR or LF
>> into question marks. I *guarantee* you that it confuses users. And not
>> because they are dumb, but because the code violates the Law of Least
>> Surprise.
>
> I'm not sure if you realize that with stock git, the example from your
> test looks like this (at least in my terminal):
>
>   $ git.v2.11.0 rev-parse --abbrev-ref "$(printf 'CR/LF\r\n')" >/dev/null
>   ': unknown revision or path not in the working tree.
>   Use '--' to separate paths from revisions, like this:
>   'git <command> [<revision>...] -- [<file>...]'
>
> The "\r" causes us to overwrite the rest of the message, including the
> actual filename. With my patch it's:
>
>   $ git rev-parse --abbrev-ref "$(printf 'CR/LF\r\n')" >/dev/null
>   fatal: ambiguous argument 'CR/LF?': unknown revision or path not in the working tree.
>   Use '--' to separate paths from revisions, like this:
>   'git <command> [<revision>...] -- [<file>...]'
>
> I am certainly sympathetic to the idea that the "?" is ugly and
> potentially confusing. But I think it's at least a step forward for this
> particular example.
>

Would it be possible to convert the CR to a literal \r printing? Since
it's pretty common to show these characters as slash-escaped? (Or is
that too much of a Unix world thing?) I know I'd find \r less
confusing than '?'

Thanks,
Jake
