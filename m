Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE16B20997
	for <e@80x24.org>; Tue, 13 Sep 2016 20:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755510AbcIMUhI (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 16:37:08 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:38345 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753804AbcIMUhH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 16:37:07 -0400
Received: by mail-it0-f45.google.com with SMTP id n143so57019450ita.1
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 13:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XRbQ/3SA4PrQEa2DK6lKKNZaOi7R58VsG+TckdIVmCM=;
        b=HcKr0SmTJOEaSVo/z4As8wCWwnd2F+Kut1XN1hfaAoquAHv1fR/f+fKV5GrzZ/deQ0
         5gGgomkKatVtpFiucoeWcmigoh108/7dvw9Ev+onu1wbzDz8rYEEFexYdqegCH9724CZ
         7tjNKfNMend8sTe1ODt83pP83+Mfm8dx6/+mgx0Z5dmAyIc1Ag15VUAkNQF4wouXSVR7
         a7Diu8SpetJ62+AzED6NMxY+Lw2l3F5wz180hPEt5Jwfr/7p/SIPRt9ajA6NRbdHwrwb
         X/vOwYylGMxbdNanQ600MRXpyeP77yDmSxKsQ1UL9hJjnxb/W/8p5jCdlz/brQcs9uTX
         fIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XRbQ/3SA4PrQEa2DK6lKKNZaOi7R58VsG+TckdIVmCM=;
        b=KGWDiUm0hpN2mVDwbrhzVRbwKxGqhfKimHCWIsio5jyKljAhMAFnGxznHC7eFPvzF7
         /q2q1jllAb51IU8HumCeKQsIDkaWWoLX4DEKj+yl29EtBilSKwqmUIy9wdDoVzrvSyyy
         fm+2IwToy9edMusOfHT0fVxyrZBAa0ihOSD1kJNcJ5YksdLYeSEiXNAlPJ3U3IuBEX3x
         uf01sy5genppXss34bi0zXGM370YmmC4sZFlXdd/4Vs0lFJpiVHXCjvO5duzjbvrSZpO
         NEjexsKTy7d2/mTP52Ynlv0c5/f9blem1GTY3jayzyGnsokwYaEJUGCFwrnQ2jizusqD
         n5gA==
X-Gm-Message-State: AE9vXwNYvGH17yIHJnHm87+cNICPXR6KAalZm7+RlSq9Ws8Lf3RvFoVCtHlIwGkA76FzIOQ3sFnw3zEYP5n87Q==
X-Received: by 10.107.55.85 with SMTP id e82mr4907793ioa.14.1473799026875;
 Tue, 13 Sep 2016 13:37:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.226 with HTTP; Tue, 13 Sep 2016 13:36:26 -0700 (PDT)
In-Reply-To: <0284BD61-8DCF-4EAD-8163-191C56AFD7C8@gmail.com>
References: <de39c03d-e84e-8e45-69cb-a2e01fd25df2@gmail.com>
 <DB5PR07MB14487D7F217ECA53CD712D60E2FE0@DB5PR07MB1448.eurprd07.prod.outlook.com>
 <CANQwDwcLrfkj96pqOM8b=TUWCf-Ui6s9WFo75MoWKfGGvsvZmg@mail.gmail.com> <0284BD61-8DCF-4EAD-8163-191C56AFD7C8@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Tue, 13 Sep 2016 22:36:26 +0200
Message-ID: <CANQwDweD=+xv4OvTNtMDGMsAePuRfBY2sbh69kqQ3+Tmo5xPbQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git User's Survey 2016
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     David Bainbridge <david.bainbridge@ericsson.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Doug Rathbone <doug@dougrathbone.com>,
        David Bainbridge <david.bainbridge@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Andrew Ardill <andrew.ardill@gmail.com>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 September 2016 at 22:11, Lars Schneider <larsxschneider@gmail.com> wr=
ote:
>> On 13 Sep 2016, at 17:54, Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
>> On 13 September 2016 at 18:15, David Bainbridge
>> <david.bainbridge@ericsson.com> wrote:
>>> Hi Jakub,
>>>
>>> You said:
>>> P.S. At request I can open a separate channel in survey, with
>>> a separate survey URL, so that responses from particular site
>>> or organization could be separated out.
>>>
>>> Please can you open a channel for use by Ericsson?
>>
>> Sent (privately to David).
>
> Could you send me a channel for Autodesk, too?

Here it is:

  https://survs.com/survey/c51qiuw394

Please tell me if you want the channel anonymized in survey results
(after its closing).
--=20
Jakub Nar=C4=99bski
