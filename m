Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2149208CD
	for <e@80x24.org>; Thu, 31 Aug 2017 14:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbdHaOTS (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 10:19:18 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33548 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdHaOTR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 10:19:17 -0400
Received: by mail-wm0-f44.google.com with SMTP id r202so8872398wmd.0
        for <git@vger.kernel.org>; Thu, 31 Aug 2017 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=699q2KtLDpGCweoWa1VYXRcIAFmlzbTTodrQ8ddr2/U=;
        b=ITptpJRU/woZ58rMYFBEJyBHIy8/SAOOyHIIF4zz18wFcug105lDwqNjGdHagfIkY0
         aGBX2r10EAvR4K53qMIQd5by5OggYybi+/ryX8Ko5PvvwJfRZwZw0EGToWY/ppEmFzjB
         dLSCyiN4ZTGK3FstUmjoCp/JiI+eSLC4yjmKRuzQjlpHPYyY1LwW+9s3sYpSUazqKoUO
         +Vj2qw0KTIQem7QWyZDtG6gVGliUjLKrLTc5LtaWJMn2E/CDxo3mLIW7H56sjoOkcd1V
         KS+Z7Jnx00bXLDMVmhMLkNRew31zfFws7ClEVo6J10ydztax+5CHoS47UQ8ENuFtKBlc
         LQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=699q2KtLDpGCweoWa1VYXRcIAFmlzbTTodrQ8ddr2/U=;
        b=tOoEoLOcUeZk6wo8rp2ohf9z59gphHuyGKyj8rPINuegIXJ9j/uHaTI/uYD+ZpP+Mb
         Xc5J2cptkinoBYhnKpwauzxOwVeiA/LLxeG7c7emCpxkrRxyd8ecAv0FQapHG9r6NXAT
         sNpTzCM98InAthok1On0Gi68fP1H+cBCLYaN+hySohB0OpxSrYXJMUJiewDLdPdGGA9C
         dBgVMVqqFJaXNNzhw70HRoI0jdlRgm5gy5A3puBSSY2fL+TkdbKCbpRTIRJeqdSwkI97
         jBGgITQf5ZwyQa9wm00kyNu23zUv3ZISOL3d37JSfe6EoDAbJbHHpvvMUIfKo9PpIxhH
         3nhA==
X-Gm-Message-State: AHYfb5i8C3vQ4+siRphmV+kEvfh1x+ucRc4BU+LeAUc8EUU6wVoqJhv5
        pjBrGYK1AAFW7u8bWHd85Y53xeqadQ==
X-Google-Smtp-Source: ADKCNb5c82wgL2RSFwePhkeSuyyI9avW9s7On+Th3HA79zsUEpD0cQL6Z6UsGoe+CZVbUqQE2Si1g+YkD6lODhOGD6E=
X-Received: by 10.80.151.152 with SMTP id e24mr1601420edb.266.1504189156684;
 Thu, 31 Aug 2017 07:19:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.137.42 with HTTP; Thu, 31 Aug 2017 07:19:16 -0700 (PDT)
In-Reply-To: <20170831063614.GI3839@alpha.vpn.ikke.info>
References: <db0580dc-3ce0-47ba-b82a-b1e50b9d0a3a@nsinfo.co.rs> <20170831063614.GI3839@alpha.vpn.ikke.info>
From:   Dov Grobgeld <dov.grobgeld@gmail.com>
Date:   Thu, 31 Aug 2017 17:19:16 +0300
Message-ID: <CA++fsGHFwoLvwO121aDEgi1dZbwwfogdWbxxRx+ci7T1RDCAnw@mail.gmail.com>
Subject: Re: Bug report
To:     Kevin Daudt <me@ikke.info>
Cc:     Aleksandar Pavic <pavic.aleksandar@nsinfo.co.rs>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following answer that I got back in 2015 from Jeff King might be
relevant to your problem:

https://marc.info/?l=3Dgit&m=3D144178948506788&w=3D2

Regards,
Dov

On Thu, Aug 31, 2017 at 9:36 AM, Kevin Daudt <me@ikke.info> wrote:
> On Wed, Aug 30, 2017 at 11:25:00PM +0200, Aleksandar Pavic wrote:
>>  I have a file
>>
>>  app/Controller/CustomerCardVerificationController.php
>>
>> And when I take a look at changes log, I get this (no matter which tool =
I
>> use):
>>
>> 2017-07-31 19:41 dule             o membership renew payment email
>> 2017-06-07 08:59 Dusan Tatic      o cc refund clean
>> 2017-04-15 00:16 Miodrag Dragi=C4=87   o refound admin payment
>> 2017-03-20 12:02 Dusan Tatic      o CardVerification card connect
>> 2017-03-16 15:59 Aleksandar Pavic o paypal
>> 2017-03-10 13:34 Aleksandar Pavic o Production branch
>> 2017-03-10 13:01 Aleksandar Pavic I Migrating dev
>>
>> However if I manually browse thru revisions and open revision from
>> 03/27/2017 07:05 PM
>>
>> I can see the change in that file which is unlisted above, at revision
>> ff9f4946e109bd234d438e4db1d319b1f6cb6580
>>
>> And I'm at master branch all the time...
>>
>> We wouldn't have noticed that if it weren't one important feature...
>>
>
> What does git branch --contains ff9f4946e109bd234d438e4db1d319b1f6cb6580
> return?
>
> Where did you find this commit?
