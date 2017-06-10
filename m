Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 740901F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 01:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbdFJBvS (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 21:51:18 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33021 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdFJBvR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 21:51:17 -0400
Received: by mail-pf0-f193.google.com with SMTP id w12so171003pfk.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 18:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5zFv3WVYCyia2heZ0RGt7/mPVZkspaO6H1Cne3EnvW0=;
        b=sfxsnHniWt9MAGvXshS1JamJnb6X6cT5Y2jKe6vAa6lZ8/z1dpiScdU6J8TWhXDhPc
         JfGkj7HmALrGMIcPPHPLzuoeKAxrf1Ugha1OSd3Pqvs43YGgMmH8DtS7SHjtuR+1d7Nt
         2RJJ7pN9/CUNeFpyL7N1Xcj1oM+SvIfvw7zaiQQV/s5GLnvPG2BBo5FlWCNdZXh9dGno
         NaLmsPBeGmEDiJMFe9z1HlpnaBa7f/bqAF6truGlnSmpvi9xVxXaUlY+AOY9EL/teGj7
         e4Qo19tkVFfjTApkGYKNDewtIHYU7pnkvejyaNPW3T1k++ziYuecM5EVUom2NDP4KqbT
         HxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5zFv3WVYCyia2heZ0RGt7/mPVZkspaO6H1Cne3EnvW0=;
        b=KcU++hgRhlTfIUzolm8crSYI6V1j2PLm6j1QP0gn2QLA8jHz52HMjwvqnzBPEvM/oi
         7ZmZEuYiTCfPDZjiyD75Gty/WtA+AL+c2FdMXYui6Tl2o97if5payi2mZpEViwXLqzKd
         Epgm0pDkxRkS7ITL8rvWmWOxTSqBY7t8ty32sQBSVuEwomFnMxMjNQqa2yy+/9cIvgdE
         4l1IJTbpaHw3wPrGH7fwk5fbbk3MWXZWj+sxr0wuIFBmj0p33PqmADZ6mQVS7Ly6gFDt
         pH8f9Im1EKn02K3B2MhpUPxjd2neoINNiRU2mZxCdsUBu0QyY1J7H3UxXOm+FA1VGgt+
         lQ4w==
X-Gm-Message-State: AODbwcCaKmpozatPIHh0yoXcPsK7SUtIzsgyl0swg9CA/2ALkNb+RHD7
        +1LAEl7yQpKN6g==
X-Received: by 10.84.233.198 with SMTP id m6mr43283744pln.292.1497059476712;
        Fri, 09 Jun 2017 18:51:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id n71sm5146175pfg.46.2017.06.09.18.51.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 18:51:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH v1] Configure Git contribution guidelines for github.com
References: <20170609142151.94811-1-larsxschneider@gmail.com>
        <20170609170357.GE21733@aiede.mtv.corp.google.com>
Date:   Sat, 10 Jun 2017 10:51:15 +0900
In-Reply-To: <20170609170357.GE21733@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Fri, 9 Jun 2017 10:03:57 -0700")
Message-ID: <xmqqtw3o4nl8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Lars Schneider wrote:
>
>> Many open source projects use github.com for their contribution process.
>> Although we mirror the Git core repository to github.com [1] we do not
>> use any other github.com service. This is unknown/unexpected to a
>> number of (potential) contributors and consequently they create Pull
>> Requests against our mirror with their contributions. These Pull
>> Requests become stall [2]. This is frustrating to them as they think we
>> ignore them and it is also unsatisfactory for us as we miss potential
>> code improvements and/or new contributors.
>
> I think this description could be more focused.  It's also not
> self-contained --- e.g. the link to stalled pull requests is likely to
> become stale over time, especially if GitHub gives us a way to disable
> pull requests for the repository some day.
>
> Could you summarize for me the motivation behind this patch?  Is it to
> make Git more approachable, to avoid frustrating contributors, etc?

I wonder if s/stall/stale/ is what Lars meant.  I think it is fair
to say that new contributors who are used to GitHub pull request
would find workflow with the mailing list unfamiliar, and from that
point of view, this is a step in a good direction.  Back when I
added GitHub as one of the publishing repositories, the best way to
convey this message available to us was to have a short comment on
the repository telling the readers not to throw a pull-request at
us.  If there are other mechanisms to do so more effectively, we
should use it.
