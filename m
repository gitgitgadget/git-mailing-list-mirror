Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 283B31F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 19:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756007AbcJQTqz (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 15:46:55 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35081 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758570AbcJQTqm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 15:46:42 -0400
Received: by mail-qk0-f182.google.com with SMTP id z190so254638625qkc.2
        for <git@vger.kernel.org>; Mon, 17 Oct 2016 12:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z9ZKIMEk63KqepIb+MG3pbirFrsGvROL4JrhjIQZCpA=;
        b=Og/PbS1Pw/mbWlDy1aXD1y37doB+DP2HHW9o2ndFAH6Q44jsJGYM1lFVvTw7CjHX2m
         80mOuNFepjDazXmz351DUvZBRBK7cuUYU01QkLKcvOFA+RO/Dh4+1bwozXfdz9dTyTXv
         PE4vWWiweQ56BmUjZ4zI62mMGhI7oGXerTTq7Rjb8+QfUpW3Q5NP+ez6IR78vG44gW0H
         Vzvh3R4lwV1Ake3ROMQ6XWR9v5Y+z5N3GVl31lywyn3waJF4eRC/3tJIRn1a6Vk3PmbD
         Ul9pjtAzaLEW1ONmaH77oReV7SAVtnPbNBaOslUQt31/lbxj9Z1YizOBy1kygw1DOFXS
         Robw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z9ZKIMEk63KqepIb+MG3pbirFrsGvROL4JrhjIQZCpA=;
        b=JtKSRzUKVPW7RDod3AMWZ8TdLyD/tzIdVVRrGNwCfbO/jAGRkJDFosLr0R0mPR0YVi
         4hbevK3mqDJntOXoAMDeC8SMgTIsLbQbQOUA3j7dkFW1mrRg19E+yCTTnd0Hs5zd+i53
         sN5OiEyZgahUmQ/l5OOxy2ny5A6g7XDQIy60TsRyOutxDJRPg5c/xkKTjWmvLBGrVRWe
         keRbSQQPMt2Cy3KEgdIYTfbTje8/wR5MdDwNo2ij75U+WSiKc3wcqzYNdV9RvAill8nu
         YfWmISoAOad9X0kTIsr9+WIgv2raQIIonMONHXKtyfUBw852+c7eThZRc4CglDHKqRds
         Im8A==
X-Gm-Message-State: AA6/9RlKimn8QGu/ARdW5u96fs/qGIPnH1ufiH7ZJUxOXU38a9qCm7d17/uDlQMmVUekzBmudnk3W0UC3ICMFg==
X-Received: by 10.55.77.148 with SMTP id a142mr30590400qkb.157.1476733602084;
 Mon, 17 Oct 2016 12:46:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.217.79 with HTTP; Mon, 17 Oct 2016 12:46:21 -0700 (PDT)
In-Reply-To: <xmqqbmyiykzz.fsf@gitster.mtv.corp.google.com>
References: <20161006091135.29590-1-avarab@gmail.com> <20161006091135.29590-3-avarab@gmail.com>
 <3fa9902f-3b01-5ec6-8129-34cff4c7cac9@gmail.com> <xmqq37jyzsdk.fsf@gitster.mtv.corp.google.com>
 <CACBZZX4FK+zrVyBTpbJAbSAxQ9LuCTXcExeEqZE6D3nwHbNxZA@mail.gmail.com> <xmqqbmyiykzz.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 17 Oct 2016 21:46:21 +0200
Message-ID: <CACBZZX5v79g=xMEQiWHNm8563+OaQb-L_cmr6VnoxevapHqesg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] gitweb: Link to 7-char+ SHA1s, not only 8-char+
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2016 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> As far as I can tell the only outstanding "change this" is your
>> s/SHA1/SHA-1/ in <xmqq37k9jm86.fsf@gitster.mtv.corp.google.com>, do
>> you want to fix that up or should I submit another series?
>
> I think I did that already myself while queuing.  Could you fetch
> what I queued on 'pu' to double check?

Thanks, looked at it, looks good to me!
> I think the diff between what was posted and what is queued (I just
> checked) looks like this:
>
> -gitweb: Link to 7-char+ SHA1s, not only 8-char+
> +gitweb: link to 7-char+ SHA-1s, not only 8-char+
>
>  Change the minimum length of an abbreviated object identifier in the
>  commit message gitweb tries to turn into link from 8 hexchars to 7.
>
> @@ -5,16 +12,18 @@
>  SHA-1 in commit log message links to "object" view", 2006-12-10), but
>  the default abbreviation length is 7, and has been for a long time.
>
> -It's still possible to reference SHA1s down to 4 characters in length,
> +It's still possible to reference SHA-1s down to 4 characters in length,
>  see v1.7.4-1-gdce9648's MINIMUM_ABBREV, but I can't see how to make
>  git actually produce that, so I doubt anyone is putting that into log
> -messages in practice, but people definitely do put 7 character SHA1s
> +messages in practice, but people definitely do put 7 character SHA-1s
>  into log messages.
>
>  I think it's fairly dubious to link to things matching [0-9a-fA-F]
>  here as opposed to just [0-9a-f], that dates back to the initial
>  version of gitweb from 161332a ("first working version",
> -2005-08-07). Git will accept all-caps SHA1s, but didn't ever produce
> +2005-08-07). Git will accept all-caps SHA-1s, but didn't ever produce
>  them as far as I can tell.
>
>  Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> +Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> +Signed-off-by: Junio C Hamano <gitster@pobox.com>
