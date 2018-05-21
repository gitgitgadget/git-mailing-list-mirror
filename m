Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D6C1F51C
	for <e@80x24.org>; Mon, 21 May 2018 17:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753553AbeEURhh (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 13:37:37 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:41215 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753633AbeEURgk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 13:36:40 -0400
Received: by mail-yw0-f173.google.com with SMTP id h11-v6so3930723ywc.8
        for <git@vger.kernel.org>; Mon, 21 May 2018 10:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=Gmy3k+a+bzz4W177saj4ptwoB36RYyMFY1hwypuQ75w=;
        b=fQ/G6LcmDQi0xyRpXT3W3SXj0LOobdRneQoKxV5NolUysUcItKN3HCZ9O17QKDNeJz
         G0KdG9fI/JLipHGapuIdBIsPcdZjipO0PJfknZ0ABbheJc07qdBgR4p7Phd6/hY7ZF06
         xJPzpn0WoEdTINoCLzaePNIpm0wPEur4Im7/Qc03GMsiBqiPZ1jHs/ON9A13CduVKit3
         57Tqtd3HDnGIV18Ny3FSKh6smGIOhJgrnOrHzBFLdMrJBiFgkiyIv6x8GmxWzfD1hAPG
         IKuoQxPJ/Ddqsh4RO8C1lCg+JUdPKvWyujaw3IOZPqPH3xjTDNKb6XADQcic3or8diEd
         71kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=Gmy3k+a+bzz4W177saj4ptwoB36RYyMFY1hwypuQ75w=;
        b=aHmHBmIV13GEJaazIPSgy+YLoRWcHWgLIUwpaM+yFx3y0Vq3ZU+auxbsHZac+d7wqJ
         IC0u0iuGKC5w3PYGwVMF+I0moVAVX9rVRWukvtUev8Sw/SvUDCTsaJOhndzwnCtww0Q/
         WJeRxJpClDrmknFCrIUNplFQvj2Aj7U5/JKr00uITAcFfNtBZ6k5h5ummm/vJ1ZgcLNu
         fGekQsK3754xlStj+cRPF7sCTOP1KQjbH/BR6TQZ5l85Y5WXywNswZTGx4sIQmoS3alx
         cxvDOaEKdAvVj1fwtEWaCbdoZOrgSEMZWZrAiUItPXKjhbIM8bwNs1WVJNZGaak+4MPN
         ntnw==
X-Gm-Message-State: ALKqPwcVdLoBv4LTzFp+GjbuhzoTTBf8bXW8bwHwtIzkJtzj6grxstXe
        wx8jt5Y3n35VlDo+x1+Qf3qe0hNTnlSwyg4Ai0C6Xk32
X-Google-Smtp-Source: AB8JxZp3+9T+lOP2ohgpwmNisXbLsnCf8UVkf3+0ZFlTuDD++zcibw2VerapiUmKh1vVIlK+uqgidKONCtNamfPl0gU=
X-Received: by 2002:a81:8801:: with SMTP id y1-v6mr10526548ywf.238.1526924199293;
 Mon, 21 May 2018 10:36:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Mon, 21 May 2018 10:36:38 -0700 (PDT)
In-Reply-To: <20180521015739.GE652292@genre.crustytoothpaste.net>
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com> <20180521015739.GE652292@genre.crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 May 2018 10:36:38 -0700
Message-ID: <CAGZ79kau121ZnwYVf0tFNvc1_G8Fxz55apgqLeok7Z8vQFZZdg@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2018, #02; Thu, 17)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>  Many tests hardcode the raw object names, which would change once
>>  we migrate away from SHA-1.  While some of them must test against
>>  exact object names, most of them do not have to use hardcoded
>>  constants in the test.  The latter kind of tests have been updated
>>  to test the moral equivalent of the original without hardcoding the
>>  actual object names.
>>
>>  Will merge to 'next'.
>
> I think there was one minor change Stefan wanted out of this series.
> I'll send a reroll (and tbdiff) with just that change.

I was just unsure how we treat [e]grep in our test suite, so I asked
questions out of sheer curiosity. I have no objections to the change
made, though.

Thanks!
