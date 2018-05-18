Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9D4C1F51C
	for <e@80x24.org>; Fri, 18 May 2018 18:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbeERSLN (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 14:11:13 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:33027 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeERSLM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 14:11:12 -0400
Received: by mail-io0-f182.google.com with SMTP id e78-v6so7219122iod.0
        for <git@vger.kernel.org>; Fri, 18 May 2018 11:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anmol.io; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tz85R6OLHRCQKnDe/eCQ2UI1DLV3rCEdkBbjsIikq+c=;
        b=I5xjUr7K0UDerJsH0FMW/M7gjSWc99LYTYo+jLf0izOK7qmFgZ0N9xTCB9DU9ebB9E
         +vmUvIo/V1NyX0xEKN1gNKKeHolqqGGBevS9GibxYRYgQaUk8fzARXjX8Eow0jfnSKEP
         uQykUjqGsz4QTjOza0y3Ysweg+kQknCsCuPy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tz85R6OLHRCQKnDe/eCQ2UI1DLV3rCEdkBbjsIikq+c=;
        b=cS2EkAwLkMAedp8A2nseyPc8w1CwceanhQgYgn952i37LiQyN1vjeCq6QWx4IyzJoC
         jno6AUdJs1I3FGQl3aiUfaH0F/6e/tbAA3pOQV3PRrcdTDxxDhAY0KQM8E6zF0J3jFkw
         Vj85vsOo3rn54aslhHwEeHQAbN0/1X1BxRwNtDdFPsbZN5RkPfdZHwDf4o66PCP7aRMq
         2rcCvDE099CyE2j2YLB9vh7FXfwylgQj90BAByooBRIP8tb9gpEa/tNdEPTRTWDe/SUD
         M2QoNH3/reRK0fw4VtEaVK/8zCma91oWvZ6uhgiQV6G7ERgtyiQ9g0L8MVItJ6zYJWke
         w7Uw==
X-Gm-Message-State: ALKqPwfrHYegZIan1C3DzNM1KjnfCXhLNAEwsKGy7DPpJ/+Fp838Na9M
        HJeEeWCwInZjimt3xov+Uba858Jz65w=
X-Google-Smtp-Source: AB8JxZqrJIlVvymivqIj5AR3waiiU2Bp+SAqTYczmQpC0zm6sH7rQdgPZ2SHu4C+uAsFbm7ZC+4bQw==
X-Received: by 2002:a6b:7302:: with SMTP id e2-v6mr12282399ioh.64.1526667072194;
        Fri, 18 May 2018 11:11:12 -0700 (PDT)
Received: from ?IPv6:2607:fea8:4da0:8ef:7088:aff6:8a95:3ce6? ([2607:fea8:4da0:8ef:7088:aff6:8a95:3ce6])
        by smtp.gmail.com with ESMTPSA id v127-v6sm1130626itc.3.2018.05.18.11.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 11:11:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: Add option to git to ignore binary files unless force added
From:   Anmol Sethi <me@anmol.io>
In-Reply-To: <CA+P7+xpdKPsWuiurD_VEF1dtV44Omfx+Mq2SN1Y1-W1vWAzX_Q@mail.gmail.com>
Date:   Fri, 18 May 2018 14:11:10 -0400
Cc:     Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B1CF9F53-D414-45E8-AA62-FE9DDD901234@anmol.io>
References: <285692D0-1DE8-4CAF-9BCE-F1A04D5C66B5@anmol.io>
 <CA+P7+xqQZzTrm274rbbP_O85Y+YGZ4PQ8PMFJnJtKR4wR0AObQ@mail.gmail.com>
 <30BAE567-25B9-4D5E-B86B-45A578DDC57A@anmol.io>
 <CA+P7+xpdKPsWuiurD_VEF1dtV44Omfx+Mq2SN1Y1-W1vWAzX_Q@mail.gmail.com>
To:     Jacob Keller <jacob.keller@gmail.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

How about a hook to ignore certain files? Then you could ignore based on =
the contents of the fail instead of just the extension. It=E2=80=99d be =
very flexible.

> On May 18, 2018, at 2:09 PM, Jacob Keller <jacob.keller@gmail.com> =
wrote:
>=20
> On Fri, May 18, 2018 at 4:31 AM, Anmol Sethi <me@anmol.io> wrote:
>> This definitely works but it would be more clean to just have git =
ignore the binary files from the get go.
>>=20
>=20
> Sure it'd be more convenient for you. But there are loads of possible
> combinations, and the idea of what constitutes unwanted files is
> hugely variable to each user. We don't really want to end up
> supporting a million different ways to do this, and the hooks
> interface provides a reasonable method for rejecting commits with
> unwanted contents.
>=20
>=20
> Thanks,
> Jake

--=20
Best,
Anmol

