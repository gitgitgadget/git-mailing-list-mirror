Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7DF22070F
	for <e@80x24.org>; Thu, 15 Sep 2016 19:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753910AbcIOTgH (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 15:36:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35254 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751627AbcIOTgG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 15:36:06 -0400
Received: by mail-wm0-f67.google.com with SMTP id 133so196650wmq.2
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 12:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W9IZ1pgavxfieS+jTaJhPYyNK+WmqWwd2kinj6NNVHQ=;
        b=wVqDM5XpmYcIzilKbilmEzbJLvXl7hnrLSRb1fchGYVsh5aWSba/i2J179fpdZEm8o
         idOfaeIIapyoYlAWavVQ7xLyaHTt9kmnSSeD+s177KB6IUgq4mbPhmc/Q9OMlJxBPrbx
         bw0/zyrzsIPupIDxzyB8VNzEHOWSedIfostIzfPYxTTDBXXjpIQP1rpkuvLIyQ30bbU0
         c22blnzHi5mcKDkr95N4R570+KJ1UAeDGub1SZkifJUaFB/Q+4tItkN8ou9Pmi6cMp+V
         GKNwMscgnTPO4X2AEFAfNB4cqfYDPyb078bQHyzZoCiGDPl/qWgL0bAPOlt2PQodXJPS
         hQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W9IZ1pgavxfieS+jTaJhPYyNK+WmqWwd2kinj6NNVHQ=;
        b=SFsXJ7q2PjrRoxNkH81bUzIw89bEzSOmY0W1SbeIdujyq0wgVV7D9eKHQzYn7O8kWO
         q6fb8SaqvDRAxQVQkj0SkHuHVnB+Q0xrNqJq6bYKPSCswLgFC+2OrSj1PMCFuLV9qUlT
         c+SCsltPWkElTZZ7N6l4HBWY01Pn+H+Z2+Rg75rGzFrA0bpBlgO06cuLJ8qjiNlOq6e+
         93CBR9sZHnwKxbpg1frVoE1P3iFUwcpa4Clai2yT0x5zcvUXYQYVmywFRYoPwMaXDHW8
         zDgCgUNYi/08e4XKymmXHHubd9QzY4wlQ+HUVJjgDNXyjnRTvjRsIN/dbU+AwCGB7UGl
         1Ecw==
X-Gm-Message-State: AE9vXwNhlGZaC1F0ESa3zeGzXLrBXqjLRmPvoHQHliI9RqbNRcnis3kSmd6mZd8isqVt7A==
X-Received: by 10.28.232.18 with SMTP id f18mr4536154wmh.51.1473968164658;
        Thu, 15 Sep 2016 12:36:04 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB61FE.dip0.t-ipconnect.de. [93.219.97.254])
        by smtp.gmail.com with ESMTPSA id b188sm3797450wmg.24.2016.09.15.12.36.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 12:36:04 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] pkt-line: mark a file-local symbol static
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <6373d68b-574d-59f3-7b8d-60dd3a673806@ramsayjones.plus.com>
Date:   Thu, 15 Sep 2016 17:46:09 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <86997B2A-EF9B-4DC2-84DE-785C1747B7CA@gmail.com>
References: <6373d68b-574d-59f3-7b8d-60dd3a673806@ramsayjones.plus.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 14 Sep 2016, at 14:31, Ramsay Jones <ramsay@ramsayjones.plus.com> =
wrote:
>=20
>=20
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>=20
> Hi Lars,
>=20
> If you need to re-roll your 'ls/filter-process' branch, could you
> please squash this into the relevant patch; commit 2afd9b22
> ("pkt-line: add packet_write_gently()", 08-09-2016).
>=20
> [...]
> -int packet_write_gently(const int fd_out, const char *buf, size_t =
size)
> +static int packet_write_gently(const int fd_out, const char *buf, =
size_t size)
> {
> 	static char packet_write_buffer[LARGE_PACKET_MAX];

Done!

Thank you,
Lars=
