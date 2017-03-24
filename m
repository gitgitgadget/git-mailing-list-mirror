Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C11A91FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 16:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936490AbdCXQ5F (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 12:57:05 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35109 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936409AbdCXQ5E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 12:57:04 -0400
Received: by mail-wm0-f48.google.com with SMTP id u132so17840432wmg.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=I9lghz4nt7po1HTZZfHaF0ixEF6zPFNW2FS0+XYrF5k=;
        b=cS3bxoE8tqRXvPo+mF11EW4JbEFUwUgQ2RQXyy+u0CsdEMjATd8HZRv57FSC5ZAflj
         hmebN78F1Mf/APOGWRsiDsypLcorZq2TnjL1joJ4TdXifwN9aMS6cIlGdKa/o8/WjrJl
         tLu47awCjE1sp3c4rwF8jWh3Q1Zbr0bv6hMpvrXtRXSG7Y/0QVa0dJh2MTE0r8/Jf7YW
         kgnH5dRX4PSUX1YboXaxl8jvrlCmW1qXgvzM6FpEWnL+lkvcK/ZwTRMEDzClqGl8rCzu
         RLG3TqIb+s2T2oMtZGIK5QueK4+puDgOSMNP/aBLnPctzZ181Ydvj0yZ6Xmj9bzrU9L4
         Ly4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=I9lghz4nt7po1HTZZfHaF0ixEF6zPFNW2FS0+XYrF5k=;
        b=n9XogRCAe1QO9Ai9auO3HmK15flqqm+LhoJJmUByZ/8xJ2CaHjwz+V0kRrqmhS+myO
         uH6TBdUFSiglfoa4BM3iVvaZcz7t1LOQg2FAs5saDavPiF8OmWxKpXYooiq65C0ZSC+V
         IE8PZIk8nuDk7JTubVMeh/viVTIE/DNRu8vCWpA4Ee+5Hyn973JTcLvKMiP+WNHRJUIV
         5KV+bR0/PRz/oyU+bGEaodP11yBjVNE0quhKlWfM+WYjJjPDfYMsDXSi4nWHh9/dfzD8
         sx8+QVpnC9+MqpJQcqwz4Nwmktprvz7gIXHYG+a6ghDVP4wpBrM9oEQc1dVvIlvkBDY3
         UFjQ==
X-Gm-Message-State: AFeK/H0rGNw7tRv40k/7BUN+T8iuggZJYToAE58Bkj0OQIofwJmpAE96H9WqhbCzGIt8NA==
X-Received: by 10.28.180.135 with SMTP id d129mr3959922wmf.135.1490374622204;
        Fri, 24 Mar 2017 09:57:02 -0700 (PDT)
Received: from ban4wcb152r.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id s83sm349088wms.30.2017.03.24.09.57.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 09:57:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [GSoC] Git CI Improvements 5 microproject
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <B7AD8170-0742-4B22-9C6B-EC2A5DA12929@gmail.com>
Date:   Fri, 24 Mar 2017 17:57:00 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7CFDD2AA-EEF6-4AF1-A9D8-4C4BAF173746@gmail.com>
References: <B7AD8170-0742-4B22-9C6B-EC2A5DA12929@gmail.com>
To:     Nikita Kunevich <nik.kunevich@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 24 Mar 2017, at 14:58, Nikita Kunevich <nik.kunevich@gmail.com> =
wrote:
>=20
> Hello, git team. My name is Nikita Kunevich. I=E2=80=99m student of =
Belarusian State University of Informatics and Radioelectronics. I=E2=80=99=
d like to particapate in Google Summer of Code 2017 under git =
organization.
> I=E2=80=99m working on =E2=80=9CGit CI Improvements 5=E2=80=9D =
microproject which is creating web page for analyzing most frequently =
failing test using data from Travis CI.
> I=E2=80=99ll write my full application as soon as I finish =
microproject.=20
>=20

Hi Nikita,

I quickly hacked this: https://larsxschneider.github.io/git-ci-stats/
Maybe it is useful to you as a starting point?!

Cheers,
Lars=
