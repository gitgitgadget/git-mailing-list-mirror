Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 818A62098B
	for <e@80x24.org>; Sun, 16 Oct 2016 21:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754005AbcJPV5K (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 17:57:10 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33164 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752123AbcJPV5J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 17:57:09 -0400
Received: by mail-pf0-f170.google.com with SMTP id 128so71300806pfz.0
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 14:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lrvAHbLoYLIJL+YLGt91rWe7fjwWpjZGgcRTKtnBCD0=;
        b=xbphJ8W3IrMAyLOYJ+XtqcFJ9VqBfEkvcX6kl6rZyGHMshLj5BO57e6JJCv+kPdY3J
         yuXDQVNZpQ8HhNFa7B3Pp6OGerb5FA9AguaXHOJTX9JEs2+S4Ar2NDMALVc4gMpaVtpf
         h7s5tnL2r5wOQwejEKN2AKsrDzW6y2gTCB8exAK4Z3qVJ9dptMqu6QD1YnGex6A+bjJZ
         1Q7N0imdhM/iV3udLjUAxcpnQ9/Bsrxr+dqgb8dWsNDlyvwvOO/umOzfVy4QBka4pS6Q
         g6nk9EC4s/aDF2loeJvcTMZnCRKCjPPOEHW4vLnZsDMrne+6ljt9b90W6/TaErHJt1hM
         edGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lrvAHbLoYLIJL+YLGt91rWe7fjwWpjZGgcRTKtnBCD0=;
        b=GqjcwnEglQUuMn75p5wCpEOWwonXvr2r6TmOgx8pyGQu+AFSpTPrMbpoaOQSK3kgIP
         sHe1zqL8nsGvykSHT8YXPYRFZs89DEXzZxDqRcnCOaF72QPfECEjVHlO/LE2oWj7wxIE
         w9QsI6I6eSln178+b9EqDu2dDmlqry56sWFGcJRt6ncwf/PFzVyhhbLeMs//v8TQDQAn
         YdRCc3g61eDGCQyLNETW2nogpxe4B5MTFu+5Evc/iXtOu2BngPBaF6d6Xttky2b4cY14
         hIEorVRReRg0lWNAK+mo7L1MefFL9BuNbjvEavu5BGHfn5g1TFGNmOSAaes+QuqcdVNc
         xVjQ==
X-Gm-Message-State: AA6/9RlH6U03euqfpFe1jLFqBJsUx6NT0zYrf4WRVqV1VXnqA8vkEM4bsLsn0npu0YKsXQ==
X-Received: by 10.98.78.68 with SMTP id c65mr33623665pfb.43.1476655028400;
        Sun, 16 Oct 2016 14:57:08 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id t7sm42601085pfa.22.2016.10.16.14.57.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 14:57:07 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v10 04/14] run-command: add clean_on_exit_handler
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.20.1610161003040.197091@virtualbox>
Date:   Sun, 16 Oct 2016 14:57:06 -0700
Cc:     git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
        peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <8142AA77-4EAB-4E74-BC06-A8A84AE40FBD@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com> <20161008112530.15506-5-larsxschneider@gmail.com> <alpine.DEB.2.20.1610111407080.3492@virtualbox> <9C686FFB-CB07-445E-B812-97781CAB113D@gmail.com> <alpine.DEB.2.20.1610161003040.197091@virtualbox>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Oct 2016, at 01:03, Johannes Schindelin =
<Johannes.Schindelin@gmx.de> wrote:
>=20
> Hi Lars,
>=20
> On Sat, 15 Oct 2016, Lars Schneider wrote:
>=20
>>=20
>>> On 11 Oct 2016, at 05:12, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>>>=20
>>> On Windows, pid_t translates to long long int, resulting in this =
build
>>> error:
>>>=20
>>=20
>> Thanks for hint! I'll change it!
>>=20
>> However, I am building on Win 8.1 with your latest SDK and I cannot
>> reproduce the error. Any idea why that might be the case?
>=20
> Are you building with DEVELOPER=3D1?

Argh! Of course ... I forgot to add this flag to my config.mak on =
Windows.

Thanks,
Lars
