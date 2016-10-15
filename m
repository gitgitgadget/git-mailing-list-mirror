Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDD7B20988
	for <e@80x24.org>; Sat, 15 Oct 2016 14:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754386AbcJOOra (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 10:47:30 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36367 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753808AbcJOOr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2016 10:47:29 -0400
Received: by mail-pa0-f68.google.com with SMTP id os4so3232096pac.3
        for <git@vger.kernel.org>; Sat, 15 Oct 2016 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pAwoyIG28zx18gmjWfVGDclG0ox1N/cT11Vi3KKuvQY=;
        b=czP8wungVrFAYRu+3CPWNSUZLad8RgL47XENMN0XgweF8mA0hdFqwUrMAvauT6UAbF
         KnJ5qwHn3taCX302vamB/CeLrnWwsbsutl3AnG3FIwvIAtzUNyyLYX27emtRIgaMk18z
         qpj/JfiSjvpwA0Q9REpeUYHak0qI/kan1pff2Ez1iGDOZHriW9D/0p+iamD1ZWPe7+/e
         ekO26OZRv5Os0Qx1LXAsOgVny9b27l27TLKN6dIWwcF4PonH7gxA/xWk0aRev5+0Y5p8
         5JsILZ0KAPZ/69MT4AeM150cRd8owlcFabiTfHQ5/Jlq9mvRFvDaTCB+HZZWrpncnv0p
         +kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pAwoyIG28zx18gmjWfVGDclG0ox1N/cT11Vi3KKuvQY=;
        b=WrNClj06+6GF6qcGVpOs7Q2KfNRVWa6969mTPF7ABTcsTIbz1WAUPG/YLeIAPg8mZV
         x8jKCFV8SFm+KcjLHR/3HfroxLdo0LF97hnhVCT3H2IQpOR2SRDsbdfjMZDyRRGBZ6wT
         6NTParYVfZVbMyHlFVqr+1KxrhJfA1Rd6Vy1dJ9JK3RLwGRZUvnBbOVaixVIaY3FzLuJ
         CmznvbE17yjVc1mNyhF2TJy4Ui7KKc3439xlXXYIBPDOQ1hUMrLCPsjVRzbjdz7MF+m+
         ahdW9Pk+EpL8wp2cwhO02hXHBwhtBXnWCIBafpoS8QtJQcmD9INSS7Z+nzN2P0bIKlT6
         C0iA==
X-Gm-Message-State: AA6/9Rn4rOUG6m4u3YmqyRA7F4v/ZNPWUcALrarNAZMrNtljaoGNuqn6ZBX0k2drLTS1dg==
X-Received: by 10.66.222.169 with SMTP id qn9mr21813481pac.133.1476542848451;
        Sat, 15 Oct 2016 07:47:28 -0700 (PDT)
Received: from mtl3z26wz1.ads.autodesk.com (adsk-nat-ip11.autodesk.com. [132.188.71.11])
        by smtp.gmail.com with ESMTPSA id m188sm35667076pfc.40.2016.10.15.07.47.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Oct 2016 07:47:27 -0700 (PDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v10 14/14] contrib/long-running-filter: add long running filter example
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <3bdfebab-aae9-3263-218e-c8ae394084fc@web.de>
Date:   Sat, 15 Oct 2016 07:47:26 -0700
Cc:     git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
        peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE051B9A-B3F8-4AB7-8028-0105C51BFE2E@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com> <20161008112530.15506-15-larsxschneider@gmail.com> <3bdfebab-aae9-3263-218e-c8ae394084fc@web.de>
To:     =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 08 Oct 2016, at 22:42, Torsten B=F6gershausen <tboegi@web.de> =
wrote:
>=20
> On 08.10.16 13:25, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Add a simple pass-thru filter as example implementation for the Git
>> filter protocol version 2. See Documentation/gitattributes.txt, =
section
>> "Filter Protocol" for more info.
>>=20
>=20
> Nothing wrong with code in contrib.
> I may have missed parts of the discussion, was there a good reason to
> drop the test case completely?
>=20
>> When adding a new feature, make sure that you have new tests to show
>> the feature triggers the new behavior when it should, and to show the
>> feature does not trigger when it shouldn't.  After any code change, =
make
>> sure that the entire test suite passes.
>=20
> Or is there a plan to add them later ?

The test is part of the "main feature patch" 13/14:
=
http://public-inbox.org/git/20161008112530.15506-14-larsxschneider@gmail.c=
om/

Cheers,
Lars=
