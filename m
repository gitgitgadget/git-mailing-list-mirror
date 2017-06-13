Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FD4C20282
	for <e@80x24.org>; Tue, 13 Jun 2017 07:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbdFMHvo (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 03:51:44 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:34750 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbdFMHvn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 03:51:43 -0400
Received: by mail-wr0-f179.google.com with SMTP id g76so125886191wrd.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 00:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gVSdNiM1Jw5UTCATAoV3HymJzF4t/8Yk8/V9pnZT/es=;
        b=HIqf6DoC05t2LFBn7wm9qZj9smNxKk+NBwvNH5nDdx3JjMU2+b7PgiLommYn54tK/2
         HXCr6IGc0I71sCtxRGOtTHSXAvsdG4RgzyzLeLus3a54VbeSgY5torcManaLCt79Wu72
         7cQoAQCMqtdRX+mm5VD4gRnoW8gxhoynb6BeNDYKJt5rojXiCwvo/fgM8cBdE/sJe6jb
         3bOj8KLe9we4qhwRDDZuoC+boBuMY++r7D511Z9+w5Icb3WXqnapIkTtEY2eujut5Xke
         LlxgTaXhiYyNjwZyZ5d2F4i5MKgVoP/lmZHjUPJoTi7HVYOQivnbjjF/dDVVrZEY9n/y
         bpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gVSdNiM1Jw5UTCATAoV3HymJzF4t/8Yk8/V9pnZT/es=;
        b=ftPC2ApR5gdMpLYm33Q0dKxaD0RlKKIIr/javYfBZApNAuuWn0CUTb+uN8XdX479ys
         YXRV+pnpsmLOi47weetHkm8QY4F6glWM2xd8wcPwtBa1+oWLyy2u4N7Ea+hrFDGvVR+Q
         oaYJKNVWn/uObuHWECni5yu98beMJqO1T3/A6LtcpGbSBGUm3jfVAYefJCwfhnI6Vk5F
         f+rIrvY/0T0SFZmjNt61gca+NqAgRJzX2jc1fkIkkE/NyGjDb+BfNIaN3veBBk1bsP0O
         p5oB5jyBzC42XE+AuU4GiF3scC0Ubdx7we6bXlPqrU6+91BufChHv0OZr/J0YaMok2SH
         X4NQ==
X-Gm-Message-State: AKS2vOxHA5BhHE6dnkbsV4MyJBtUSyLA+qBJgh4PnMF8aec3xfr6Qipl
        rpFq1pGObifsxUP7GGs=
X-Received: by 10.28.127.10 with SMTP id a10mr1692804wmd.36.1497340300521;
        Tue, 13 Jun 2017 00:51:40 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4C1A.dip0.t-ipconnect.de. [93.219.76.26])
        by smtp.gmail.com with ESMTPSA id h123sm13852610wmd.34.2017.06.13.00.51.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 00:51:39 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] Configure Git contribution guidelines for github.com
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170610073521.ewjzvtpha3xgoe6z@sigill.intra.peff.net>
Date:   Tue, 13 Jun 2017 09:51:39 +0200
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <DCA2782B-3439-4586-8105-170E47FA56C9@gmail.com>
References: <20170609142151.94811-1-larsxschneider@gmail.com> <20170609170357.GE21733@aiede.mtv.corp.google.com> <20170610073521.ewjzvtpha3xgoe6z@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 10 Jun 2017, at 09:35, Jeff King <peff@peff.net> wrote:
>=20
> On Fri, Jun 09, 2017 at 10:03:57AM -0700, Jonathan Nieder wrote:
>=20
>> Would putting a PULL_REQUEST_TEMPLATE and CONTRIBUTING in the
>> top-level directory work?  If I'm reading
>> =
https://help.github.com/articles/setting-guidelines-for-repository-contrib=
utors/#adding-a-contributing-file
>> correctly then it seems to say the ".github/" prefix is optional.
>=20
> Yes, that should work. The ".github" option is there if you don't want
> the cruft at your top-level. I don't mind CONTRIBUTING, but
> PULL_REQUEST_TEMPLATE is kind of gross. :)

I think so, too :)


>> I also find the long source lines hard to read.  Can you say more
>> about how broken lines render in the github.com web interface?  I
>> would have expected github's markdown renderer to behave like others
>> and cope with line wrapping.
>=20
> GitHub-Flavored Markdown treats newlines as a line break in the =
rendered
> output, unlike the original Markdown implementation. I don't like that
> myself, but it was done in the early days after seeing how many people
> accidentally butchered their formatting because they expected the =
output
> to look more like what they typed.

That's what I had in my memory based on past experience, too. However,=20=

out of curiosity I just tried it and it looks like they have changed it.
I'll reformat with 80 chars.

- Lars=
