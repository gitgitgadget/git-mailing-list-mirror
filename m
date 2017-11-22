Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3E17202F2
	for <e@80x24.org>; Wed, 22 Nov 2017 07:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbdKVHOc (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 02:14:32 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:46331 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdKVHOb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 02:14:31 -0500
Received: by mail-io0-f172.google.com with SMTP id q64so9319847iof.13
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 23:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wDvRA8NhYMXY2Ui1tHo/2b1Tc4cj0Hc+e4FvRB7UA38=;
        b=rqqk57YmW4pD3sy0DBbTgJtwpVhjzo59eKQsnO3b/QdO4tGVR4Wpvxyz06oyVFlgsL
         2vruEdWXw1Okw75f2PyKGestxFfelTnHoKmLNgiFyhsaFp1/N4Q80wf/YvSwZRICV494
         2IU0hloyb1prPkAV2Z7HcUc0WHAS49eeS+3IS14GiX17tyZk4ZCvecmK0e4Ddxm8yosI
         zN0fodjzBZMM7ci1FQDEqgqlPzpEtXkoy5V5zYTYxAzjgy+lq/SSI28lg7hms5adMtbC
         /6VZj4ru+ktnHbYt9Zyu85JmngLlef3kwYuiNwdZTHmYGAe8UZ6ybyH9y5mPOo6H2ji1
         wm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wDvRA8NhYMXY2Ui1tHo/2b1Tc4cj0Hc+e4FvRB7UA38=;
        b=d3sSs9HzQkEAqqhQR18QoJuZh/AGPgeAsuvlFQILZUumSOf5pYr/qESPR+G2hEqcyh
         9JutkQ+r+H+gsBXnUwHTERDZU6Zpk6cbI5FD5FXiDtFoLiWyKzhfXYM3FKCdTLmck00h
         DmuTnJgeFfSBDKZ2lmegKHoI5v+ogxjAMAGRTCeDtmip7+49mBpCjNwVCUL3BljVClO2
         +DgfgN4SiptW/myGcM/u2cR9GvXm4/MfkDM13U5np2zWi2PMg4Hwl2BplYEVt7uzrkdV
         5orTfpgJI/YP0Qf5QdZJDVu158k1zINMYbnVrICa5QrUW3TOUvUtVB9bRsJ+EDpPWwXE
         Khfw==
X-Gm-Message-State: AJaThX7dSh5EFO9udeAOT2gQpCeFDZS9hHjJa/eWW6FxtFJ129GE+8zU
        qxdQjT9pC4Thxs6X3enpe6D6sCEVaBZWLOxlmNA=
X-Google-Smtp-Source: AGs4zMbw2DOGLW4YJmX4ByDeEKaOeJhosM1VqpJmSydutlCE3sTdkPon3lE2myrF2PFlXd2cmDd4Zj5fJ0g4bQ8JbIQ=
X-Received: by 10.107.20.21 with SMTP id 21mr22312700iou.116.1511334870998;
 Tue, 21 Nov 2017 23:14:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Tue, 21 Nov 2017 23:14:30 -0800 (PST)
In-Reply-To: <xmqqfu96u8s4.fsf@gitster.mtv.corp.google.com>
References: <20171121160939.22962-1-chriscool@tuxfamily.org>
 <20171121191900.GD3429@aiede.mtv.corp.google.com> <xmqq60a3vv63.fsf@gitster.mtv.corp.google.com>
 <20171122051014.GA7625@aiede.mtv.corp.google.com> <xmqqfu96u8s4.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 22 Nov 2017 08:14:30 +0100
Message-ID: <CAP8UFD3sL4etgtbHFbGChF36ggARsr5961F5CZuZhSZY_z_1-Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] Git/Packet.pm: rename packet_required_key_val_read()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 7:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>>> This comment doesn't tell me how to use the function.  How do I detect
>>>> whether it successfully read a line?  What do the return values
>>>> represent?  What happens if the line it read doesn't match the key?
>>>
>>> Would this work for both of you?
>>>
>>> # Read a text packet, expecting that it is in the form "key=value" for
>>> # the given $key.  An EOF does not trigger any error and is reported
>>> # back to the caller (like packet_txt_read() does).  Die if the "key"
>>> # part of "key=value" does not match the given $key, or the value part
>>> # is empty.
>>
>> Yes, thank you.
>
> Heh.  I actually was expecting a different response: "that describes
> what the reader can easily read out of the implementation and is
> useless", though.

I was going to resend without the comment after Jonathan's first
email, but I am ok with either your improved comment or without any
comment. Thanks.
