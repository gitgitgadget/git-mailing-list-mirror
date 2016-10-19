Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6640E2098B
	for <e@80x24.org>; Wed, 19 Oct 2016 14:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936201AbcJSONt (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 10:13:49 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35554 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935738AbcJSONo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 10:13:44 -0400
Received: by mail-lf0-f67.google.com with SMTP id x79so2253555lff.2
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XT+iMLGzKh7ornaE++RUSD6LM9jrJBM1FAGfxn8Q0rA=;
        b=RrmFf6AlfWLUIEBGB46rzZIwjbWoV0KZvLQF7JDysqA7+VE3ubdhQ/kANO2nkhi5Ha
         H5pOiX31cwEUxJDbqTNILlQe5skeu7whwAWApYpa4bbtuC5p2dh7AA6k2k/xUQGugbpu
         kTEM43UK815wI7XTLQKvesAvFh/0hvMjiMnpCuqOHoorB/839UNv+RfdmbJREuI55Q3A
         X6gKeBkMphVQiV8dpUZohGAw95zd2CVQ0uizhfwT4ZUgXOascgDTtbb3iy4xqreS34eB
         IIvBLFfqWv8szmqLBJMmKo4JkGbqRLm5N78AmmHxxBKIZODmouOIfPPwDQjJxl67IxMA
         AT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XT+iMLGzKh7ornaE++RUSD6LM9jrJBM1FAGfxn8Q0rA=;
        b=eYeQXl+YVEyvRzWhg0X9pTWQ4S+IqL9d4mkr6PPVfsDy6gVJEjrHyFdvb5I+kDRUUY
         yKnSvdyjP/XwVX/CumSLY/RZXe7nEOXlXZa324Wf0vW6HWNO7Qz2MYBm/q0TT4QaUOz0
         XR5C93+VCsuRatZw9ZN71s11R+yFkM/Gof15HogQJs1ezDXMltf7yUXjJhJtoj2XIYmc
         A6K23v7r1SR4PLYvo/emI31WKZyJvisXwvfkfd9jlReTSh+F7AO6g4ioWFFuN/+KL6BN
         W17B7J3D2kh8r0sZ1y/pKEyteuqjP3gINSD+qqKVOnweATi814uNbFY9YF7jFo2MXbFr
         L8UA==
X-Gm-Message-State: AA6/9RlI75w3VtWuR34wUWj9fXgdQ/MqyABtcmbNOH70kmmZyU5/EetvwvjQn9BXt+asfLNBEqSJ3+im+WsXfQ==
X-Received: by 10.25.28.197 with SMTP id c188mr3330742lfc.81.1476886422801;
 Wed, 19 Oct 2016 07:13:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Wed, 19 Oct 2016 07:13:42 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 19 Oct 2016 16:13:42 +0200
Message-ID: <CAP8UFD2WN4nGzAp=fHMUpzBsmCeGN3aMN_dEVgCnkyJECY=93w@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 20
To:     git <git@vger.kernel.org>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, lwn@lwn.net,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Kevin Daudt <me@ikke.info>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>,
        Andrew Johnson <ajohnson388@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Rich Felker <dalias@libc.org>,
        "Kyle J. McKay" <mackyle@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I'm happy announce that the 20th edition of Git Rev News is now published:

https://git.github.io/rev_news/2016/10/19/edition-20/

Thanks a lot to all the contributors and helpers, especially Jakub,
Dennis, Dscho, Lars and Peff!

Enjoy,
Christian and Thomas.
