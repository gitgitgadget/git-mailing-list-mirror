Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBF0C20C11
	for <e@80x24.org>; Thu, 30 Nov 2017 13:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbdK3Nzi (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 08:55:38 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:33577 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752233AbdK3Nzh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 08:55:37 -0500
Received: by mail-wr0-f169.google.com with SMTP id v22so6686716wrb.0
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 05:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cw5iOSyYq+RZVSEYzmbAPGzlQDW/7CqsRZnn0Bso4OQ=;
        b=jyqEGJtycdNci5PX57mR7qHl5LBG/KCeF82h6glQDA/1OYUVvj+GI7JpscJ+YfKC44
         d/s708Rk/p2NiSDq7mC62NglJW9qA1HNL2jdilCV6CRU/G4NbxxgebXCYlYvTgYj93KK
         nK9yjjWTVLXuvXu2zFokDPyQv6E1QSjC8F7W1kPwqeZuOPRjovoYTFg0AQDkCBDYekWi
         sCGMJIGEjoRJShwan3KvaR+lNIKofKOhUi5F0cH1OufeMQW0tSYE80y3YSzdEo9ly818
         ARjaAu43XaIt7MnFQkfUO7B9deBsumTzpxRbs7pUBqz/0+DlXilrJIogeoMOTIvnHZvB
         1S7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cw5iOSyYq+RZVSEYzmbAPGzlQDW/7CqsRZnn0Bso4OQ=;
        b=CksCbllqg0pmhPDXOhD7DFJMapS+P6IEymSczBXJSRkXLxJA7hNXjrS9H08IYpz3Lg
         yISHhnImw82pf2WIiWAO29jYl+h+uhnY0+YEGZQVQXrQ+niRYRo5AMMMzfM07akCOduZ
         aVt+qtka9Qm2K5ApXLiDLRF1eALHXzx7eBtsxu6pcr7880Jy0wvQvpNpaKrEbX+C1yDx
         NKAR/+E24jtFalrSzeuVlkYS/9zn3vWSS5fn094xmqZfc2HH3QGXZhAoRs2SnVZRCZXX
         X1dQOsqzAPK3Mh8VMuIzJzA+zt1h4lgQCRLl8M6D60bOMWjOfKltZmW3Ojnjvt1mL9Jy
         lFkw==
X-Gm-Message-State: AJaThX6bjqGNxAFu0KDbufzWMRLPwEfxfKasOBnqdAJFxA9OoVFEL25M
        ESRwO8HliSk1/FDPL7IKgBM=
X-Google-Smtp-Source: AGs4zMbAblQX1UWLpz8HM7IhUJ5B2r9vTZYeRse4N7mEojEo5sy7/HkKNn0yeVv4PVTpWGA1bNRJlQ==
X-Received: by 10.223.136.80 with SMTP id e16mr2021959wre.21.1512050136223;
        Thu, 30 Nov 2017 05:55:36 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id e71sm4810426wma.13.2017.11.30.05.55.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Nov 2017 05:55:35 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 0/2] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171129183514.wze5trxjfgqxqs7z@laptop.local>
Date:   Thu, 30 Nov 2017 14:55:35 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <C91E8F24-DD13-4FEC-BAB3-A8B8F2DBBA8D@gmail.com>
References: <20171129143752.60553-1-lars.schneider@autodesk.com> <20171129183514.wze5trxjfgqxqs7z@laptop.local>
To:     Thomas Adam <thomas@xteddy.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Nov 2017, at 19:35, Thomas Adam <thomas@xteddy.org> wrote:
>=20
> On Wed, Nov 29, 2017 at 03:37:50PM +0100, lars.schneider@autodesk.com =
wrote:
>> +		if (print_waiting_for_editor) {
>> +			fprintf(stderr, _("hint: Waiting for your editor =
input..."));
>> 			fflush(stderr);
>=20
> Just FYI, stderr is typically unbuffered on most systems I've used, =
and
> although the call to fflush() is harmless, I suspect it's not having =
any
> effect.  That said, there's plenty of other places in Git which seems =
to think
> fflush()ing stderr actually does something.

I agree with the "unbuffered" statement. I am surprised that you expect =
fflush()
to do nothing in that situation... but I am no expert in that area. Can =
you
point me to some documentation?

In any way, would all this be a problem here? The worst that could =
happen would
be that the user would not see the message, right?

Are you aware of stderr usage in Git that could cause more trouble?

- Lars
