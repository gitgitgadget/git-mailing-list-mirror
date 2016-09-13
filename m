Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8E820984
	for <e@80x24.org>; Tue, 13 Sep 2016 20:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760462AbcIMULJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 16:11:09 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38031 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760242AbcIMULI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 16:11:08 -0400
Received: by mail-wm0-f54.google.com with SMTP id 1so221650641wmz.1
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 13:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b/cWjQiFcPnOX+M5vehhRvHTnFM2A4xsq+yxaBseV70=;
        b=QUgWS0Z8MncqFZWYRhXeRLKDbtKSvN9UwhzTBpSYQ7FNkmy496gv1b0mDMfnTD/DfG
         bCmgSqrDoqzc7wD81oijV4dy1I7rijdCwfxIpKwdrIPFuSNKt+dpR/GJ4r1aPQdL8v7T
         ciPpny7oS6CwOk1x+uQqFYgYvXukBEIzREatwMD5Z5U6UFykpbZtR1FBGZYOPtSyjbwh
         fPe+XcROAB7i5XpWPmR0bIWPdoV+YDoIZpwqE2BIEM/dB59AwFGEX9uPdp0B+NJxBuQ0
         z4gQCMv+fk2qKG94oZWkiLeSexw864fq/Glce6xAz+mdB8zXiXPCJ1fhzHatFDhjbE9p
         QUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b/cWjQiFcPnOX+M5vehhRvHTnFM2A4xsq+yxaBseV70=;
        b=nNetPu9rsbPZUSeNUJWNm3QFyNJ2curwu6BRSQf+FXOieapygiQdiIt2wW2UG6R1ks
         gYTA7LmUb8IaAbC59IpW+2cBoVlma2rWp4hQKNS2LHIbKHVX8ox3Xqc1761vnt2jChJM
         TmK/7eLDqCVFo25R7pyuSh7X0uNBYNnTVQM8T+gvt5vaXlur5+yCL2u8k3SO3Qt9owfL
         mPigsXlcdxzY0CmlRK42MT1k9xwX+k6XsJuEXEuaG5/ydgcxXEdgnIJ/bryIX2hMF9Y1
         /WLpyaRO4KG2Xgn4T/HAh4YjW7wfJUOYBMrJlRlZ/yZeR6cDfoi7GjpPi5zT5ogCR0Lb
         eSVQ==
X-Gm-Message-State: AE9vXwMk6ta/BcOltbzIqmmQO/NxlQfRqN9dO9RgXWINwMvYJazkMFmLnBmCNmX9ms/Mlg==
X-Received: by 10.194.88.137 with SMTP id bg9mr21605220wjb.155.1473797466970;
        Tue, 13 Sep 2016 13:11:06 -0700 (PDT)
Received: from [10.32.248.227] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id e5sm6990354wma.13.2016.09.13.13.11.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Sep 2016 13:11:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [ANNOUNCE] Git User's Survey 2016
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CANQwDwcLrfkj96pqOM8b=TUWCf-Ui6s9WFo75MoWKfGGvsvZmg@mail.gmail.com>
Date:   Tue, 13 Sep 2016 21:11:04 +0100
Cc:     David Bainbridge <david.bainbridge@ericsson.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Doug Rathbone <doug@dougrathbone.com>,
        David Bainbridge <david.bainbridge@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Andrew Ardill <andrew.ardill@gmail.com>,
        Eric Wong <e@80x24.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0284BD61-8DCF-4EAD-8163-191C56AFD7C8@gmail.com>
References: <de39c03d-e84e-8e45-69cb-a2e01fd25df2@gmail.com> <DB5PR07MB14487D7F217ECA53CD712D60E2FE0@DB5PR07MB1448.eurprd07.prod.outlook.com> <CANQwDwcLrfkj96pqOM8b=TUWCf-Ui6s9WFo75MoWKfGGvsvZmg@mail.gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 13 Sep 2016, at 17:54, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>=20
> On 13 September 2016 at 18:15, David Bainbridge
> <david.bainbridge@ericsson.com> wrote:
>> Hi Jakub,
>>=20
>> You said:
>> P.S. At request I can open a separate channel in survey, with
>> a separate survey URL, so that responses from particular site
>> or organization could be separated out.
>>=20
>> Please can you open a channel for use by Ericsson?
>=20
> Sent (privately to David).

Could you send me a channel for Autodesk, too?

Thank you,
Lars=
