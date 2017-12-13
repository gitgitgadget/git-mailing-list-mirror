Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D9CC1F407
	for <e@80x24.org>; Wed, 13 Dec 2017 17:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753658AbdLMR56 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 12:57:58 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:45450 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753345AbdLMR55 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 12:57:57 -0500
Received: by mail-wm0-f66.google.com with SMTP id 9so6672838wme.4
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 09:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=peik7E6j3kZ1drz/u+/TnlwSP+8XeBCngr1801U8t8E=;
        b=GTqBoNh5ijNdJCdwlTbDaSvr9bewWvl5oOlXoD2wO5hqjGqMr7a+7CMhaUwRIE5vLA
         TRiqMkhOIip4lhynr70l29CFZ0d/mxpZm3vuPLF0gt3bMfYmmNXZXjdMQcAc7dYCl5Cm
         jBI/jbcCZAFL0rCpqkw3fHqgPTOy33EyeKU8RrDlxVyU851YuMiDAK1dqoQlt3strs9m
         8Q3+L0Bxo0E4949XD2V0L15c7Os7e7Qxt4Ep2aHYnh7TtErXQafELvrsjvepUFxblbHQ
         Z8mlHLdIPHeNmHF67bxpBwF+XfNnnlwad/ROByjCaITgYx5Lq9YRh4HEgg3JwoKZQvJb
         iyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=peik7E6j3kZ1drz/u+/TnlwSP+8XeBCngr1801U8t8E=;
        b=MjcZTNivYwXxvxrJnwvwMRrvfez2m/2RbZO/yO/XeOgp0BTl7If+2oZ8zzN1QDRN/r
         sI22D1D46nwZd9wxzw+6dCysF1Q95lHllSCjyP5P5nVAYp2prMSfEYcj5K0xJCs9fMmA
         t8X/WzsREXp22QoNbAHvq83KZrcpHcJupIdyZ01Ku2yg854UpEiqqp+A1mj/YF3F0hi2
         p+ZcYUblqGevKbVDIfAMr2eEfIGutLacP1TMYU5bWHPagUd1vGwiBrShSAmxcEqsZtq0
         lqvyZ4Rp3DqLRrVAJ05ZBW1xEcOnfEoEGkjG3XQEajyxfApY8rt7BK6VqA86yrzCy0tw
         KY4w==
X-Gm-Message-State: AKGB3mJ4NVn13JDUpKlxBM6YOst4CohIib3U+KjdDE1vL8j7N7hR+Bzp
        loqrRDMv8QGY1IPRPcZmcGI=
X-Google-Smtp-Source: ACJfBosL7ZoeF4YQffErUzcm+XwZ4NxYnRzRSynEniNvGzN5QQcbgINGu7ksUCq1Ij0Sa2971oqplg==
X-Received: by 10.28.211.67 with SMTP id k64mr2595182wmg.55.1513187876621;
        Wed, 13 Dec 2017 09:57:56 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id d1sm1715625wra.44.2017.12.13.09.57.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Dec 2017 09:57:56 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq1sjz3frf.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 13 Dec 2017 18:57:55 +0100
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        peff@peff.net, patrick@luehne.de
Content-Transfer-Encoding: 7bit
Message-Id: <D2973852-BDF4-4251-8DE3-CE6AAD303A5F@gmail.com>
References: <20171211155023.1405-1-lars.schneider@autodesk.com> <a07a0b5c-453a-f644-d5e5-7d185a943088@kdbg.org> <0BA27EC9-3836-407A-9A8A-52D06B8052AE@gmail.com> <xmqqzi6o3go9.fsf@gitster.mtv.corp.google.com> <48ebcb7a-2a7f-e790-2613-a1f3e3dc41f9@kdbg.org> <F571AAED-C325-4151-9566-6BA249C1B3D4@gmail.com> <xmqq1sjz3frf.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 12 Dec 2017, at 20:31, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> Our favorite is "treat-encoding-as". Do you consider this better
>> or worse than "checkout-encoding"?
> 
> I am afraid that "treat as" is not sufficiently specific and would
> invite a misinterpretation, e.g. "You record the bytes I throw at
> you as-is in the object store, but treat them appropriately as
> contents that are encoded in cp1252 when presenting".
> 
> what is missing is at what stage in the overall user experience does
> that "treating" happens.  That causes such a misinterpretation.
> 
> So from that point of view, "checkout-" or" working-tree-" would be
> a better phrase to accompany "encoding" to clarify what this attr is
> for than "treat-as".

Alright. I'll go with "checkout-encoding" then.


> Having said all that, this "feature" would need a moderate amount of
> clear description in the documentation, and between the perfect and
> a suboptimal name, the amount of explanation required would not be
> all that different, I suspect.  We need to say that those who wish
> to use this attribute are buying into recording their contents in
> UTF-8 and when the contents are externalized to the working tree,
> they are converted to the encoding the value of this attribute
> specifies and vice versa.

Absolutely! The docs will come in v2. I just wanted to send out a v1
to make people aware of what I am working on.

I think storing the encoding in gitattributes might not be the perfect
solution but probably a pragmatic one (because it works and the changes
to Git are rather small). In a perfect world I think I would store
the encoding of a file in the tree object. I didn't pursue that solution
as this would change the Git data model which would open a can of worms
for a problem that not that many people have (almost everyone is on
UTF-8 anyways).

- Lars
