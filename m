Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FF1E20966
	for <e@80x24.org>; Sat,  1 Apr 2017 08:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbdDAIze (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 04:55:34 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34698 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdDAIzd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 04:55:33 -0400
Received: by mail-io0-f181.google.com with SMTP id b140so52358504iof.1
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 01:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g3Lvfu+OZPjhM7u6I1kn+/xVKzZXe/HdH+Bos2ViQ0Q=;
        b=gXc28ha9xIGam534Kj4UO0VhCRwPyNHJdzojcNELukocEy2HmY+hfz5vB5h2t6j/QJ
         9JWSrdh6z0uyvu9CKQngsXqhVP67P43XBMuLQVk3YiNUo1CX65ar9mH2uPPqe0BQtKL7
         ksFwOuIvQc8+jkOJlgKC/CowIVmg3OYrtbE6WyHmG3f7sneNH+Gv7nkdUHJpFOwgDQLx
         F2fTpgOGMNOo8fc7OsiVjL/5+f0nWiFbGZMkmu6SB3MQwzCVmXTxifz3iemzXFHjGo60
         WouAM9/lAyTrG9AQRvshHr8VCK9+anXx7w3JcydUdbbzDi8KpAm+MVHHVlzF72J+3jVf
         BSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g3Lvfu+OZPjhM7u6I1kn+/xVKzZXe/HdH+Bos2ViQ0Q=;
        b=ZVanjinHEtQCqrsCIA5ClDVBK8pPFqD+GYyeJeLGePduaemnlAsneK+EoqP8N5aQJp
         3QKY44rFKaZRoWf7iimJL77i7IHhxkK+8DM0oDKZ86GynoFOP+u1Pt89YibqPvGULesF
         fwZ9avUUyvsDW+Sr2pWI0rAK8GCTQj5Gd4T1nftTqSOWzuD3wg8iQ4oyoQs4iEDKQdy9
         lAQfbxuk128nte26srIG9EH2yDDUyBEyqE6B6tX4wqqvIqGuPSog8n3C1cSodeqYJ6+O
         idE1D4Zbmytt+tap2USD7DL0O1mUNXNmgxXr7ImroPLgJ8SJP/f56559eHnT4yhPmpd9
         vXvg==
X-Gm-Message-State: AFeK/H2ccgTocSXBEdYLlliOts6BbOXPJB3lL2/N1b0/i7VIN7PpHc2/Dc8lnJ17OUyc0xZcAfs2Fp0Mx314Lg==
X-Received: by 10.107.32.199 with SMTP id g190mr8435962iog.117.1491036932298;
 Sat, 01 Apr 2017 01:55:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 1 Apr 2017 01:55:11 -0700 (PDT)
In-Reply-To: <xmqqtw69vz9t.fsf@gitster.mtv.corp.google.com>
References: <CACBZZX6FcHcY7cYs6s_pv=E43cHNmzyUY5wrcuhPWWmUixCL+g@mail.gmail.com>
 <xmqqtw69vz9t.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 1 Apr 2017 10:55:11 +0200
Message-ID: <CACBZZX416M3YFDAACGAWCjJ4Xt0g78zpFF+iusMCarKb7SSfVw@mail.gmail.com>
Subject: Re: Very promising results with libpcre2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 1, 2017 at 12:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> That enables the new JIT support in pcre v2:
>>
>>       s/iter    rx fixed   prx
>> rx      2.19    --  -33%  -44%
>> fixed   1.47   49%    --  -17%
>> prx     1.22   79%   20%    --
>
> The numbers with JIT does look "interesting".
>
> I couldn't quite tell if there are major incompatibilities in the
> regex language itself between two versions from their documentation,
> but assuming that there isn't (modulo bugfixes and enhancements) and
> assuming that we are going to use their standard matcher, it may be
> OK to just use the newer one without linking both.

There's no incompatibilities in the regex language itself (modulo bugs
etc). So yeah, I'll prepare some patch to use v2.
