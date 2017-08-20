Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15E60208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 10:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbdHTKqn (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 06:46:43 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37780 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbdHTKqn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 06:46:43 -0400
Received: by mail-pg0-f67.google.com with SMTP id 83so19905535pgb.4
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 03:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LryCENn+4MI1k8WhF9zrsn0+phFSSzUUqa13S65/Ay4=;
        b=PBGJH7RtmvLuwgWDxTaiCjsga3MLzmJfeOYmwnXEw3WckDn7qd2QA/XLbV3OXZlnKt
         jki1xPDfzC5qAPj2Ywux1HVl8D03IB+oC7R28I54FZJitdd1M9dIL23FBz6vKwLRsOKH
         4pw1QVYc/WqZaJy96VsBNg3nvl1FpRXOEEZ37ZfsLKwK1ceBkASigeDsYhwhDcKYfBZo
         JwAAuTV6JOYWpKbwRwtfWSUF9oJ426GQ0zEsAijghzRoQHKBJXikBXAb3gZnBGWDBkX6
         rM9K9WEJmZgWcM6bQ+RNSDHlp34EnzhNv8BZEcSntr2K4SIqHAZYhNwJ3w2UVFHmo1iD
         fs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LryCENn+4MI1k8WhF9zrsn0+phFSSzUUqa13S65/Ay4=;
        b=YQu+WEgdIp3xaBmy4pSTCN32JipwUye8ck0RyZ7RgVSXdjntvvmO+8GbIVewk//9mx
         aOMHNWKrxWclxsOZPMWu3AALlb7ke4l0i30qsVeL9RvYDkZqwyjl071PUY+y8Z+Y5Srb
         wtHlEQnmjKrSpRWMMGXZv8dBKhdI0BjCsmaVzkVNEB/PhOCLFGea34I79gNcutc78QyO
         KPQgi0vClJrN5T5BQ6aOsPgZpPVBYm/El+Tc9/nlQG9xjzd3I80ay8npqyY2jn60OSTN
         /cBvpdkkEAcso21MChsK9lJ05rtUJf4o7KUSqhVj+UlRsiQdFOjeLF6CjyEjt03YX0gW
         aK4Q==
X-Gm-Message-State: AHYfb5j6BsQpgrIoqqDfP5jiLfHrwONJm/uzGb2akcsXcw3P12L3jUXN
        fYLYm2IoWQYR0qYH4HkIgJljmxQiFQ==
X-Received: by 10.84.133.45 with SMTP id 42mr15689484plf.389.1503226002766;
 Sun, 20 Aug 2017 03:46:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Sun, 20 Aug 2017 03:46:42 -0700 (PDT)
In-Reply-To: <20170820094009.z23wclpku35txflg@sigill.intra.peff.net>
References: <xmqq60dkbma1.fsf@gitster.mtv.corp.google.com> <20170820094009.z23wclpku35txflg@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 20 Aug 2017 12:46:42 +0200
Message-ID: <CAN0heSoa+kSZ45uwdun9R4JHVOFz12nNDBCnWHGgsdWg6arLMg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2017, #04; Fri, 18)
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 August 2017 at 11:40, Jeff King <peff@peff.net> wrote:
> -- >8 --
> From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
> Subject: [PATCH] doc/interpret-trailers: fix "the this" typo
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I put Martin as the author since he noticed the bug, but I think we are
> OK without a signoff for this trivial change (normally I'd have just
> squashed, but the topic is in 'next' now).

FWIW, adding my sign-off would be ok with me. Also, obviously, I'd be
just as ok if this patch was not "From" me at all.

>  Documentation/git-interpret-trailers.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 1df8aabf51..2e22210734 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -21,7 +21,7 @@ This command reads some patches or commit messages from either the
>  <file> arguments or the standard input if no <file> is specified. If
>  `--parse` is specified, the output consists of the parsed trailers.
>
> -Otherwise, the this command applies the arguments passed using the
> +Otherwise, this command applies the arguments passed using the
>  `--trailer` option, if any, to the commit message part of each input
>  file. The result is emitted on the standard output.
