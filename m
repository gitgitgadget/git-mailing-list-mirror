Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B39FF1FAED
	for <e@80x24.org>; Thu, 26 Oct 2017 11:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932336AbdJZLBe (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 07:01:34 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:52483 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932141AbdJZLBa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 07:01:30 -0400
Received: by mail-wr0-f174.google.com with SMTP id k62so2733405wrc.9
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 04:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=24gNhHr/LD9LytJkEkX2X/nkYTPL3qXt4bZDsxOYMXM=;
        b=mZ60lQTct4fXmNxpL7w51Z9mbuUE2HblTvQkTOZqxXPQ7vjLHuPV7XrickEXqznhxe
         dINesbDNK42v7j5yrIt50hfmC+i9OCwD0mQrZoL8xAbkDgIxc21YWW8rK+WyIYIej3L7
         I9Q/FBKEu3rCgknVNKx9FknBdjQmkyy7plnHBYlEpMbUl4rxgSJ3Kw/ue9qjB94RmZaL
         hwJQ1yrU7F3bvTJCFN3Dx12VuTf+RLazFP6SyjaxaTU0MXLqhC/rC1EQMVbMFUqBqLM+
         p7TpPnSAVhKt7ar0kzq4UbTLlFo8eqSrxnhZBWJbrY7uiWxEpFH09c8EbHTlr8XgVg++
         xDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=24gNhHr/LD9LytJkEkX2X/nkYTPL3qXt4bZDsxOYMXM=;
        b=fFcOudRi0IPR8gVH2FD9dcgTiQtv0Xs5th7FUcxFnrblT5O7w8tBtEQOxuX6SXIXUv
         vF4ubqqJaV56/Y5fxxMvv+G4tMIA7cLaAhDUxPttY79GHFQ+8PgX36T2s9C+oia3K6JG
         42GKNMdbFbpnLV3vmlZLrdPi8F1qNU4tG0IDC4xazXnzRYGANMwtIMGKBTsjnotkro9V
         kDaTdi9sYRpYf/SFdXJmO1NS6x0cLQEuz5VVqw3nQMFMMf444fFIBrQDfUZpcSkHvvwy
         xEpWqsol9Hl5hNbwwiN9MwxsuHVESKkSJ8Xaz168PgjOp7vYXfvnb1bBLvy/mJ+pxdbC
         Nq/Q==
X-Gm-Message-State: AMCzsaWohwBt6B4asTUO584YCLLTE8z1p4vpwXxnpp4ytambpXEjD8/Q
        C4GoR6T5rcxeOIbdfJARVLA=
X-Google-Smtp-Source: ABhQp+T5Gj1SoKBGjJVEF25wgNTSmRJfC+LwrKI1eY3/CrcL4LUXjooH9+2PjXgus9rzX/cW3gJqAA==
X-Received: by 10.223.131.226 with SMTP id 89mr5186608wre.227.1509015688592;
        Thu, 26 Oct 2017 04:01:28 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id y29sm4346373wrd.3.2017.10.26.04.01.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Oct 2017 04:01:27 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Consequences of CRLF in index?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <5e962f69-f9cb-bd7e-481f-050e6239813f@kdbg.org>
Date:   Thu, 26 Oct 2017 13:01:25 +0200
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <30ED36AB-FAB1-4635-94AF-FCEC6F02CE01@gmail.com>
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com> <eda48d5e-a52c-9a39-8e55-a6828efdb3ef@kdbg.org> <alpine.DEB.2.21.1.1710251415040.6482@virtualbox> <5e962f69-f9cb-bd7e-481f-050e6239813f@kdbg.org>
To:     Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 26 Oct 2017, at 09:09, Johannes Sixt <j6t@kdbg.org> wrote:
>=20
> Am 25.10.2017 um 14:19 schrieb Johannes Schindelin:
>> I envy you for the blessing of such a clean C++ source that you do =
not
>> have any, say, Unix shell script in it. Try this, and weep:
>> 	$ printf 'echo \\\r\n\t123\r\n' >a1
>> 	$ sh a1
>> 	a1: 2: a1: 123: not found
>=20
> I was bitten by that, too. For this reason, I ensure that shell =
scripts and Makefiles begin their life on Linux. Fortunately, modern =
editors on Windows, includ^Wand vi, do not force CRLF line breaks, and =
such files can be edited on Windows, too.

Wouldn't this kind of .gitattributes setup solve the problem?

*     -text
*.sh   text eol=3Dlf

Thanks,
Lars

