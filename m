Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3001E1F461
	for <e@80x24.org>; Fri, 23 Aug 2019 09:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbfHWJfo (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 05:35:44 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:41143 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730861AbfHWJfn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 05:35:43 -0400
Received: by mail-oi1-f173.google.com with SMTP id g7so6551333oia.8
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x1yh6TEEGFjbEp7YgKpZOOaw+JqaZ9Xcy/FeAKV7v+Y=;
        b=sjBsHf9O3QT9p9CfgPkTdtS0MRwKMTngX2sgMG2BY3IFtpeqn1wOUu3zj/RWuDlNzd
         BAWF4wKpFXSBSuWby27xO6H3XLMCanqrT3MQuck7NvyPn6u+MbVW1DggxbEZczyKbi1D
         Jq77Bc7M3Suv16owKwB8G0pj1S9FfLISlYX85thwiXO+aF1KAZ28whT7hyJUgXNmZT02
         BMlMJD2/I6T0x8DKjcsxa0lHtr9MYUOC8uPYOrBkZ+5/v/qfM88Cdo7y4G9NdCFsU+jG
         G++V7tJ6RFqPTP1gma+WtcW/Uiqxz3dPwTpCRHtdebTddW5uFxg9wANGh3Z6cCjl1tX7
         MPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x1yh6TEEGFjbEp7YgKpZOOaw+JqaZ9Xcy/FeAKV7v+Y=;
        b=gfv/iJebNsxmjucELAc0WrMXoiH539c5kXTupa3mRlCIBTqA4ZMyBcJa4drWkeOc81
         FqgEyLelABhcSdu67RZwipDEHLkdxpnCoLiRWqZ0vAPAVrEOlmnzJUmP1Y0/E3YlsK3q
         Ddf41X+FYpyp6tDudxeMRSlVmWzJ3d41M/R+Kpulkh4RVw4GKc3YpCjb2WTLkzV6s4GL
         v8gG4OkOLGHP8GBdzQYjbvoKPkxVLdkU/l/G2ddPk8BaRNJju/lKqzI9llyrYRHRMkq8
         WuDoA05bYXRJfd1XsXVNjtUrLjWHwBFn6+pJFodivx0GNCy78LrhOHzpaWf3kN/KhVFk
         e3Zw==
X-Gm-Message-State: APjAAAVyLj4UcsrzIM7IACxZZQbhfQe2KYTmBSaUnQzAxrC1wlUpl2a0
        4ZJQ0KfI/+X7kKu1YA3hO3CVxUDvkzoX5nRTzAg=
X-Google-Smtp-Source: APXvYqz8pUARZrBIgCxzTWOOevqlUuaME57JGpBUBMZdgmTfUskesPcA853VVFh5F2A1S4CMobk5xTHyZeF6D1a/FC4=
X-Received: by 2002:aca:6044:: with SMTP id u65mr2563343oib.16.1566552942723;
 Fri, 23 Aug 2019 02:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
 <CAGyf7-EdxDn_BwguXNUNg76K9z30X0=C1btMR0dfiHR9bLjhwQ@mail.gmail.com>
 <20190822170817.GB35435@google.com> <20190822184312.xhrf2ij3bh3vovrq@localhost.localdomain>
 <20190823082900.GG20404@szeder.dev>
In-Reply-To: <20190823082900.GG20404@szeder.dev>
From:   =?UTF-8?Q?Giuseppe_Crin=C3=B2?= <giuscri@gmail.com>
Date:   Fri, 23 Aug 2019 11:35:48 +0200
Message-ID: <CAGV3M54LVwHMkXd=wB3tQ_h4K0bJOZ43TxXZ8Fh5ZKfATBS57g@mail.gmail.com>
Subject: Re: [BUG] You can't have single quote in your username
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 23, 2019 at 10:29 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> If we go down this route, then someone might want to write =C5=91 as o" o=
r
> =C5=B1 as u", which still supposed to be used in pairs, but what if someo=
ne
> wants to write =C3=A4 as a:, =C3=B6 as o:, =C3=BC as u:, =C3=A7 as "c,", =
=C5=9F as "s,", etc.

I don't know any language that uses =C5=91 or =C5=B1 so I can't tell but it=
's
definitely possible. In my country, sometimes the last name ends with
an accented letter (mine ends with an "o grave") and people end up use
a single quote to avoid pissing off computers. That's standard thing.

In my current team I don't know enough of the setup of my colleagues
(they may use CP1252) and that =C3=B2 may be badly decoded.
