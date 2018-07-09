Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFFF81F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 05:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeGIFNe (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 01:13:34 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:46708 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeGIFNd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 01:13:33 -0400
Received: by mail-oi0-f52.google.com with SMTP id y207-v6so33532479oie.13
        for <git@vger.kernel.org>; Sun, 08 Jul 2018 22:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=clKwnN5SiOO2Z1b1KiqGNwkgWoVWtIdEUa/Wqwr6mXk=;
        b=FpFKmjlBS+AakgTDGyit8z+lvI2ffCHnTHag8HVRlf0uStapQ2/SPcuT9r7zQP7FRi
         dxI8ERISijWDFDU1xzzGOyY1+ZsV9SSZeR1YtpOuxe4mS4TD6lIi7KAXG/VO4JAodPYL
         H+dbmQaoJG8d/geqGoXwN0jH8EEFmDBfjZZ6VHe6lN6yGc7L/YWedu1mXUNJLoxZiTVX
         4GAeO9OiHpiRizZSsiX78nzG3RTRoe1rVBMzmKe0h9NKy3hu1H944GGZ9Hw61Gb+QrRj
         q0Y8va87AIeR58voUqPbisl46CpHBackGc0riZTf0BdzlB0e5ZqenEuOWVU3IJkuhPit
         /Aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=clKwnN5SiOO2Z1b1KiqGNwkgWoVWtIdEUa/Wqwr6mXk=;
        b=L/jpHUZXx6R3RsGU6kasKaz3DKxdSrMcAxq1906jd3ic3WxNyAFHmWMyyGb8oO01AZ
         CkVfW16cimJD4+nOw6W7ewVCZYszGr2nkxRFd9Eu+w4OsD6ZepWTZDF/AVuHckFoJtSd
         A4Q/BNz5OqSalbVt1XPKB+IJh4JINo1e1/zQVJ2Fi3I9HpHYyrxgQr/I1cYMrrK/GBEZ
         RzWubNELQ+IOcBiSGDrKz/tVZ0+Uu2zgByZZyqXycfVuUSkWK7mNxtja+IdVsRNOOGnu
         lMaB7c8AoeH8WlSQ+0Yl0ipTLzbpVjGAwdiDMDgwDFfgP5Ir8vCGTKUvU1fdG/co2Ywa
         ECQA==
X-Gm-Message-State: APt69E2WU+xDlJZlm1OF5wreb3N85bjZMUhoVzuPzPmMC4agSRQVgJ7Y
        WNxdpElyuLbf22zpOgRbpz69YS8tH4OOxLCG/C/uGLRs
X-Google-Smtp-Source: AAOMgpcm6lQmwDoz/FG+A7SWiI8G62eahp0DkseJkODsbvDBsQ+TRtJelLjm31TdanNGAJ2uASBDvdTkbverS24T9l4=
X-Received: by 2002:aca:3ad4:: with SMTP id h203-v6mr15417166oia.294.1531113213263;
 Sun, 08 Jul 2018 22:13:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:74c3:0:0:0:0:0 with HTTP; Sun, 8 Jul 2018 22:13:12 -0700 (PDT)
In-Reply-To: <CAFW+GMBLeLyJjJPaEXkyQ5fJ=L4q4vQ=26wjZ+n07ZvSaTaCUg@mail.gmail.com>
References: <CAFW+GMBLeLyJjJPaEXkyQ5fJ=L4q4vQ=26wjZ+n07ZvSaTaCUg@mail.gmail.com>
From:   William Chargin <wchargin@gmail.com>
Date:   Sun, 8 Jul 2018 22:13:12 -0700
Message-ID: <CAFW+GMAnkLYReotwRvbVt9iPqmuq_8WMc1sck4Jkj_fyafVm3w@mail.gmail.com>
Subject: Re: Unexpected behavior with :/<text> references
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After further investigation, it appears that ":/foo" indeed resolves to
the commit with message "foobar" (in the above example) if the commits
are not all created at the same time: e.g., by adding `sleep 1` between
the commit commands, or exporting `GIT_AUTHOR_DATE`.

This leaves only the question of why :/<text> references don't resolve
to commits reachable only from HEAD, and whether this is the best
behavior.
