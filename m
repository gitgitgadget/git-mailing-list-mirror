Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792F51F516
	for <e@80x24.org>; Thu, 28 Jun 2018 15:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935416AbeF1PRf (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 11:17:35 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53720 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935064AbeF1PRe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 11:17:34 -0400
Received: by mail-it0-f67.google.com with SMTP id a195-v6so13295806itd.3
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P44Keb6BttH4ACEycBKaAWszPR/wC+loQuklIIhZSBw=;
        b=IGheH2zeOdR8sSSj3jkruR4TjB/1xU0IycSd3AE8oIPmTMtwIETeNOGhnhIB8cw+fa
         qXlJf8s7i+TxR/u9Yj7WJB6IMwX0imW0Dx4FJUV0K4mG2kh1d919etGrcgfjU9DOxK6q
         XYSTBGSPRm9/U30aMGaFgHOkxc7ysclJnYSSpZnkd7wTgAkXIkUoUeG7ZYDzl7kmM71x
         TEnzpjjjJLGZ/dSmOFLOWcyP4iK9TB88gqdxmQuwTONvwsT0jylgbiHlYmU5TwBikLZo
         iZOFSMakULZW5sRUQECMNsvC5oQ6iXjJx8C8HfqbvsgLq48BRFuo0ztlo+KOk+ukPccZ
         aYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P44Keb6BttH4ACEycBKaAWszPR/wC+loQuklIIhZSBw=;
        b=UimThPLn1AkAUsrC8w/Tg249iD7XPuY03kAOh6rjtmZxELMO79tHo+FntaDEK3KcOm
         mOSOfbSzZhTqj0W05JAzatqvuY4o7+IaRCl6PTYWxjnmjUW7mLxgNdBCVq8aLLfc3WyH
         GlWy7ZTVHkAyvRhqFGQMRD/7FShNocKTlYd1J6803shQUeOoHaU7aqQSvkigtjD1n+WE
         LfbsCbT5tXA3tfHWp8Id7UhfQPJLhL6MMwmQqY9fvMx1vwCvJ07Bup+ehkpq8eR99+t2
         e/Any9z84epFBiBV99lsBx9cC5WT5/vdu1tCYDN1nH+qPCV7dWIN2VRRkizbW7PEA/p6
         UZww==
X-Gm-Message-State: APt69E2PuCsmyXRVgluQL1FxJER4Efr44mMf26CwyVDZbQ4KkTQ/rcph
        4Fs+umLCJRnif10mkHuXfLnY4H0R0740HGFTGcE=
X-Google-Smtp-Source: AAOMgpfrCnyLjLfz6M4MohOqaTZBXenfOrfV3fRtG4JPkxDkms+ZDFs/oUA/fkzSN9QwWyvpjhLCmlTHZP5y+cuT/GI=
X-Received: by 2002:a02:a999:: with SMTP id q25-v6mr8938636jam.47.1530199054036;
 Thu, 28 Jun 2018 08:17:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2293:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 08:17:33
 -0700 (PDT)
In-Reply-To: <CAPig+cTaxJ2fAXaXdQUNSWE7ehyROM79YL6wsNpnf1PuMoaxdA@mail.gmail.com>
References: <20180623121846.19750-1-chriscool@tuxfamily.org>
 <xmqqsh5amt8n.fsf@gitster-ct.c.googlers.com> <CAPig+cTaxJ2fAXaXdQUNSWE7ehyROM79YL6wsNpnf1PuMoaxdA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 28 Jun 2018 17:17:33 +0200
Message-ID: <CAP8UFD0i_PeE6J00LJFpS1_L-MntKYK0=-7ezTQjQ+a4wOB0gA@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] Introducing remote ODBs
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 2:37 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:

> In addition to the t5702 failures, I'm also seeing failures of
> t0410.1, t5616.6 and t5616.7 at the tip of 'pu' as of [1], all of
> which seem to be related to these changes.

Yeah but only s/core.partialclonefilter/odb.origin.partialclonefilter/
is needed on top of the fix for for the master branch.

Thanks for the report!
