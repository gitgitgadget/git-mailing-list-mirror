Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A18920193
	for <e@80x24.org>; Fri,  2 Sep 2016 14:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932239AbcIBOe2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 10:34:28 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37445 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbcIBOe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 10:34:27 -0400
Received: by mail-wm0-f46.google.com with SMTP id v143so34666497wmv.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o2+ou9jaM98j0JvfoHzp0myXTv5umXEF80IUY16n/eU=;
        b=T4xGrD/SO1IvRAzZZVM2k8stxFZOLYAkYYyO8gZLOUDF8XPK7BQir321AqgRFePq6e
         wGMW0ujO33vsjnQPhncarAu/uHpuPVmqknp/WnmBHv7cQUqdRRWH8ttajYuvBLn+eh48
         PYabyiFsrJxNcq/0C21tu8bUYIK4GHQtgiWHC9Pfgc94BRaet6uXeRd1N+Hx05Mpc8ZJ
         Nba+oJP9LO27C+a2OIdRYyAg9Qxe3VJ1nEi79Mwoq10ihP5jxzKro8rZdMUGyfKU0Naa
         5CicktPTG4i0HXAojtka148FJtZH7VMgFVhn/CiiHY3GPtihmYIu8BE5g3Rjy73p2Ja4
         yAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o2+ou9jaM98j0JvfoHzp0myXTv5umXEF80IUY16n/eU=;
        b=RY6sNB0t2XM3Kpy/tftdobggaAJKgGokz4pnM55kjgFJ+eb/4K+NcKPgkPT3l75+3T
         wprRHVcLHWIrYuc3UylgK9eopJX211FIfsGBx0TS9dyQ4mLIri4B9iif0LZp06tWFQI4
         R3ZdG+AOoavelGFn3p/QJuYeNZ4hE7VflUaH62VnBT1gUEcOjWt6UDpoUvbplTedinQs
         K3wX5G8Xlmlvt0udC2aL2ozHJBwnKvF6Dlocq1U4c7gAiafjrcthqEd0VnEFni7ag30C
         iMVZJjlsnfxvNE81bTTdp6YgxQu+PXzu/rNCpwtEZ2aTwBsQnr0rPVr9DVq9I3L+4mec
         Oo8A==
X-Gm-Message-State: AE9vXwO5r2cS4jN7SmLS762loVBr9+yC9cqnExDdAu+KXX+sZQaBsZWTtj85k3nfJeuiFy+TC24rTZq1JmuOGQ==
X-Received: by 10.194.149.113 with SMTP id tz17mr19393706wjb.64.1472826865350;
 Fri, 02 Sep 2016 07:34:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.222.132 with HTTP; Fri, 2 Sep 2016 07:34:24 -0700 (PDT)
In-Reply-To: <20160902090247.b5gtui75hiwococc@sigill.intra.peff.net>
References: <20160902090247.b5gtui75hiwococc@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 2 Sep 2016 16:34:24 +0200
Message-ID: <CAP8UFD2c+7OzVC7+sxrdCDg0LNx0_QZq=298qLd5o0+D3PnViQ@mail.gmail.com>
Subject: Re: Git in Outreachy December-March?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 2, 2016 at 11:02 AM, Jeff King <peff@peff.net> wrote:
>
> I'm happy to act as admin. We will need a few things:
>
>   - to arrange funding for the stipend. GitHub offered to cover this
>     last time, and if we are interested, I can see if this is still the
>     case. We can also cover it out of the Git project money.
>
>   - mentor volunteers. This is similar in scope to GSoC, but I don't
>     want to just assume that people who volunteered for GSoC would still
>     be available

I would be happy to co-mentor as well as for GSoC.

>   - projects. We can pull from the ideas that were not selected for the
>     2016 GSoC, but we may need to update or add to it.

Yeah, maybe we could also update the micro-project page
(https://github.com/git/git.github.io/blob/master/SoC-2016-Microprojects.md).
