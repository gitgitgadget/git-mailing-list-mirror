Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 772D820954
	for <e@80x24.org>; Mon,  4 Dec 2017 21:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbdLDVbT (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 16:31:19 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:44613 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbdLDVbS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 16:31:18 -0500
Received: by mail-wr0-f171.google.com with SMTP id l22so18867375wrc.11
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 13:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cf2C2nDqm3y+fWK8DAG7Abf+Z217pJ7+ENI5Mq47SMM=;
        b=GDdwVO0LO59MEXeeCW3yM3vgf7355PYtXhlFHvkZ3DxwyLemewkLSoqSq3KrHJ74bQ
         IqdVBu3q59iEoMV4mN4D+yPdUSxFH6sHcFG1DXA/GhX6Kma/E7JZwRDWuny64Ovxp4p7
         XBRyi90hip7p3SVfVTa/+CtlMsNqeQqaRGD05XoSdLw4xJYT11ijaqF7vfDCzV13/ZCW
         nz4OMK135Aa3NLdIH9sjRg3CsJICVlxoLF7PavHi5jKxN+kT3v7cUf86hPhjZZCWLT9h
         S3E2vCt/MK4M/YAkTquY6jeR84L9MUxypkZE+yWmLPJRy6gwKBP47I/BPn59YS8NgzX6
         pb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cf2C2nDqm3y+fWK8DAG7Abf+Z217pJ7+ENI5Mq47SMM=;
        b=hE4Xb45oRDXGDIyGDmxzBGqUDp5nRSEiGCpwofv7FAQm89gVFj/SPU87JraeZvZbdG
         vAOMKqyZI3hsAGZIyg3piuiYPaAsd7F7S4n8TS4O3S5mgAfabphIKIPfOeqozXiPK3oK
         g+ZKCn433D6/TSLGvlMUfCraVvHoBEQ2Q9aYPEVM4cQgg6U2OSQAAryJ0jrDhfW6ZqFO
         fbyqKuXyu9yYIBbH5U57mXR4I5fM7cFrNWiwon1meoVB4hsTme6M6sdBwj3mpBzhmWVx
         7BjBJUj1lWtl31XRwBkXtFquFwoXCHn9uotd6Tu7kexzQ+tddJXDghYBGfip8Tblf385
         wZ+g==
X-Gm-Message-State: AJaThX48aZpBs13CFThF0wyUdRZhUvdE7XxeNQAlCy4jVr6yhC7ELKBt
        VTa4nIvo+DkRxOfTas8i5j0=
X-Google-Smtp-Source: AGs4zMZsdF9eTxgeRBDR9iy4xzxiWIEP6dlqiuZShDf1sq2KYE1IRaTCSMCEpz9eGSMVL+Omgurjxw==
X-Received: by 10.223.165.89 with SMTP id j25mr14616480wrb.206.1512423077445;
        Mon, 04 Dec 2017 13:31:17 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB6B70.dip0.t-ipconnect.de. [93.219.107.112])
        by smtp.gmail.com with ESMTPSA id l1sm1856021wmh.13.2017.12.04.13.31.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 13:31:16 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 2/2] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171204172623.GD13332@sigill.intra.peff.net>
Date:   Mon, 4 Dec 2017 22:31:15 +0100
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        sandals@crustytoothpaste.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <07CF6EAE-815E-4846-887D-560F2459E69D@gmail.com>
References: <20171129143752.60553-1-lars.schneider@autodesk.com> <20171129143752.60553-3-lars.schneider@autodesk.com> <20171130205137.GC3313@sigill.intra.peff.net> <BB878570-F214-4BAA-AB58-4A9C0F8F80AB@gmail.com> <20171201182924.GB27688@sigill.intra.peff.net> <aacb7604-edc3-a920-da43-701b57045956@gmail.com> <D330CEDD-7F6B-49DB-A30E-EE0BDB80E28A@gmail.com> <20171204172623.GD13332@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Dec 2017, at 18:26, Jeff King <peff@peff.net> wrote:
>=20
> On Sun, Dec 03, 2017 at 05:39:10PM +0100, Lars Schneider wrote:
>=20
>>>>> +                       fprintf(stderr, _("hint: Waiting for your =
editor input..."));
>>>> I found "waiting for editor input" to be a funny way of saying =
this. I
>>>> input to the editor, the editor does not input to Git. :)
>>>> Maybe "waiting for your editor finish" or something would make more
>>>> sense?
>>>=20
>>> May be the good "Launched editor. Waiting ..." message, that was =
used in a previous version, itself makes sense?
>>=20
>> Perfect bikeshed topic :-)
>>=20
>> I would like to add "for your input" or "for you" to convey=20
>> that Git is not waiting for the machine but for the user.
>>=20
>>    "hint: Launched editor. Waiting for your input..."
>>=20
>> Would that work for you?
>=20
> I guess "input" was the part that I found funny/confusing. The only
> thing we know is that we're waiting on the editor process to finish, =
and
> everything else is making assumptions about what's happening in the
> editor.

I see. How about:

"hint: Launched editor. Waiting for your action..."
(my preference)

or

"hint: Launched editor. Waiting for you..."

- Lars=
