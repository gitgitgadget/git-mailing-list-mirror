Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6272013A
	for <e@80x24.org>; Wed, 15 Feb 2017 21:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752287AbdBOVcA (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 16:32:00 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35412 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbdBOVb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 16:31:59 -0500
Received: by mail-pg0-f68.google.com with SMTP id 204so12114288pge.2
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 13:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9fMpfa8ljUkXfeAYr7Afxj2D/w3tfUip5XP+AhCucwQ=;
        b=XldfEl3rzZCCQBoI9E0USdC0W4ZQLSWWC7Stkwlfk3Y+l+lNtfcX7R8VvLyLvGGzlF
         6o/gUArocQDwuzA2w9wxy3hrp3qP+B9AToeXatL3tpDlI1CRFVPCEoTQj8yZDQ6g3iF5
         BfG32c2R58/wArmeC1F/CxQp3VOrRC2+6zW0QvrH7dAVQu1zW0yUiL0TYrTu1sXMjUA5
         X+Cw/pMzlQ6dSZNzyZXLfoeEQTflHM4sZiROnwskrUNZirbkl6p34yO4QE3rrUbpE3CI
         OyVrgrL3xUb0xbtUqeHeyBNmID8j/BnHU3NIkI2JBKuhSzfMiO0NI6Cq5nD7dJF279Gy
         LJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9fMpfa8ljUkXfeAYr7Afxj2D/w3tfUip5XP+AhCucwQ=;
        b=KbBAS8IbSMOUKjVgW4goncM9hYrpdw7eTYOSzuTtlXd9fzbVuKwedv0Ao1cBfmNYBB
         nyHJ+iC0Rd0VCv8fbRNpJ1GD1T1Q04HNGboXFh2W3DFcX5Vqiu65XXCtTwsHB+O40+v6
         ot50ez/CpWlbU+wgji8tdxWyQvF4nGt1XHRiE5kxuCV2Eg1W6TtS92AUoxI7+XWDRghH
         oI4ZByDx9QiGPJ+ZXSUfavuzwko+ktr2g5rdAfwehFtgO1x4008fNtrzI7L+DDPtT3Nk
         LQeRc39Xd0FlFT44Eoe2HMPyr+9SUDHWlP+YMHBLHMEUNsA8AJpRflsZA0mLiHk2qkZx
         IiMg==
X-Gm-Message-State: AMke39kDpxKqLFR8snJt+/IkgLP5D3pRhn9z+8ThxIqQEtQNbxR+EX8daY7uaeq2/56SyA==
X-Received: by 10.98.147.207 with SMTP id r76mr40093109pfk.111.1487194318560;
        Wed, 15 Feb 2017 13:31:58 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id m6sm9259871pfm.22.2017.02.15.13.31.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 13:31:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Fabrizio Cucci <fabrizio.cucci@gmail.com>, git@vger.kernel.org
Subject: Re: Back quote typo in error messages (?)
References: <CAOxYW4z=bABqhmHWCc9rizykMcGBjDvqLEuqpJ6DtPve5442Fw@mail.gmail.com>
        <20170215212157.qgscyglgzrd5cplf@sigill.intra.peff.net>
Date:   Wed, 15 Feb 2017 13:31:57 -0800
In-Reply-To: <20170215212157.qgscyglgzrd5cplf@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 15 Feb 2017 16:21:58 -0500")
Message-ID: <xmqqr32z2l9u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I think what you are seeing is not wrong in the sense of being
> unintended by the author of the message. But I do think that git mostly
> uses matched double or single quotes in its error messages, and the
> non-symmetric quotes are relatively rare. Running:
>
>   git grep "\`.*'" -- '*.c' ':!compat'
>
> shows that there are only a few `quoted' cases in the code base (there
> are 27 matches, but many of those are false positives, and some are in
> comments).

I did a simpler 

    $ git grep "\`%s'"

and saw "`git %s' is aliased to `%s'" from builtin/help.c and
"unknown option `%s'" from parse-options.c (and revision.c)

What Fabrizio saw is the one in parse-options.c, so even though the
number of strings in the code is small, they appear everywhere.

I agree that we should standardise them, and we should do so early
in a cycle, because these appear also in .po files.  It is too late
for this cycle, obviously.

