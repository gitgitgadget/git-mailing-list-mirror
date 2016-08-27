Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C60221F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 16:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754810AbcH0Q2W (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 12:28:22 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35306 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754798AbcH0Q2U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 12:28:20 -0400
Received: by mail-qk0-f181.google.com with SMTP id v123so103842968qkh.2
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 09:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=aRdoBnWkbWYmBLa4Egf1YiSl8fynfUd9iLKxaT9Bo+A=;
        b=i8cL95+y/iWwt7/jfuSNaYVt2mIGT3KE4vTp3FAyO4wBfaMeSdyajDFNgsc0qpMiot
         NxjHxwTjeqDQVh9UaTRE4Qk8O2MfrjD6f4VbbvPcKOrl0AO30YSuLbnJ+n5dSn/RE52t
         wQA553+GmaFVWnvijI46r0b/lgC16lQo1kpXlfRlqJAqfkfbeCybybC0TAEcZB5/d2jC
         g1OPupKiVjQ3hmhChZ0wNtDDD7OMdM6S4NAxNzlcN03uQ1be6Z4FQaG1cPlqRduU4xAw
         /wo8nytK0n7JkxtewFyjr1emHid2BMktf8jYwruxYYE9DTGv6RXGeR3bpcr9e8uJDOhY
         /K/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=aRdoBnWkbWYmBLa4Egf1YiSl8fynfUd9iLKxaT9Bo+A=;
        b=Y78FlGL+ayIepTnbWHfmDlUp65yfLEzw42eGF3ThOx/BtmRHQMC3n1hTEtfdmHkgGJ
         +4oAmqkz5mK7bKeUvVktmMTaBerj9/MZKXFGoj3Cajchd/NaTB+1O4bwQHUKNoy0nT88
         qQfNpEh801v0cofRaxs/M1AUu78zdLq2u0NVQLYLunDTTSfCPA7sQFPYQ9UHCDec0OP2
         T+BbIBx8Sl4S2UeNPatpPe+ks7Dt0VtyY3QRvVYbDzaB2HQRFaIGw5Dop5kHu/T9ylfJ
         c7ONyJbEFiCmP+58klk5csq1qw3kZ2g3s/AhUD4OFMlkgKWntgbPYGtFcuzLD4+Cnb2/
         Ck8g==
X-Gm-Message-State: AE9vXwNOJZ3CPV+PtDuSZgwpLMZcp4bQRvfHGdhAlU17mhGb4hjVY77uJFFEUw/yyjF75hm7N8lk4FTbCtLwXQ==
X-Received: by 10.55.44.134 with SMTP id s128mr9355219qkh.177.1472313773394;
 Sat, 27 Aug 2016 09:02:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.233.232.19 with HTTP; Sat, 27 Aug 2016 09:02:52 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 28 Aug 2016 00:02:52 +0800
Message-ID: <CANYiYbF0SOgyyNRdAgS4teBWcWuEgXXT5G9La4kZNBTGHzEwEA@mail.gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.10.0 round 2
To:     Alexander Shopov <ash@kambanaria.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Marco Sousa <marcomsousa@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.10.0-rc2 has been released, and let's start new round of git l10n.
This time there are 12 updated messages need lto be translated since last
update:

    l10n: git.pot: v2.10.0 round 2 (12 new, 44 removed)

    Generate po/git.pot from v2.10.0-rc2 for git v2.10.0 l10n round 2.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
