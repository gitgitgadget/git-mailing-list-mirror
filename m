Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9B0C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 14:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiJKOHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 10:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJKOGh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 10:06:37 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDF097D6F
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 07:06:20 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oiFth-0006IN-Ew;
        Tue, 11 Oct 2022 15:06:17 +0100
Message-ID: <69ba0bb5-19c1-e54e-bc06-515a17380494@iee.email>
Date:   Tue, 11 Oct 2022 15:06:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] docs: git-send-email: difference between ssl and tls
 smtp-encryption
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        sndanailov@wired4ever.net, git@vger.kernel.org
References: <20221010172859.13832-1-sndanailov@wired4ever.net>
 <Y0R2AwKuXAVMP5Ma@tapette.crustytoothpaste.net> <xmqq35bvz10b.fsf@gitster.g>
 <Y0S2wyfUF1mZaryi@pug.qqx.org>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <Y0S2wyfUF1mZaryi@pug.qqx.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/2022 01:20, Aaron Schrab wrote:
> At 16:56 -0700 10 Oct 2022, Junio C Hamano <gitster@pobox.com> wrote:
>>        Specify how SMTP connection should be entered into encrypted
>>        mode.  The valid values are 'ssl' and 'tls'. Any other value
>>        reverts to plain (unencrypted) SMTP.  'ssl' refers to "implicit"
>>        encryption (sometimes calls SMTPS) that uses port 465 or 587 by
>>        default.
>
> There can be only one actual default port for each of the settings and
> here that is 465.
>
> Also, port 587 belongs with the 'tls' value. Perhaps saying something
> like:
>
>     uses port 25 by default, but port 587 is often used as well.
>
>>        'tls' refers to "explicit" encryption (often known as
>>        STARTTLS) that uses port 25 by default.  Despite their names, it
>>        is likely the user is using the newer TLS protocol, not the
>>        deprecated SSL, for the actual encryption protocol either way.

I support the feeling that the documentation needs a bit of updating.

I found that I just couldn't manage to set up a send-email configuration
for one of my ISPs who was using non-default settings, and I never
managed to work out what was required, or decode if the script was
trying to enforce the default in some cases (i.e. it wasn't a 'default'
that could be changed!).

That ISP has recently consolidated its options (it has many legacy UK
email domains) to limit it's exposure to security holes, so I may retry
at some point(not this month), but it can be frustrating trying to debug
these failures in setups.

Philip


