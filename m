Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44A2211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 22:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbeLEWh6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 17:37:58 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:36955 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeLEWh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 17:37:58 -0500
Received: by mail-ed1-f44.google.com with SMTP id h15so18421334edb.4
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 14:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=mB7203B7TkLGvoyzHLn/iVMYpuTznmwFIffUKuA/zZc=;
        b=EF3ugrXgZSgTGMCNWXUs4CS3wxkR4eXsKROyCUO4yaMtBt9tGfNyu+U0FleQSbhoVM
         vDmFCb1hJu60JhEQe/tiZ6UupArmpEZhOaDeJ8R9Ly14VeIuAGoSZ8VZGZNKn85Xg3rg
         7CKTiO2VNdbE1QI7NpP3JMgIEJk4NDsi4hMixpTc+/HxAWBVn5KT+8poDSyA4T+XvAel
         b/pKkiLItk/EFdx4Gp6Kxd+tHOkwIWt5JHMzKP5o5qvDnrzhtD1gm7hshtmTW83xwByl
         OXrJajLbq3jyHQozl8p7crKK8F1JyM38Fr8d+kN3jR3FfC8DRYoDacbvO58aksPqNfRy
         bG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=mB7203B7TkLGvoyzHLn/iVMYpuTznmwFIffUKuA/zZc=;
        b=a4Ox+i5RsWXIDRqT7HIzMkHO1HF4io1nDummYORjMPdEqEGpMve9/A9kZO3UrsLhiX
         KDPX5nvpm6WAJcCOj4P+GPi4zfxIdIlEsYdL/h4OI59451FAho+tWHgkevxPb7kr288d
         XxhLm+3Fr+XFsg1XgygzVRI0Xl/XEjtfOP47LYj+IeELum9anwfIFj+Iu3Dqy9c/tZKT
         7QR50mW82VwI6QSnDhbizEIGQ/Uu/fuya3sB/hxBv8zGgUq2Ez+ZMczGK/Ea5mwZchDn
         loZj+Hy6k+SK79aVu9RVPv5NvJdmgQXEK+Opo7UunUX2GXzHygZ8aify7kXuanWQkQIP
         /N2A==
X-Gm-Message-State: AA+aEWYeCk3RbI7xG5/JWoLlkfJldrn1E82tIxFo0QrVstqhBkgZ4E1M
        lRXyNRBiWhRMzFLOUtoJVkmgWB1R
X-Google-Smtp-Source: AFSGD/WDWPRZMVEf9evoxFWtvzqRjCQ1SmkozEQEiROtSu65f3BcPaYRK6l2MLZnQYCMzH4aWTecLw==
X-Received: by 2002:a17:906:619a:: with SMTP id q26-v6mr20201391ejk.230.1544049476127;
        Wed, 05 Dec 2018 14:37:56 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id k31sm6159089ede.5.2018.12.05.14.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 14:37:55 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Coiner\, John" <John.Coiner@amd.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git, monorepos, and access control
References: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com>
Date:   Wed, 05 Dec 2018 23:37:54 +0100
Message-ID: <875zw7zjjx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 05 2018, Coiner, John wrote:

I forgot to mention this in my initial reply in
<878t13zp8y.fsf@evledraar.gmail.com>, but on a re-reading I re-spotted
this:

>   - hashes are secret. If the hashes from a protected tree leak, the
> data also leaks. No check on the server prevents it from handing out
> contents for correctly-guessed hashes.

This is a thing I know *way* less about so maybe I'm completely wrong,
but even if we have all the rest of the things outlined in your post to
support this, isn't this part going to be susceptible to timing attacks?

We'll do more work if you send a SHA-1 during negotiation that shares a
prefix with an existing SHA-1, since we need to binary search & compare
further. SHA-1 is 160 bits which gives you a huge space of potential
hashes, but not if I can try one bit at a time working from the start of
the hash to work my way to a valid existing hash stored on the server.

Of course that assumes a way to do this over the network, it'll be on
AMD's internal network so much faster than average, but maybe this is
completely implausible.

NetSpectre was different and relied on executing code on the remote
computer in a sandbox, not waiting for network roundtrips for each try,
so maybe this would be a non-issue.
