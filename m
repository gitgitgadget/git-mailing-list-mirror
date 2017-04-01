Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 037ED20958
	for <e@80x24.org>; Sat,  1 Apr 2017 19:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbdDATT2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 15:19:28 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34805 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbdDATT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 15:19:27 -0400
Received: by mail-pf0-f169.google.com with SMTP id 197so6652363pfv.1
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y1ruX6zYOGpIQNUDgK4/H/rBT6G9xEljPufIGJJhgns=;
        b=D4V0ta37ADtM3wQxnXaifkleIZ3YtFACq/bMqKaDl6lYlAc6oUFei8x23ugGXYLIQE
         aqM1Uy0S+j1UI8rOu8b8vas4iSMhefPCQTGnJnHYOB+CsIR6L+78wiZQmebZCfYcqO3i
         DvQ9H7smAoFv154b8zEBpkVQ/camIaDDUybpv0SIAoQ6MyJj05zGX07fJ2nMgFwf3mFG
         sCOTMkx+HRc1ZKTTSnEuEMVu1SK2OiOl7MlXHs/b502yoYGhRd3s9tAAwINssZiRWNph
         2fZW1oAKmza34QJZEbpP3M2sD0nTdMZVP4yDu9bFOsKDsBVR5SdXZnC5W1ZgGYcUjqpH
         QKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y1ruX6zYOGpIQNUDgK4/H/rBT6G9xEljPufIGJJhgns=;
        b=uGNrGT9DKafbytLMgdiJaVm5ImHouq7mYPm9suU9S+bxpHFRUBtfr36UKwX3b+15nd
         XOG83B+l5NNDdwUOENpTOM1oljWdxlVAfMIhWVI54ABzVHL/95myAqTw6DSciE3KMlvB
         jpxE3Bbz1f50wWxKiW0E7aR0PFjRw8ylim1ylT83miJP+n9yjsc/aobntfY/Zsjcch9b
         U4/o5bbTmAl/0vauyxBOanyqp18taZRFnEySHBUfPqUJjVcn9oFCSVpb0cPB4fwRw+im
         jnNNR167XJMzwlCYB2PH4GZqRxnn1SsI/IEhB+vKgJ+Op4O+1Co7Vt3HeG3pI8gYdGhU
         I1aw==
X-Gm-Message-State: AFeK/H0haQXisFSq2OoJw53yFrRrRTRtAs9tqbxPNCgkf0DerzfYVU+uWc8jDBg2CxDua0r9OZvkaoLs56rmBA==
X-Received: by 10.98.59.151 with SMTP id w23mr8612992pfj.235.1491074367147;
 Sat, 01 Apr 2017 12:19:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.15 with HTTP; Sat, 1 Apr 2017 12:19:26 -0700 (PDT)
In-Reply-To: <xmqqtw68szz1.fsf@gitster.mtv.corp.google.com>
References: <20170401153049.21400-1-robert.stanca7@gmail.com>
 <20170401153049.21400-2-robert.stanca7@gmail.com> <xmqqtw68szz1.fsf@gitster.mtv.corp.google.com>
From:   Robert Stanca <robert.stanca7@gmail.com>
Date:   Sat, 1 Apr 2017 22:19:26 +0300
Message-ID: <CAJYcaSNAB+1gth2NkTjrcBV9TXT9bRsBQhwOsQCmnudYz5bTmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] show_bisect_vars(): Use unsigned int instead
 of signed int for flags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am used to 1change per patch so it's easier  to redo specific
patches...if there are small changes(10 lines max) can i send them as
1 patch?

On Sat, Apr 1, 2017 at 10:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Robert Stanca <robert.stanca7@gmail.com> writes:
>
>>  As rev_list_info's flag is unsigned int , var flags should have proper type.Also var cnt could be unsigned as there's no negative number of commits (all-reaches)
>>
>> Signed-off-by: Robert Stanca <robert.stanca7@gmail.com>
>> ---
>
> OK.  I would have squashed these two commits into one, though.
