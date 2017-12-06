Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E71020C11
	for <e@80x24.org>; Wed,  6 Dec 2017 15:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbdLFPOs (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 10:14:48 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:43125 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751709AbdLFPOo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 10:14:44 -0500
Received: by mail-wr0-f177.google.com with SMTP id z34so4252264wrz.10
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 07:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zXxpmGOwNJRbZ7uO8c2J2Vmm3SZJRh10WfIUPo1D/Aw=;
        b=bMte9N5QMjieRPsJj0NVda+h2nMsNj8ONI5nh6dGi8+usXbmhepv4LQNVgCAGuYVVM
         gGxnr+QFubGRFalFX+6LXqyts+8lh1/IOhaMkbZkoeHrmbArMY1O4L6OGMd995WVozNH
         4bnWO6fxxQI/QLYjAaKBAX1AX01ETh2NHQViMrtf8l17BTOsalbJuUSVUVktVHU9ZMsB
         OhUhehCe5K+aHHuTzr0JRccT2/okRRBZLWFnszRkDF+BNal+1P7YbpdFJaIk2rLoonmo
         jnZLvSKP9ktXzy1C7w1R1cMy84lTrs3W46fnrHTRlmY7oIz0OpyjSBRHjDJebV0UyKPR
         I2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zXxpmGOwNJRbZ7uO8c2J2Vmm3SZJRh10WfIUPo1D/Aw=;
        b=kQELgIcIuzSF4po6ZqsUrSZ+YI7i5tOYU6RcfRQtXu4mwCAw9mW91M4eSUANOPN6oj
         dZrF5j7NrskljUvakMOfpj+/5Gt/5uUNvCgjCXBYQIr8t4yNyl9gFrFetRhUPBoOWbnd
         m3Qma6kNwy0JEQiXG/+c3h7VKZ7Z9fLrLbvcBdqVoetqSscsyruUgQXwJFdMw+XkHZZw
         4F87qapaKmXiJGF8/x58wDqUZ4VyYusV472Pd9Kcui1ytSUEnh0c4r888TVXAh3pPdJW
         9j6K2RBDuDOrerP5UWsplkMFBfaPf0eyGRLO1OfBxpd1h9C5pJErhRR9+7D/u1rV3EJU
         1NdA==
X-Gm-Message-State: AJaThX7s33Cl+fu0J/W7pb1d/cJx0zykDkT0AcNGfI95i4O42tI9X82o
        nMKmSUDBEbjUVVtOLF2IN1Y=
X-Google-Smtp-Source: AGs4zMYXV/PRqOD0m67I2rT340LnCt4dGFyfIO15JkA19l0EUWaF73jYGMwld4AT7SBJondmO6buSg==
X-Received: by 10.223.193.135 with SMTP id x7mr21057229wre.211.1512573283046;
        Wed, 06 Dec 2017 07:14:43 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id v195sm3129377wmf.25.2017.12.06.07.14.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Dec 2017 07:14:42 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Dec 2017, #01; Mon, 4)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 6 Dec 2017 16:14:41 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <DA960DCE-0635-47CF-B3C4-8133021799F1@gmail.com>
References: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Dec 2017, at 22:46, Junio C Hamano <gitster@pobox.com> wrote:
> 
> 
> * tb/check-crlf-for-safe-crlf (2017-11-27) 1 commit
> - convert: tighten the safe autocrlf handling
> 
> The "safe crlf" check incorrectly triggered for contents that does
> not use CRLF as line endings, which has been corrected.
> 
> Will merge to 'next'.
> 

Looks like t0027-auto-crlf.sh is failing on Windows:
https://travis-ci.org/git/git/jobs/312135514

Could that patch be related?

- Lars
