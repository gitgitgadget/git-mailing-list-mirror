Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFA941F461
	for <e@80x24.org>; Wed, 21 Aug 2019 12:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfHUMhs (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 08:37:48 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:55949 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfHUMhs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 08:37:48 -0400
Received: by mail-wm1-f50.google.com with SMTP id f72so1943750wmf.5
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 05:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mat.ucm.es; s=google;
        h=from:to:cc:subject:references:user-agent:reply-to:date:message-id
         :mime-version;
        bh=JIO6jeUIOZgq6yTS6A5b9PtIOex8NYFlgeXG+2l7/p4=;
        b=hZFPZDKKZvoEPgd7Z8BVRlJv5bTp4NZ8vifGL9N2+sL097YaE7AKFkVrxFR1W7dbLL
         Bg1W3mWvFJCR3iMLcSLzAJ2j31PySD1308qBnBUl0BpwcQ2fKiZNb6W7/Ojz5y6fOGpa
         KFp/lJec9yFzK1bG7XUwhXZZjU/UFmYmT5aZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :reply-to:date:message-id:mime-version;
        bh=JIO6jeUIOZgq6yTS6A5b9PtIOex8NYFlgeXG+2l7/p4=;
        b=VxcVrawrtFRPz9wWH2GHNBKXE+GJ/s2QyoR4nzeIVeVmDvRKRrL9hF4sFKWtOHSv+N
         6V4ivfPadZYelfJzeAW71ZMWgwOPjVx3ymO/VN9sIU5C13oz6LYMBljk9gOPzP6EU8Zy
         2xzS6MzVQDIME31T3AdR1vxDuhKdN4OT2/0UJg/mWSbwM3ToLncneS9TKsc1E+8RF9LP
         YsR947iyfqytx+GrTTW+FV1eyDm/kADJzdyCWE8PE/WB3QEAwQLhpAPkpjZONeW/9xTw
         CIGgEjYXnfK9Ul2rGKoiP4KCMBGUoGf2dwdd3TaE7K/GvnLxExg/PQrIzYDN9BUMgGfL
         Bt5w==
X-Gm-Message-State: APjAAAUCpipHSQu5JAjzBD0DwkPFG4fNku9k2vnF1R9Q49AAMBcScbBz
        Rq6uxNhTNFBb2oVj0bMMXc60skDx8qk=
X-Google-Smtp-Source: APXvYqzi1HmeR8IV8lRSR9qBuHIvvOp/p6O7MTrMiotFDBYzKvo1/LP8Cqu8wJT4MAy40XhfypBYnw==
X-Received: by 2002:a1c:411:: with SMTP id 17mr6177347wme.34.1566391065988;
        Wed, 21 Aug 2019 05:37:45 -0700 (PDT)
Received: from Utnapischtim (p2003000611CFBC14D5AD6B2F5C7C552A.dip0.t-ipconnect.de. [2003:6:11cf:bc14:d5ad:6b2f:5c7c:552a])
        by smtp.gmail.com with ESMTPSA id 39sm70502201wrc.45.2019.08.21.05.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 05:37:44 -0700 (PDT)
X-Mailer: emacs 27.0.50 (via feedmail 11-beta-1 I)
From:   Uwe Brauer <oub@mat.ucm.es>
To:     Uwe Brauer <oub@mat.ucm.es>
Cc:     Phil Hord <phil.hord@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Git <git@vger.kernel.org>, Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [problem with name-rev]
References: <87blwq7rn5.fsf@mat.ucm.es> <20190818190032.GA11185@rigel>
        <87pnkzkivn.fsf_-_@mat.ucm.es>
        <xmqqh86bvgsz.fsf@gitster-ct.c.googlers.com>
        <87k1b7k4w1.fsf@mat.ucm.es>
        <CABURp0qHnzpwr8dPtPZpA+1C=tEsoybh2V00iHpyrJ2AM8XHzQ@mail.gmail.com>
        <87pnkz2bzy.fsf@mat.ucm.es>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
Reply-To: Uwe Brauer <oub@mat.ucm.es>
X-Hashcash: 1:20:190821:gitster@pobox.com::z9SWDrueystJDmQR:000000000000000000000000000000000000000000000IYf
X-Hashcash: 1:20:190821:phil.hord@gmail.com::K0Xg38L64dDg0+bB:0000000000000000000000000000000000000000003Vug
X-Hashcash: 1:20:190821:oub@mat.ucm.es::6uS+5EOeex2rGPAV:0003vPT
X-Hashcash: 1:20:190821:alban.gruin@gmail.com::Bk0XoB7TVcGutwtw:00000000000000000000000000000000000000002A7b
X-Hashcash: 1:20:190821:rafa.almas@gmail.com::klfYTKUqhhNr1S6J:000000000000000000000000000000000000000007hpv
X-Hashcash: 1:20:190821:git@vger.kernel.org::6byCmKcIvjGdZkhV:000000000000000000000000000000000000000000AaHy
Date:   Wed, 21 Aug 2019 14:37:41 +0200
Message-ID: <87k1b63d9m.fsf@mat.ucm.es>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org






   > That's it, thanks. Interestingly enough the 

   >  git graph looks differently from the mercurial one.

It does not. I just did not understand the git commands at first sight
well enough. Both graphs look the same. Sorry for the noise.
