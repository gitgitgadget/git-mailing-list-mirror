Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A257BEB64DC
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 22:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjGQWtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 18:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjGQWtG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 18:49:06 -0400
Received: from mail.nicholasjohnson.ch (mail.nicholasjohnson.ch [93.95.231.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7C2121
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 15:49:04 -0700 (PDT)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nicholasjohnson.ch;
        s=dkim1; t=1689634140;
        bh=RJw/25mBY0UlfNc3V0vGBZ5AbU7A9iDjItUMAaj+gQE=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=ASP2upxGEXxlTanzzkSIWxkdWCKVJra71cfE2Z0enkYP1lF0APt9b4AQT+HWfF09g
         BD2kHdzapd2P6Nq2nP2vbiUKFphWOZQtfkx0ZGy6HICAOg7J67YqlI5/NE1Uj+BgCm
         ysw61LMbkoTjaBT7fvnpxk5Ku4Obzdvqv9dPWxAEmvtwPYmAN7Cj0gWEmLe3cwIZJW
         uBRpqjdqiIU+hIaOPip/zr62NWnbDnji9qZU2rjB5J0m+Mtn//IJNFHW3aAUuUKNoI
         LOtOP6gW0ApRQouFXR9iIhX+4p9SjtI5NrDfd6zM8rKw8qT1TVU9xw0zxhJo4D50WS
         qkWMyFCKs19pw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jul 2023 22:49:42 +0000
Message-Id: <CU4TBVU6DREW.ZZDV1JX2BNGV@anonymous>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        <git@vger.kernel.org>
Subject: Re: Git Privacy
From:   "nick" <nick@nicholasjohnson.ch>
To:     "Theodore Ts'o" <tytso@mit.edu>
References: <CTZ9RD9RQ5UO.3OIJX50PKMIR0@anonymous>
 <xmqqlefjpwif.fsf@gitster.g> <CU1SAE4WGP3X.3R7TTIWFSHGDI@anonymous>
 <xmqqbkgeqw6n.fsf@gitster.g> <CU2GQHQV5GD3.CL67078EF4OO@anonymous>
 <1d36d5ce-f452-fc31-6e30-b4ba819de7e4@web.de> <xmqqsf9njmc9.fsf@gitster.g>
 <xmqq5y6jjlcs.fsf@gitster.g> <CU47D1G1Y1E2.GID9E4XI7W1K@anonymous>
 <20230717205750.GA3901704@mit.edu>
In-Reply-To: <20230717205750.GA3901704@mit.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Theodore Ts'o wrote:
> It might also be worth pointing out that someone still might be able
> to figure out information from when a branch gets pushed to a git
> repo.

Github and other forges are actually known to track this information.

> [...]
>
> Which is why, quite frankly, I'm a bit dubious about the whole "I must
> obfuscate the time zone from which I am operating", as something
> that's really worth the effort, since it has a lot of downsides, and
> if the user is not careful, they may end up leaking information about
> when they are active anyway....

I'm fine with the argument against that it causes breakage, but I
disagree with the idea that it shouldn't be implemented because "they
may end up leaking information about when they are active anyway".

That is a defeatist argument that applies to many privacy technologies
that exist. Taken to its logical conclusion, it says "Let's not try to
improve privacy ever because the same information may be obtainable in
other ways." One has to start somewhere.
