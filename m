Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 768091F404
	for <e@80x24.org>; Tue, 13 Mar 2018 17:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbeCMRxB (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 13:53:01 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:43589 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbeCMRxA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 13:53:00 -0400
Received: by mail-io0-f172.google.com with SMTP id l12so1102463ioc.10
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6RaNnHiAIjMeU/UL1ZzS1dVLjiSOg4Q4HqddNcfqG8c=;
        b=foIu80e8thzbIyJ5CiN5CYYo2x+pWj667x7OkinI1vRqnE5pQr9DBx42ryD1pAdiCm
         YUWrEU+UXh6UZc4QMlQgKOEEZIvbeps/Op9XtKlwbwNWHtxpwtxs+E6HRC+Mcf1S724s
         oo7SlVuHS4I5ioOci8cAv0LcLwCfoMRrphdFBEkR/QzN6XqfjPZBlefaFcpftl+5vUMS
         WPuzmSI9uLnrgzmTb9wu+5RNy/wGUWX8GgwrKQTQBbpiDkcy6/IpW+y9B9prEagNP0Le
         Oa2DduPGnP7xQWkGssGtk+pYfEuP7ysuNRdFm4/Ab1dityehQ1AOmrsB196aqytsOf1N
         iFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6RaNnHiAIjMeU/UL1ZzS1dVLjiSOg4Q4HqddNcfqG8c=;
        b=oEBVWFQPwIRA3EePhjmVMzCeS12bEi9Azd1QT/i4lwhDGXPlHQ9QlJrjjshrpHNE88
         u2mDR9NpzXTo9S//oqa2MiNUMIZ8ff+y4x3X0C2tz1uVYXztY8wJlPWyhMPVQSs5o6fl
         GfKABnkma1c/Dm1tKvf4zoecKiB3vO14JepunFm/0wZcp1wHWS1OC4A1tx/G4T0otDzD
         kRPkFpiP+/iHFRtkrHR7krbRKEXOSEr7Se/+ed2dxS9Bm6yF/qrKsGoenL13t79AHlgd
         vR6ZkFjzxW7SVfpKGNIKO1LNB8PrdUu0ucJmzeNebrZVf8oPfNmFD3Ht5J1+UuOU8nNG
         7aWw==
X-Gm-Message-State: AElRT7HiU7WtJt1JGEL7t4D9edV2Nc7dotovIXFX5M05xgaDHzaJ/alf
        hdCuAROMbNqdLErQwsmgt08GxPP6fwgldNph9g6NpEMI
X-Google-Smtp-Source: AG47ELvS/EX9MbV3utrfug6rm9Oxj0HCGel9a39y1Y9Pt0g24F/eu3h/PtwPB+vki4RMgnz8y4ULW3g/nsn0JhhRNVo=
X-Received: by 10.107.107.21 with SMTP id g21mr1735726ioc.208.1520963580080;
 Tue, 13 Mar 2018 10:53:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.63.6 with HTTP; Tue, 13 Mar 2018 10:52:59 -0700 (PDT)
In-Reply-To: <CAMOtk6Df_7Jb9bX=8PfB9e4-5rRi8QSmXEK7=DmZui6LNBMSLQ@mail.gmail.com>
References: <20180305200400.3769-1-sidm1999@gmail.com> <89AEA176-2D3F-4271-958E-1C6BCC944842@gmail.com>
 <CAMOtk6Df_7Jb9bX=8PfB9e4-5rRi8QSmXEK7=DmZui6LNBMSLQ@mail.gmail.com>
From:   Siddhartha Mishra <sidm1999@gmail.com>
Date:   Tue, 13 Mar 2018 23:22:59 +0530
Message-ID: <CAMOtk6AYFi7XeqqhUT4wjoUZsfy8ZouJYwqWE7h3_zCtgXzaHQ@mail.gmail.com>
Subject: Re: [GSoC] [PATCH] travis-ci: added clang static analysis
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm extremely sorry, I forgot to attach my travis-ci job build with my
previous message. Here it is :
https://travis-ci.org/SiddharthaMishra/git/jobs/349478746#L1204.

I also apologize for not trimming the email properly in the previous message.

Sorry for the inconvenience,
Siddhartha
