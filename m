Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D66331F731
	for <e@80x24.org>; Tue,  6 Aug 2019 01:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbfHFBhr (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 21:37:47 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:43962 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfHFBhr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 21:37:47 -0400
Received: by mail-oi1-f180.google.com with SMTP id w79so64251173oif.10
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 18:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=YEY+TEyhUOeXQEhcznOg+XM4Fcfjv3QLZHqbpLfxiro=;
        b=ELOD0TomLnqavDWhHfgCNLNIXVYIUr5vlUvLX5IP69YXU0DEzOnMHY5cfMtBuDw6GN
         uAbCBxkEt7jynOC43+IEOC9SsUO6tcw32giR4Z5nb2MHt8meGNWHLj27FxvmJtWp2k/d
         dh2pKndv2E3qR6qBpnWLfWoqsVGlr8Bzc0dKCXP3jKRRrGb48gvlPByOz/ia0feRaI3c
         9OJY/gEUMXlrrqWKfvpUxhRlgzjh83Lgr4xDsZ+ubDbae01q4yLXdpYQw63w8LB5wREF
         rue+HsdfdMILNE37pyDgUd96iY3LvtBIfG9B64aXmg0L9dz4PnMRByfyvm5rugtgNikt
         kuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=YEY+TEyhUOeXQEhcznOg+XM4Fcfjv3QLZHqbpLfxiro=;
        b=eQQUh4UT2UdnhUZ0gYakw8RIZrafXpIbzSipPigJQ2GLoQwDk3CVatpv5gHE2jL57v
         D/qP/Bmx7NsOT5NLGj9+ZyktLfZxE6Chj/HTO0TV0MnO0+O5g8TTh1eAdhWM0aR/C3Ce
         j1rZ+9NxCgZLw7eKOkwrvsmj8znumW62FFRg3sF029OcVKvghGWEWlvZDugxZppbENWf
         niDxEpompNp7CYtYETQJQAJIJUUNYz2qveP+e5iLGVhc7YThcae1EKQ3nrSYID9AAuzo
         hj0RTLVGQ51BhURumEsWrhYVR64JWmln2iq42OT6wzCIsRIM9FtghcZPmgq8oYYkUdkR
         btBw==
X-Gm-Message-State: APjAAAX4ifT+9rXoRB+r0CHreIOLLvn2pdDShPpooHyR5RhMrNehPMJ0
        9Is6FwUkbP0UHqLwMWI7RYiwT0S+K9lYoHcFO/BdM6uyLRI=
X-Google-Smtp-Source: APXvYqxaKKu+axIKqhVyxa0WXPwIGCBm5VGBofexCQJPX18Ptky5EeIyzcryt9v/76dWICoAgDQPwBbWADfbDma+qEU=
X-Received: by 2002:aca:90d:: with SMTP id 13mr24382oij.126.1565055466670;
 Mon, 05 Aug 2019 18:37:46 -0700 (PDT)
MIME-Version: 1.0
Reply-To: lukasgross@u.northwestern.edu
Received: by 2002:a4a:c543:0:0:0:0:0 with HTTP; Mon, 5 Aug 2019 18:37:45 -0700 (PDT)
In-Reply-To: <20190806013030.GA61803@google.com>
References: <CAOY1tUUmkRBEDkF3GiP45WSi50uUGBaamx9-PGej0Z-yt0ioPg@mail.gmail.com>
 <20190806013030.GA61803@google.com>
From:   Lukas Gross <lukasgross@u.northwestern.edu>
Date:   Mon, 5 Aug 2019 18:37:45 -0700
Message-ID: <CAOY1tUVpeUftgHNuZg-2fMD9D+Qz08hfvRvQDe1f8+MV2xYv2w@mail.gmail.com>
Subject: Re: amend warnings with no changes staged
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

I had intended to stage commits but forgot to do so. Git responded
with a normal commit creation message, so I pushed to the remote to
begin a CI build. When the build failed for the same reason, I
realized I had forgotten to stage the changes. An additional line in
the response to the effect of =E2=80=9CWarning: did you mean to amend with =
no
changes?=E2=80=9D would be very helpful to shorten this feedback loop.

Lukas

On 8/5/19, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Lukas Gross wrote:
>
>> I have occasionally used git commit --amend without staging any
>> changes or modifying the commit message (--no-edit). Since this is
>> often done unintentionally, could amend warn when it is being used in
>> this way?
>
> Can you say more about the context?  What were you trying to do when
> you performed this operation?  What happened instead?
>
> Thanks,
> Jonathan
>


--=20
*Lukas Gross*
B.S. Computer Science | McCormick School of Engineering
Northwestern University | Class of 2020
(224) 522-9067
