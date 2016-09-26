Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6653207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 17:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754800AbcIZRSp (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:18:45 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34158 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbcIZRSo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:18:44 -0400
Received: by mail-io0-f173.google.com with SMTP id e66so99648311iod.1
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 10:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=lgEC6H1NCYOrQIz4MiYG746SVEl4Expv1Czu1+xkbu0=;
        b=AwJJXsrRVHDEkmcC7Ej9xspop5h99FZYu1PIuKkJS2qXkZG3bWYJocH6ka93MNTLXc
         5o5XjZ3RsNNDBeISzLpN3suZGSWqJ9MH+SvfGXWI72fBfTumUEPMXTaTlEL9vyvkkJjI
         LT8gSXxCGQPBxd2vSxqBrh1018yCU7QNMeqE7VIv4DO8BeKlOGsAxVWozVREu0CL7k/J
         hmtq37LC+Txt0zETIClZ3xIL/FzD0eH5lWwmxZDlrfWX0a51JCiSIppOuMHxOx7mF4oO
         nMl7gOOUCzgRkjBa5cZIIQnTv7PEYun28lu9bgqU3Fb3d4CelKc+ux86cS2gz8eABJO2
         nWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=lgEC6H1NCYOrQIz4MiYG746SVEl4Expv1Czu1+xkbu0=;
        b=RQZ+5rlGmKVOwzKX1Mq6+rU5tNZDd9m0GZZmsWZShYdUgxUFtFnSe9s6o0wkVHAm+X
         on1CaFHIVVQNYxl66aUT0vmMpithdkSd8H9A6LgT5cnw7FD/Nvn9bGK80HhZp3yTBC3s
         wHY98k9OCzMnn5mMI+R9MxNpM9UmMVIg+1H0KAVN2eMNBqWfC0RseIXDQqQFBDHj/K3x
         UiQ2i0u0aIBTjznmK66vlnwO34Gqg7P9e9JmgK0KRy91s4oQ5xQtwKyjvj2Xvhhv7RKS
         Eunyh3omE2hb0bg1HWVguY3c3uiavjPxBRMOWAzIj7a8CnImjzU6Fu+35FAvLQNPOYEL
         gGvQ==
X-Gm-Message-State: AE9vXwO72YwktAh2+eZG8hSO4b1O44NW0+5ZXKGubVKRCDT4fk5VWc6EKn3KtiWskNI5LA==
X-Received: by 10.107.137.170 with SMTP id t42mr23584766ioi.25.1474910323608;
        Mon, 26 Sep 2016 10:18:43 -0700 (PDT)
Received: from lylat (S01061859339e9903.ss.shawcable.net. [174.2.107.88])
        by smtp.gmail.com with ESMTPSA id o188sm4180682itg.11.2016.09.26.10.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Sep 2016 10:18:43 -0700 (PDT)
From:   Alex <agrambot@gmail.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     git@vger.kernel.org
Subject: Re: Request: Extra case for %G? format
In-Reply-To: <f056af47-ca98-b35c-e343-9f246c0c8f5b@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Mon, 26 Sep 2016 13:53:57 +0200")
References: <87d1js1pl1.fsf@gmail.com>
        <f056af47-ca98-b35c-e343-9f246c0c8f5b@drmicha.warpmail.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Date:   Mon, 26 Sep 2016 11:18:23 -0600
Message-ID: <87y42ey3z4.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> Then currently %G? results in `N', the same as an unsigned commit.
>> 
>> In this case, could %G? please result in a new character? Perhaps `M'
>> for "missing public key"?
>
> Yes, and no.
>
> Really, there are many different reasons why a signature couldn't be
> checked, but gpg itself has these status results:
>
> "For each signature only one of the three codes GOODSIG, BADSIG or
> ERRSIG will be emitted" (doc/DETAILS in gpg's source).

I see. It seems in GPG2 that got expanded to:

"For each signature only one of the codes GOODSIG, BADSIG, EXPSIG,
EXPKEYSIG, REVKEYSIG or ERRSIG will be emitted."

I don't suppose it's worthwhile to support the others? I'm not sure how
important the rest are.

> ERRSIG comes with additional info (RC) that could be parsed for the reason.
>
> Also, in addition to that line, there can be other lines with additional
> information. So there is a lot that could potentially be shown (and *is*
> shown with %GG). In the GOODSIG case, we parse the TRUST info to take
> the trust model into account (and return U for untrusted good).
>
> I wouldn't mind adding E to %G? in the ERRSIG case, even though one has
> to look at %GG in any case (N or E) if one wants to have more details.

That would be great. As long as %G? can tell between a signed but
uncheckable commit and an unsigned commit, then it's good for me.

>
> Cheers,
> Michael

Thanks,
Alex
