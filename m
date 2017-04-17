Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AFAC20A04
	for <e@80x24.org>; Mon, 17 Apr 2017 17:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754196AbdDQRia (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 13:38:30 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35393 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753860AbdDQRi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 13:38:29 -0400
Received: by mail-pf0-f193.google.com with SMTP id a188so26128933pfa.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 10:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qF6Rh+wpQQOdFGWGrLB1RIaT4o97l9uJztX5eZIXL2w=;
        b=q5L7nynmXNDCRzT4XkC4in675KRx5mSPqoVD4PyZ7E1OCJD5FNI/NuTStD79UBwTkj
         /FWVEVaNL9lSp8QsfkT7LBlniQiU9djUfhF0G0fqW1nksO+3fzWatufs7HVol0If/KWA
         P2zOS1ceDnzuKwtV5lHPL2ktb9NpQAfpnPZxn5ys+FXAzBlKMO02UrpA7WYVifzr9ouH
         3QHhtWYVZrNGOc+tmlFJDdjjOeiFC3AtfyIUTKtQW2dXvFyis5RoAkokZXiM3uPJiuzY
         H4T9kWQ+SeytxICvt5eFqzUfjJO0+WW5oibNMmbxk65Jl0HT6knF2I1iXwqZoA8mZU0d
         TWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qF6Rh+wpQQOdFGWGrLB1RIaT4o97l9uJztX5eZIXL2w=;
        b=szzmu2+4Zp88Mm+Y6CBPUPvTWR8Q+6SbF1e/AGhWZCyGFe9JpgOBw9SHAwVcOWlTdK
         xjkRm39YgdMcAqpDQ9lOiI3vwY71/MfbIjXZ7ht+XPwngwVyYHBflum/QUn3Szr12d3t
         RfjD+r6O33vNFoot4STVVSpaYxVESTnHAGVxFzDYKqgYeFiX+7J9bFWnChp4+x/Vjcfa
         U7snSOQxV9qvjCruYRGWcEJbo5DeH2wADtx8FZLwuiJW7Q0CFeUygALDi20jJ3yhs7dI
         k1sinxWOEiKOLINaEoAsXsbunilrnYkARjV30boRGVur0BxQ9nZoVYu36r83AwMftGKX
         DZog==
X-Gm-Message-State: AN3rC/7YVA/QB5T1KVriMg2SXNaNOMSbLkh47bARK+kVjxwOQ7PDIOvD
        8sHsfiFEJmjxgg==
X-Received: by 10.99.108.199 with SMTP id h190mr13166968pgc.99.1492450708182;
        Mon, 17 Apr 2017 10:38:28 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d10d:449f:8b4e:a37c])
        by smtp.gmail.com with ESMTPSA id o10sm19432110pgc.18.2017.04.17.10.38.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Apr 2017 10:38:27 -0700 (PDT)
Date:   Mon, 17 Apr 2017 10:37:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twopensource.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2017, #02; Sun, 16)
Message-ID: <20170417173722.GA8486@aiede.mtv.corp.google.com>
References: <xmqqmvbfij92.fsf@gitster.mtv.corp.google.com>
 <e6f869b1-09c2-88eb-d79d-b0dc2090a632@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6f869b1-09c2-88eb-d79d-b0dc2090a632@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe wrote:
> Am 17.04.2017 um 09:30 schrieb Junio C Hamano:

>> * dt/xgethostname-nul-termination (2017-04-13) 1 commit
>>   - xgethostname: handle long hostnames
>>
>>   gethostname(2) may not NUL terminate the buffer if hostname does
>>   not fit; unfortunately there is no easy way to see if our buffer
>>   was too small, but at least this will make sure we will not end up
>>   using garbage past the end of the buffer.
>>
>>   Will merge to 'next'.
>
> [Sorry for repeating, but I didn't see a direct reply.]
>
> If a host name doesn't fit then the buffer is too small.  Let's make it
> big enough, reducing the number of magic constants and avoiding silent
> truncation all at the same time.  Patch for that:
>
> -- >8 --
> Subject: [PATCH] use HOST_NAME_MAX to size buffers for gethostname(2)
> 
> POSIX limits the length of host names to HOST_NAME_MAX.  Export the
> fallback definition from daemon.c and use this constant to make all
> buffers used with gethostname(2) big enough for any possible result
> and a terminating NUL.
> 
> Inspired-by: David Turner <dturner@twopensource.com> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/gc.c           | 2 +-
>  builtin/receive-pack.c | 2 +-
>  daemon.c               | 4 ----
>  fetch-pack.c           | 2 +-
>  git-compat-util.h      | 4 ++++
>  ident.c                | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thank you.
