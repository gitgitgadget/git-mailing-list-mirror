Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE16920401
	for <e@80x24.org>; Wed, 21 Jun 2017 16:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbdFUQZM (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 12:25:12 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33986 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752729AbdFUQZL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 12:25:11 -0400
Received: by mail-pf0-f170.google.com with SMTP id s66so87089233pfs.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 09:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gLSfiQo9JjIkUCseDUqQZ9h0p6Sa2Pho4duthfcwvSw=;
        b=i+PVTkUdKo/2CPyLAzsXxJ0/HYpymiZPToYI8l0oLCbuD6O5X65cQDdbp5AA2CMwId
         2ucnQHieilM1HmdfpsceHIj8O+YCMJ4Qo6oVOIbGO3CqiLVJghyAK0glcS5/iqC+w1Em
         RXXoHJUXcGvYtDrtNYwNA59DDj8AquAIWyLMiBOpjpJk5S+QLCEKo5S9+OT5bDf5EB4N
         SO+6OyfIViICaeh0kYhaI9T4Rvo2foS0bktq1qlVkvikigpKLyknQzzJZbVXAEZHnYrJ
         pzMVaQQbWmO28v/yJMftJCoSIy609sCo/cUW5NhAUs2ktCnMmxXHsG/oIRHkZGU67y5K
         z1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gLSfiQo9JjIkUCseDUqQZ9h0p6Sa2Pho4duthfcwvSw=;
        b=MLOIOmVD+MFMu987/iaK4cWbei1e+rD0hWngSZSWQQLER3YCtlZetS+h30Er4sF9k1
         0X+/uM08nIxwgoZCJ1JRWVgP7OU/F79omE6gXlHQ0PvTwUhd+y2dpqt0eKLthPq1WTsD
         k4StctUteqS9Ixc09g5+NghWMeEFp1f2hGrrB8GXI0J3OtqeKC0MK6mccazZ5DtYiPV+
         4SYCl7/c4wl+HIR/TD24hi55+JykXpGV232DyJVjpFc/mosl1b2rF0GYKZ/4lBOnstHV
         VpPVe7I+NIvqohuTsqYl+7Hs71DI1PWCdHzFsODnfActCho0YjwPQnN2yBIQBjy0wINS
         MBCg==
X-Gm-Message-State: AKS2vOzqQoKYAOR2iQ1FsTeQNuKrLMyRd+pm4uIpIgZ40s8a1HsGNNsQ
        W8RmiKzXr1iyCBiWaQvyTswpURdSA1GGtDo+TA==
X-Received: by 10.84.232.205 with SMTP id x13mr18337909plm.245.1498062310321;
 Wed, 21 Jun 2017 09:25:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Wed, 21 Jun 2017 09:25:09 -0700 (PDT)
In-Reply-To: <20170621135130.6724hnoovcjfduto@sigill.intra.peff.net>
References: <20170420204118.17856-1-dturner@twosigma.com> <20170420210254.f4ykyi46bso5uj3o@sigill.intra.peff.net>
 <20170621135130.6724hnoovcjfduto@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Jun 2017 09:25:09 -0700
Message-ID: <CAGZ79kZLcNdN0TsrHwm8YoAXx7tjWoWV29j=xyQFgUuNPouUOw@mail.gmail.com>
Subject: Re: [PATCH] docs: update 64-bit core.packedGitLimit default
To:     Jeff King <peff@peff.net>
Cc:     David Turner <dturner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 6:51 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 20, 2017 at 05:02:55PM -0400, Jeff King wrote:
>
>> >  git-compat-util.h | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> This probably needs an update to the core.packedGitLimit section of
>> Documentation/config.txt.
>
> Looks like we never did that part. Here it is (Junio, this goes on top
> of dt/raise-core-packed-git-limit).
>
> -- >8 --
> Subject: [PATCH] docs: update 64-bit core.packedGitLimit default
>
> We bumped the default in be4ca2905 (Increase
> core.packedGitLimit, 2017-04-20) but never adjusted the
> documentation to match.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/config.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index f6278a5ae..fc2cf1fe1 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -683,7 +683,8 @@ core.packedGitLimit::
>         bytes at once to complete an operation it will unmap existing
>         regions to reclaim virtual address space within the process.
>  +
> -Default is 256 MiB on 32 bit platforms and 8 GiB on 64 bit platforms.
> +Default is 256 MiB on 32 bit platforms and 32 TiB (effectively
> +unlimited) on 64 bit platforms.

nit: I would have not written "effectively unlimited", as we state
the limit right here. The further sentences already sooth the
user to not worry to much:

    This should be reasonable for all users/operating systems,
    except on the largest projects.  You probably do not need to
    adjust this value.

But as we just adjusted the default to prevent a bug,
maybe there are good reasons to adjust the value for users,
too? (Specifically 32 bit platforms could run into the problem
that the commit be4ca2905 (Increase core.packedGitLimit,
2017-04-20) states.)

While I think this patch is worthwhile applying (even as-is),
I think we might want to put another patch here?
Or is there a way to fix the underlying issue when fetch and
repack is run at the same time?
