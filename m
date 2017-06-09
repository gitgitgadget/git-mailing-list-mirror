Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9E0F1F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 16:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbdFIQ3c (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 12:29:32 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34296 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbdFIQ3a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 12:29:30 -0400
Received: by mail-lf0-f49.google.com with SMTP id v20so31856557lfa.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 09:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wjwURsF1X5Iq/xSJsRy7QspcfPnIJin4qvh/8srF44w=;
        b=VRpxB4+lcS57zLFFyJO8Qcf2ZgNUO9bIb9j/uMjx5FSYLcb54yaZmgXmZZIFIMkrb+
         n6fRTtMPulbE1LN/LTNgAklZnT+eH8uoKJsI73utpq6H3z/5lm8rDqU5aU5kSt4w85Qv
         da8GvE4iOrfGtMeXO7RK+jwWreGBmfT7FFhX9EgRgYBIH3Z9RIctLqbkVYKqSl3n62gW
         w8r53vynjnHV4Tv+0g+M/cv+MsDnhneRstuvOaFY6zcYq/9Lp8ItC8cNr+bcgEc7ulp2
         tRjSxmcUlVjMUrsAyU9yZk+eUTYcbdchXkYaOFrh5gn0xxKSLSOKFTv2Df04JvYjp/rj
         0qxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wjwURsF1X5Iq/xSJsRy7QspcfPnIJin4qvh/8srF44w=;
        b=n3qHmujFkOsA5X5gXYn3C+GBTyBAob/i9e1Wq5gbm/ceDf69JkyAn7tTzcn30LUg+a
         8iCBuu0/6TkYOYKLNoURzxptNjILyywZ4i6pcsHdjC86A2Jw8+7EDYd82Q8A7VtORiqS
         FFxbeNmlNpv3CJgRI+oUpAHwf4T4HtNvVvRrQKdgRczNfz8f3e1zhIzZraiiTqXoUy+s
         fu1qncKgDuq/t2cahU3IGohBsaaxkCsikUihGHyTkLuNdlPWoZvDX6G6VUmt5nnudV4N
         2GBwxSk3gcR0Rr89BRSvAhDvA8pAvPN6X9nJgxLekPOUvKfzjU0ApoWhgKuWevH+4nXQ
         S/1A==
X-Gm-Message-State: AKS2vOwnEsV7By+BC8rURf9SWmltB23ECBLO18jtXQz6QZbIpamnzYVO
        VOd7PXqWvjvbkA==
X-Received: by 10.28.173.206 with SMTP id w197mr397817wme.68.1497025769128;
        Fri, 09 Jun 2017 09:29:29 -0700 (PDT)
Received: from buc98hyl12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id q77sm74712wmd.31.2017.06.09.09.29.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 09:29:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] Configure Git contribution guidelines for github.com
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CACBZZX7O9DgLGOHKhojZRi7n=j3X0W9B_sRGLi6cBpc74GLyeg@mail.gmail.com>
Date:   Fri, 9 Jun 2017 18:29:27 +0200
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Roberto Tyley <roberto.tyley@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F9939C5D-C710-4788-81A0-4D7958971128@gmail.com>
References: <20170609142151.94811-1-larsxschneider@gmail.com> <CACBZZX7O9DgLGOHKhojZRi7n=j3X0W9B_sRGLi6cBpc74GLyeg@mail.gmail.com>
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 09 Jun 2017, at 18:18, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>=20
> On Fri, Jun 9, 2017 at 4:21 PM, Lars Schneider =
<larsxschneider@gmail.com> wrote:
>> Many open source projects use github.com for their contribution =
process.
>> Although we mirror the Git core repository to github.com [1] we do =
not
>> use any other github.com service. This is unknown/unexpected to a
>> number of (potential) contributors and consequently they create Pull
>> Requests against our mirror with their contributions. These Pull
>> Requests become stall [2]. This is frustrating to them as they think =
we
>> ignore them and it is also unsatisfactory for us as we miss potential
>> code improvements and/or new contributors.
>>=20
>> GitHub offers a way to notify Pull Request contributors about the
>> contribution guidelines for a project [3]. Let's make use of this!
>>=20
>> [1] https://github.com/git/git
>> [2] https://github.com/git/git/pulls
>> [3] =
https://help.github.com/articles/creating-a-pull-request-template-for-your=
-repository/
>=20
> It would be good to have some instructions, but instead of warning
> people off we could just point them to submitgit.herokuapp.com
>=20
> You can submit patches to this list using that, and if someone's
> trying to submit a pull request they might be much happier using that.

Agreed! I wasn't sure if this solution is still active/maintained by =
Roberto!

- Lars=
