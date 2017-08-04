Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEF681F991
	for <e@80x24.org>; Fri,  4 Aug 2017 04:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751260AbdHDETB (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 00:19:01 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:37387 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbdHDETA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 00:19:00 -0400
Received: by mail-pg0-f46.google.com with SMTP id y129so2990970pgy.4
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 21:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KUNzNlaGOXb7YFIUsMKmr2c82viuWnuCv+dRp5Te2Kg=;
        b=FWW2vXWuwcELIewA8nkA0dxiB4qak+KyU1BtN2OxSAfgSHKBm5VPBhgO+Mu8/M7jgd
         MJYtddzku1vM11NQCKc3XNJJhYpE+Ao19GzpGqsOMF3MUA3hXAGc2fnNQaR2WpUYPvSG
         Ggoe8rO6mdzj5XDFCvSH1fPazMQy4T/qdCM4RbKGKSuX5xk805ws4xZciDGBupV3Bh0+
         H8OBDXVQhf7jLJ5mDo3vlm1jqQ0qpnA2EX5V/NXfCyDPNAhyaaVxUKM43XOmm/2cTt/0
         MZwLvqATf+O+CLG2dxZLSSH4+DHNiOYTi8dUtkNkkurF4KkCfjUUj8gGj6KXfvvC3YWP
         vdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KUNzNlaGOXb7YFIUsMKmr2c82viuWnuCv+dRp5Te2Kg=;
        b=I5fES49xHysAiZ+OHQB3cBSRdRcrIOYuIH/+5UYz+4MWKXCROgkUx4xe0dBxCTh08p
         oG7vQdEqZPUhmhcgiCdfyZOw/frpwikz3ZiErwXPz/8Dp/MM/kMbFsIynpXhGzcaFW6b
         R8Ipv5/+41Q4ddqvTuO2Yty7KaBfXhlwlEQrLxq+4vMkcNCxbTknNiFTF7Wn253y3bj6
         WxjPLB4nMtR//DiPzjy+6ZAFUa7hzEzeEsS+gJNGqzx+A4q8ECqki4IAMCUdDrIn9Mmy
         smGNG4Sl9yOFlY2pJSpHEV4qT/I6CKX5UAfF6gpI7+5b2S0VpfMI2Z1mANOGynpDvtjy
         aEuw==
X-Gm-Message-State: AIVw1131Ku3boFimQGBW+k062nbi+EJi9bUnRXh7rYrDj+KAxt94RqE7
        IwLRxydzFWcuLjZ3MgQz99VNU3AnMg==
X-Received: by 10.99.47.2 with SMTP id v2mr954027pgv.203.1501820340098; Thu,
 03 Aug 2017 21:19:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.238 with HTTP; Thu, 3 Aug 2017 21:18:59 -0700 (PDT)
In-Reply-To: <xmqqpoccpmux.fsf@gitster.mtv.corp.google.com>
References: <cover.1500321657.git.martin.agren@gmail.com> <cover.1501701128.git.martin.agren@gmail.com>
 <e660a9cdaff6d114305a475f9a12876b56b473d1.1501701128.git.martin.agren@gmail.com>
 <xmqqpoccpmux.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 4 Aug 2017 06:18:59 +0200
Message-ID: <CAN0heSrP=HeUcpfwXS9DyzCYCnCCocyV4iCHyAxrYPmW=LgZ+g@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] builtin.h: take over documentation from api-builtin.txt
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3 August 2017 at 19:44, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>> + * . Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
>
> Not a new problem but it will become much easier to follow if we
> moved this item between the "implement cmd_foo()" and "declare
> cmd_foo in builtin.h", like so:
>
>  . Define the implementation of the built-in command `foo` with
>    signature:
>
>         int cmd_foo(int argc, const char **argv, const char *prefix);
>
>    in a new file `builtin/foo.c`.
>
>  . Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
>
> Alternatively, we may merge these two into one item (i.e. "in a new
> file `builtin/foo.c` and add `builtin/foo.o` to ...").
>
> But of course, this patch 1/7 should not do any of the above.  I am
> suggesting a possible future clean-up for anybody on the list
> listening from sidelines, and you do not have to be the person who
> does it.

Thank you. If this series needs to be rerolled, I could do it as patch 2.
And if not, I could try to remember to do it once this series has landed.
A that point in time, I'd also like to try changing other commands ("git
branch") similar to "git tag" (although maybe your suggestion above
shouldn't be part of that series, but go on its own).

Since this is my first code contribution to Git, I'll ask about this part o=
f
SubmittingPatches:

"After the list reached a consensus that it is a good idea to apply the
patch, re-send it with "To:" set to the maintainer [*1*] and "cc:" the
list [*2*] for inclusion."

I will boldly assume that I should not be doing this. It seems to me this
doesn't happen very often or not at all -- possibly because you tend to
be involved in virtually all threads anyway, before the list reaches a
consensus.

Which brings me to my final point: Thanks for your very helpful feedback
throughout all three versions and even more thanks for your work on Git.
I find it amazing how much time you are able to constantly spend on all
aspects -- "high and low" -- of Git. It goes a long way to explaining how
Git can be so very useful. Thanks a lot!

Martin
