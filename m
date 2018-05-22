Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54DE61F51C
	for <e@80x24.org>; Tue, 22 May 2018 22:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753404AbeEVWId (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 18:08:33 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44561 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbeEVWI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 18:08:29 -0400
Received: by mail-pl0-f66.google.com with SMTP id m24-v6so328815pls.11
        for <git@vger.kernel.org>; Tue, 22 May 2018 15:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+ODaEkQeJ5Dmbk41NoRe/fmC9XzW9JC71T41SB1mdEo=;
        b=LSY3FoZENr7MMjq+QiicXG5D29l2XeA+WnhvApic8vSCdmUKPqPk6VIJiVmwaj8vWb
         L71BrcXW40+OJnXMxUrUFWOwNSthyjrIYdIUhOxM1cRn90/LegzPtoTc1z76b/AGuU+0
         AQAh2MJJLtA+ukh/VAgSVQqvAqGhBT3cUhecqSXhVGFY7p9ZnfBVWDbDyG7uiocrBUOf
         j+5Aw+ysMNwy6KfNIKzbKyViXLTp331+YFVVvvaKk9O+cUadwmkhrVIOS0wfn7ewki1d
         l10BPlo3SFxssx9G85+L5qolri6NJwx+5y8HJCK3B7MZTxfwKBYt8QEsXu10OTSbFOeL
         b43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+ODaEkQeJ5Dmbk41NoRe/fmC9XzW9JC71T41SB1mdEo=;
        b=EskzmMjaBCOEZdSob+J9FP8P1B3BIYUdMXAmA778ANaFVq5b9m/krcw0QcXkXPSeNX
         1zqoCXcx0ZIcIoLI8uYJKxZ6CpUu0NaXbC6S/TqnXB3zleAddex6Nw/LiJlF5zTQHum6
         vAMbHr+iiT3u4um+dp6RPh+3cIsQjhHgSBqWbph7OqG9rLoDI3Kvh0x2hfKUaYX0oxdY
         2K7dFy7+PpZdQPNnpBpAH7KeqWxEeJpbO85ln9m/S0MnY7fEcBiPa5SMKPj+WbsB7kZl
         dYRKtkJppMRgOfTbp8d4vBCl6zOTONDLCN9R+ka9fFNiBAzULY80tR5QyuN3BXKCDZUm
         +PGg==
X-Gm-Message-State: ALKqPwdPPov4+C0jTUyCi8X1sRDQ9vYz1J1/h9XinRmZEQibkVpfltdt
        l82kaPsykS9VZW74VTpivNZoBp2O
X-Google-Smtp-Source: AB8JxZpZMR3gGwE7iAapgJUxlo2jCjjefOBEH52fwNQxmxSv8Mf/STsfiXBQbDJEGgeqMLDp5aj9eQ==
X-Received: by 2002:a17:902:a5c7:: with SMTP id t7-v6mr262427plq.360.1527026908731;
        Tue, 22 May 2018 15:08:28 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j1-v6sm28759517pfh.95.2018.05.22.15.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 15:08:27 -0700 (PDT)
Date:   Tue, 22 May 2018 15:08:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] mailmap: update brian m. carlson's email address
Message-ID: <20180522220826.GP10623@aiede.svl.corp.google.com>
References: <20180506232421.975789-1-sandals@crustytoothpaste.net>
 <20180508015845.268572-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508015845.268572-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

brian m. carlson wrote:

> An earlier change, cdb6b5ac (".mailmap: Combine more (name, email) to
> individual persons", 2013-08-12), noted that there were two name
> spellings and two email addresses and mapped the crustytoothpaste.net
> address to the crustytoothpaste.ath.cx address.  The latter is an older,
> obsolete address, while the former is current, so switch the order of
> the addresses so that git log displays the correct address.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> I intentionally avoided the use of the first person here, because I
> wasn't sure what the preference of the list was on that.  Hopefully it
> reads naturally and isn't awkward.

I have no preference.  First or third person would work equally well
for me for this kind of thing.

[...]
> --- a/.mailmap
> +++ b/.mailmap
> @@ -25,8 +25,8 @@ Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
>  Benoit Sigoure <tsunanet@gmail.com> <tsuna@lrde.epita.fr>
>  Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
>  Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
> -brian m. carlson <sandals@crustytoothpaste.ath.cx> Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
> -brian m. carlson <sandals@crustytoothpaste.ath.cx> <sandals@crustytoothpaste.net>
> +brian m. carlson <sandals@crustytoothpaste.net> Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
> +brian m. carlson <sandals@crustytoothpaste.net> <sandals@crustytoothpaste.ath.cx>

Today I tried a "git shortlog" run and was surprised to find

  Brian M. Carlson (6):
      Add missing test file for UTF-16.
      submodule: fix confusing variable name
      submodule: don't print status output with ignore=all
      send-email: don't call methods on undefined values
      http-backend: provide Allow header for 405
      remote-curl: fix large pushes with GSSAPI

These commits use author Brian M. Carlson <sandals@crustytoothpaste.net>.
Previously they matched

	brian m. carlson <sandals@crustytoothpaste.ath.cx> <sandals@crustytoothpaste.net>

but now they don't match any line in the .mailmap file.

Should we add a line

	brian m. carlson <sandals@crustytoothpaste.net>

to handle these commits?

Thanks,
Jonathan
