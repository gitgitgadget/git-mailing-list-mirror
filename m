Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7415D20C32
	for <e@80x24.org>; Wed,  6 Dec 2017 23:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbdLFXNH (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 18:13:07 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:35455 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbdLFXNG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 18:13:06 -0500
Received: by mail-it0-f54.google.com with SMTP id f143so10230723itb.0
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 15:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J9JwF91htt/+DuEXo7sxRD5yyvzyA57QOfYsWelMVcY=;
        b=ZEUUGVZFmnqVnTJpwua1rRD75mGSJeTDOLfJ19XLTW8mR/iXZr63bKyWqkGpWTkE1W
         ebsPL5Ee6RorX6zPIjgRRTkYqLrVhYE4Yar93eH7HGMNCzFFenTSlG7B1P9WCzKl/cNq
         CyPZgYRcddfvMA2Ml/rRtLL1Bjkbkvp/LtjcQnUnbUQ0QEBtaKFrkUuZ5y3SCCl9aYe6
         apsmWkoVeqa0ILOpyH+duZVYdBtJgZxvsYI+/sDwVzq27hpEWAQUgGto1Q95ATivgmPX
         RY81f2gBlGlThKdX9px2+IfN1IWdWCiR+rGy+sOma3bh2ZNTRoLPG5LmEcLn7QWRco9n
         Z5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J9JwF91htt/+DuEXo7sxRD5yyvzyA57QOfYsWelMVcY=;
        b=huwaDzPDxf3RIGcFZMOUBhehpTSUCkAI8fJDFn0c6pS0LuhqNzAzgHkwwW2TNLtbLn
         NenallVA71WGUGYuJPPrUa+3vIhhuvVo11RdEfRbIB2O0ft/0rWw2Hv5yn8QEQTa88c9
         UKM9wqWaFRXjL3JNLb85Qhm3KfmLO8dZZe8V8c4lEGu1gUKCl0OfdTjdgiU2bdHSCJbB
         EU1mzNJHMqoH34+fu1n5O3a3T77/eJh610RzoTqLyo7ObQXhgIQyWrB8fJv4X4Jq9HQt
         IXFlTYs/5xWRsuHdnmIffVWEyEo8JvwyQ6L1CFq9defZrpDX36C6KBhr/MEMKlQF+xVh
         +FQA==
X-Gm-Message-State: AJaThX4FSuaXBce+8PkBFlDNqFZntBzsF5i/ms1+pxH/575NnP+6Bm2X
        4WNsy2xSjQqHYRtSU0+CmiLTDg1jgnuEenLzCSI=
X-Google-Smtp-Source: AGs4zMbhbBWVPUSp3IvlaiRYsQa8acm2ng9lnhiBG22kfoTA0rhGtgp4FDKsIu2i+Ct6srA2xrDIDgAjU4B5iv5xx28=
X-Received: by 10.107.6.81 with SMTP id 78mr35385315iog.204.1512601986026;
 Wed, 06 Dec 2017 15:13:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.19.167 with HTTP; Wed, 6 Dec 2017 15:12:45 -0800 (PST)
In-Reply-To: <20171206230225.18873-1-nathan.payre@etu.univ-lyon1.fr>
References: <CAGb4CBWZciqxdfpSkK1vezhiuSYX5Yy-xSq=Uj4h+vhRo9uyoQ@mail.gmail.com>
 <20171206230225.18873-1-nathan.payre@etu.univ-lyon1.fr>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 7 Dec 2017 00:12:45 +0100
Message-ID: <CACBZZX50TAPcoqUU_oREC=4T2uXVrKSFTjR+g-pvqusaX3FURw@mail.gmail.com>
Subject: Re: [PATCH v3] send-email: extract email-parsing code into a subroutine
To:     Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 7, 2017 at 12:02 AM, Nathan Payre
<nathan.payre@etu.univ-lyon1.fr> wrote:

> +sub parse_header_line {
> +       my $lines = shift;
> +       my $parsed_line = shift;
> +
> +       foreach (split(/\n/, $lines)) {
> +               if (/^(To|Cc|Bcc):\s*(.+)$/i) {
> +                       $parsed_line->{lc $1} = [ parse_address_line($2) ];
> +               } elsif (/^(From|Subject|Date|In-Reply-To|Message-ID|MIME-Version|Content-Type|Content-Transfer-Encoding|References):\s*(.+)\s*$/i) {
> +                       $parsed_line->{lc $1} = $2;
> +               }
> +       }
> +}

Nit: As noted in my earlier review this results in very long lines,
I'm just typing this pseudocode into an E-Mail client so not tested at
all, but this would be better:

   my $header_parsed   = join "|", qw(To Cc Bcc);
   my $header_unparsed = join "|", qw(From Subject Message-ID ...); #
line wrap this at some point
   foreach [...]
   if (/^($header_parsed)[...]
   } elsif (^/($header_unparsed)[...].
