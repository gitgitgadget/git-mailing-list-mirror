Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 868B620248
	for <e@80x24.org>; Wed, 10 Apr 2019 03:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfDJDJ7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 23:09:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36105 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfDJDJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 23:09:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so861896wml.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 20:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sfqr/JweF8At8R+jeLH2Oz8G2H1/Bh3cRA0hJ64+bFQ=;
        b=sXVfa5B/xkLQF2nVfpn94vnZK1VRCKeD5ME/PclHJyhmPczcOF7tZUzYtPmlDOR8a4
         H0p8JF7lEWuTacAHcsBMgjCVHK6QxdfSyqf8+a3s4OzVNxAFiJTZg3G5DitOMdpO5sc0
         lIHhHz8Rbs6Iu6OGe6IegX5xUmt67/6+XTtIwLImOy9dqOBOhT3CncuoGK3lMEkLNsTD
         x5J60gI1/8St8JVuWIXkRrPti4YADph4/il/fc1mSqstSHrHzxkPfTrRhSyVreLVtnR3
         7iTwRN81O9N059TSgsILrTu4FHOVkGCs0MixprjcpAb8HbEOMR1ijBxIIFh48+Nq6Xls
         Mu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sfqr/JweF8At8R+jeLH2Oz8G2H1/Bh3cRA0hJ64+bFQ=;
        b=DY+QOmwhXP+kIl7n6WPx6Rlh/5dUYbHUex/HswGBoX/P2BpPBqVATFBKRs2Rsc/grs
         wTPMV8jxp0IyPcM+VyENAYOT5PFU4j/AlqhfhQ5ykTBNErz+b/TOYPaBkjlPmVR25LvC
         fpareXBmOLW7t7jW6v3WeCG9uV5FCSN0jdeIKFEJhZzS7Cd8SjYtr1qipfXMObf0Uyes
         mwGme8s7Igu8NmfyC8AQt8X0lJO5b2n3aSh4iaAEgapfrIAipH9k6voYDir+Ej14JFVA
         viAwmTqkZnRzoeFIl9B4moJhWCB1uH8LSwmWy+XWzHIiwetu2ifqrgi2y1pgNacUdnrG
         fmsw==
X-Gm-Message-State: APjAAAVkpCio7vzc9EJVrGfuFynIPaLY6D9D1MO8gCZhfuqj9XnWFJxX
        9+Sv5HSPbNWVHv1Ldcs0tZ8=
X-Google-Smtp-Source: APXvYqy7wkJD73zUK4Zp+KOVqQiN/pzxPMUbV1dPe0dgDpmwS3voOK9A9YwB/sfCL7TJpdN6XWdp4w==
X-Received: by 2002:a1c:cbc5:: with SMTP id b188mr928256wmg.87.1554865797137;
        Tue, 09 Apr 2019 20:09:57 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id r16sm25005793wrx.37.2019.04.09.20.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 20:09:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 0/2] a few more minor asciidoc/tor formatting fixes
References: <CAN0heSrPx+_dB+NZzRzidZFpfLMpQUHk-Wi8rTaer+stam0NPA@mail.gmail.com>
        <20190410003734.17124-1-tmz@pobox.com>
Date:   Wed, 10 Apr 2019 12:09:56 +0900
In-Reply-To: <20190410003734.17124-1-tmz@pobox.com> (Todd Zullinger's message
        of "Tue, 9 Apr 2019 20:37:32 -0400")
Message-ID: <xmqqef6a369n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Thanks for testing these against older Asciidoctor and for the
> helpful feedback on the commit messages.  
>
> I reworded the message in the first commit to make it clearer
> that Asciidoctor renders the {apostrophe} literally.  I updated
> the body of the second commit using your suggested wording.  It
> was much better than the original. :)

Thanks, will replace.
