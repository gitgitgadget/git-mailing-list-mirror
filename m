Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FDD42047F
	for <e@80x24.org>; Fri,  4 Aug 2017 16:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753153AbdHDQme (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 12:42:34 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37492 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752986AbdHDQmc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 12:42:32 -0400
Received: by mail-pg0-f65.google.com with SMTP id 83so2258946pgb.4
        for <git@vger.kernel.org>; Fri, 04 Aug 2017 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GN83Ip8nbeGt2pEH2z1iaGUygpGEuuuIJhH9pqGwH4g=;
        b=cM3SSx48mD8UnGEHan1cExSRQvoX2XvcC+jc8czOjtwR/nDi9Ir/GPFHDiW9BeLq7r
         R7OfJr4DsjFxsH8WOH9gyk5HQZkrnklbm4FLx9Q411CL4Jf6rGra68OIAOkO6/hhbH8x
         gJFb1qyUlMwqFLGXWIB2J1IfKUsUOPBgG0LfI07WVZZwlHsLXFVOiDFpMRaS2jj2PoDf
         BT+qxbtLQQr207CzrXuQaBFjmIaet2LDfAjjYruSSRTCodoV/gsR88OOZuyNHjOEYl6Q
         aIwXVse9DgAGdotbLNnw2tDrFq7IYRBrOlovcU9WImEOZiBadJJgGx205l3ddfqc9YIj
         fJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GN83Ip8nbeGt2pEH2z1iaGUygpGEuuuIJhH9pqGwH4g=;
        b=DEq0W/l7WeviPwhiJEW72ygmKKCEl3gM58SNAP01gP2YM7KGO7SOpnUfKbLB1ZGRFu
         CgIlXMCrbwfmcvfzL1BvfCcSUjEyY8PHBNmP+mlWmD8c00Sl6DDbKTeZTlTLvevbGb+F
         QCl01VkMsKgIu7sGYfyKSBH/F9cVdCNFuY0qx9G5ruoDde4OBv4ZFWxOZzx5D9LabRom
         N1LfXU3KTiN0FuFifh4fKp+VpTPz/i6lEkv+pBzg9VOHrBlLUbjaj9sWSGNik8PtmnJ0
         V5Kvo4R4cSJNrG9Oeu3dFdSszCc5ZZ2/NCm3DbaVY/HlFvkhAYcHRVtmTK6V6T+wdaGa
         WGig==
X-Gm-Message-State: AIVw112MbVqDQjRV6jxAxfa13chzk9K/ZeaW/CJTotOEFi63/gRFFS0u
        Jlc2jzK4GzCzD2Ev0en59OR+ah1lPH/G
X-Received: by 10.98.220.134 with SMTP id c6mr3145387pfl.253.1501864951812;
 Fri, 04 Aug 2017 09:42:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.238 with HTTP; Fri, 4 Aug 2017 09:42:31 -0700 (PDT)
In-Reply-To: <xmqqzibfuxu9.fsf@gitster.mtv.corp.google.com>
References: <cover.1500321657.git.martin.agren@gmail.com> <cover.1501701128.git.martin.agren@gmail.com>
 <e660a9cdaff6d114305a475f9a12876b56b473d1.1501701128.git.martin.agren@gmail.com>
 <xmqqpoccpmux.fsf@gitster.mtv.corp.google.com> <CAN0heSrP=HeUcpfwXS9DyzCYCnCCocyV4iCHyAxrYPmW=LgZ+g@mail.gmail.com>
 <xmqqzibfuxu9.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 4 Aug 2017 18:42:31 +0200
Message-ID: <CAN0heSq=YE7ep57V6+3M3DKcyamutjug7EkxdXpG5HnSGT-f2A@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] builtin.h: take over documentation from api-builtin.txt
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4 August 2017 at 18:00, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> Since this is my first code contribution to Git, I'll ask about this par=
t of
>> SubmittingPatches:
>>
>> "After the list reached a consensus that it is a good idea to apply the
>> patch, re-send it with "To:" set to the maintainer [*1*] and "cc:" the
>> list [*2*] for inclusion."
>>
>> I will boldly assume that I should not be doing this. It seems to me thi=
s
>> doesn't happen very often or not at all -- possibly because you tend to
>> be involved in virtually all threads anyway, before the list reaches a
>> consensus.
>
> Yeah, that is in the "ideal patch flow" section, isn't it?

Yes and no. It's in the main part above it, under "(4) Sending your
patches." But you are right that the ideal patch flow section then
says the same thing: "(4) The list forms consensus that the last
round of your patch is good. Send it to the maintainer and cc the
list."

> We
> rarely achieve the "ideal" and often instead go for a more expedited
> option, it appears---perhaps I should try to be less involved in
> individual patch reviews and place more review burden on other
> reviewers ;-)

:-)
