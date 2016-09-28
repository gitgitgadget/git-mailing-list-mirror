Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9D7F1F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 14:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932582AbcI1OaY (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 10:30:24 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:35287 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932362AbcI1OaW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 10:30:22 -0400
Received: by mail-io0-f172.google.com with SMTP id 92so61203405iol.2
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 07:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jMLqkcXW0uhHlqi3hM005xM114GEV7RoTAWfvgFkH/4=;
        b=ar0B0FmC5PqRlxC5xQIzMeAnjYUj+9TslVAsJIvq3HeiAcEm6Ooo176DlgvdoJAyDq
         4OfmQUHwowwd+0h0T800OKE6V/+PmLkRYayjJejERAyyA4JeXrQgpdXCb5DJjqCtTx8N
         yrjyRXw4pYPlnpCuPAvsB2xpZfxrQ8HYixSkeWlGH0e3mcQao0psPCu43ZpGKY5dVBsB
         9CtWXl5SOfBbQZRl6t+FJVP/7N5GY+G4KwVcC88Zy8Bi8lEe3vfyFjHXjtQZjuxSUKBQ
         kn9cnxcDj/a5W7sBma9fpOkC1hBjpYEXE/iu1JmYkBjgnt8fPUE0PU3BVCeRqtFkNR4+
         1PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jMLqkcXW0uhHlqi3hM005xM114GEV7RoTAWfvgFkH/4=;
        b=R2mHzkZ4YWBsCv0ebbgBNAgi7/wMSGU33/NzHK9++LCLXGRnVtaiP07fHQbXL1pfMd
         RoNBA8ia5FDWV59rek+AfzulQtxhQFdgD3hRb8gMnbwPp1hpFUh/Q7RF1w1auccNuy8Y
         KImIufjcXqPyIoNsPl7DC7DzFq3Yw7lJFwZhIsevxDJ2jJzvwZTiQYDk3H5Jsud1Lxt/
         G3GYAHyJmV7kPxRaGbr3o/G308nyeQXVQJJz+NpSH4LSreG2hrGU7ezLzcASyvxtRGAV
         BqEd30wONLrUy3/+cDpTFOI49oUf37KCz09nIuncHFhhtPo945vpDnku6tzKod8RHD3I
         DmBQ==
X-Gm-Message-State: AE9vXwM1qSPcOs/YX/EGl6MrLSrSYNjOSmWgvl37962VjTxqSgCInrYY60bMco1h3AyG6Wl/avEwfMfwy+Q7Yw==
X-Received: by 10.107.30.69 with SMTP id e66mr34534690ioe.107.1475073017540;
 Wed, 28 Sep 2016 07:30:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.21.6 with HTTP; Wed, 28 Sep 2016 07:29:47 -0700 (PDT)
In-Reply-To: <1475066620.3257.12.camel@sapo.pt>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
 <1472646690-9699-2-git-send-email-vascomalmeida@sapo.pt> <xmqqr387y4le.fsf@gitster.mtv.corp.google.com>
 <1475066620.3257.12.camel@sapo.pt>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Sep 2016 21:29:47 +0700
Message-ID: <CACsJy8BUaJ8sRw2EtgrTe0X4khCsuKFD75ON12oC1FvqdMXr=g@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] i18n: add--interactive: mark strings for translation
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2016 at 7:43 PM, Vasco Almeida <vascomalmeida@sapo.pt> wrot=
e:
> A Dom, 25-09-2016 =C3=A0s 15:52 -0700, Junio C Hamano escreveu:
>> > @@ -252,7 +253,7 @@ sub list_untracked {
>> >  }
>> >
>> >  my $status_fmt =3D '%12s %12s %s';
>> > -my $status_head =3D sprintf($status_fmt, 'staged', 'unstaged', 'path'=
);
>> > +my $status_head =3D sprintf($status_fmt, __('staged'), __('unstaged')=
, __('path'));
>>
>> Wouldn't it make sense to allow translators to tweak $status_fmt if
>> you are allowing the earlier elements that are formatted with %12s,
>> as their translation may not fit within that width, in which case
>> they may want to make these columns wider?
>
> As far as I understand, %12s means that the argument printed will have
> a minimum length of 12 columns. So if the translation of 'stage' is
> longer than 12 it will be printed fully no matter what. Though in that
> case, the header will not be align correctly anymore:
> for other instances of this in the present patch series.

It's 12 bytes, not columns (unless perl understands input string's
encoding, which I doubt). Think about multi-byte encodings like utf-8,
where three letters (or "columns") do not necessary mean three bytes.
The result is most likely unaligned in that case.
--=20
Duy
