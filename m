Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA68C1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 12:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbeGWNls (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 09:41:48 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:32890 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387989AbeGWNls (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 09:41:48 -0400
Received: by mail-io0-f174.google.com with SMTP id z20-v6so409259iol.0
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=pIxc5b2CnKReIsGcUG6U/O6i9zUC4iX4TxOX7zQes+A=;
        b=Qk9KyaxVhM0y4QOY9gEjJhnJtuaWzNdtIVMFUBXcdnedsGqQPeX9GPns0Go9Di+FXk
         ohSekptCXgx1vQc4MjMFHRtswQYHlLVpFHCrXugh52fVaN5hKXUSyuCtoZoTVfjG0PnY
         fl1KCTilzWxQm5cxDnv8qm5oqgTA9XJZ+0ttf8uiKob0geaWYOk/uvKlHfOpSC7N6oy6
         YOARXMNDQ7t1GODXMxYbbnjSFzLqGTdHnlngKp8wDvHU+Zap5H+NzjxmN+zso7VeJ9za
         ZeVXaB9ZIpe90KQ0EF6rnDNr/Ucm/enSU7Z0pHqFUi1JDp9aoVvngV47k1byH3J4g+rH
         BnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=pIxc5b2CnKReIsGcUG6U/O6i9zUC4iX4TxOX7zQes+A=;
        b=XhqtxdjfdeujFr8ldIm2OwUjICN9OUXWQB9j6/vtxxNV1C6rrp4Gl9yT10A79rF1sC
         m8+GcG2Yg64WJuYEubOgttIF/NAWDWjdsf06wKVVMOtxglbadLvso1T3FpJvoGBeCXrv
         OZJNwTbcSj61kgZcTR7ijbCCJ5ksyNJC7E0O28hIMXX/hJslB2VDbNIbQBvjArgDchsk
         MTV98qbcuETeQ+8UCZUR/TJYE8AWbtTfw130Sx4Pg0V5pLeTKLcUXh5yNVPPjsUz/kHZ
         lUJhbs0MikPFPzLQd49yGR1Se5wctVleDEW2+6Qtrr9yQsxyHaSJ6Rj30OhUOUHwcaSI
         RuLw==
X-Gm-Message-State: AOUpUlEriWRpa1fgL2PWNRnGkwVnxigp1uOkxVrpoTbxqgEOmhbf0dAj
        JV7Cz5CZ/0hOV5kIJOMo3B0r1+bbtiSFDQj8Yr8=
X-Google-Smtp-Source: AAOMgpftsAEEL3oeSourRX04WjJpaSWGZOjOC9gHNtPsPozVw/vaXii7+hOYy7UThh+T8j3oL7vkps48XbQzeMMPuSU=
X-Received: by 2002:a6b:cb06:: with SMTP id b6-v6mr9725089iog.128.1532349645798;
 Mon, 23 Jul 2018 05:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net> <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net> <nycvar.QRO.7.76.6.1807220036340.71@tvgsbejvaqbjf.bet>
 <20180721235941.GG18502@genre.crustytoothpaste.net>
In-Reply-To: <20180721235941.GG18502@genre.crustytoothpaste.net>
From:   demerphq <demerphq@gmail.com>
Date:   Mon, 23 Jul 2018 14:40:33 +0200
Message-ID: <CANgJU+X39NoEoMyLu+FX38=x19LrRqatz_dUpUAc+WFV+Uw+=A@mail.gmail.com>
Subject: Re: Hash algorithm analysis
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, agl@google.com,
        keccak@noekeon.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 22 Jul 2018 at 01:59, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> I will admit that I don't love making this decision by myself, because
> right now, whatever I pick, somebody is going to be unhappy.  I want to
> state, unambiguously, that I'm trying to make a decision that is in the
> interests of the Git Project, the community, and our users.
>
> I'm happy to wait a few more days to see if a consensus develops; if so,
> I'll follow it.  If we haven't come to one by, say, Wednesday, I'll make
> a decision and write my patches accordingly.  The community is free, as
> always, to reject my patches if taking them is not in the interest of
> the project.

Hi Brian.

I do not envy you this decision.

Personally I would aim towards pushing this decision out to the git
user base and facilitating things so we can choose whatever hash
function (and config) we wish, including ones not invented yet.

Failing that I would aim towards a hashing strategy which has the most
flexibility. Keccak for instance has the interesting property that its
security level is tunable, and that it can produce aribitrarily long
hashes.  Leaving aside other concerns raised elsewhere in this thread,
these two features alone seem to make it a superior choice for an
initial implementation. You can find bugs by selecting unusual hash
sizes, including very long ones, and you can provide ways to tune the
function to peoples security and speed preferences.  Someone really
paranoid can specify an unusually large round count and a very long
hash.

Also frankly I keep thinking that the ability to arbitrarily extend
the hash size has to be useful /somewhere/ in git.

cheers,
Yves
I am not a cryptographer.
-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
