Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88E1F1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 22:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395301AbfBMWni (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 17:43:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37580 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392624AbfBMWnf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 17:43:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id c8so4386297wrs.4
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 14:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tisgE8mYrbIRus/ndLC4LuJceCvpgYbj7a+IEhcMqtc=;
        b=qKRSTqg92qzkHf4p5sRKGGSchfnB4kXGMM3D38yzJq9qJIFX6tNQT35VdRKXK/03px
         1960veTVonifKzf0ofxJJwntFpNQo5nYMjP5QgCc6o5PVBeVB8G8psNETIJIlQrNbTSV
         gzOT7TrnTwKbe+KQ1ftpADwHuAh7fKAKuG5J+uHTAP4xAEuIArB/FR96aKJC5sQmxRmQ
         4ExfqkJO2AhYc5mz8up4sb7QTBqj1LM1EjEg2YBEc5yctwAkiROhQ/e0DtAQ8wVEPGyP
         2OwEOcHR0jhJhZxDnmeolAeqKLxmc9Babsdx4MnaJd7Svy856a6a+nA1ayNs05+70AZz
         vmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tisgE8mYrbIRus/ndLC4LuJceCvpgYbj7a+IEhcMqtc=;
        b=WNjNmV9/CvZyxCeRDu8/lq57v1hws6i0fL1BhR9DJJhSR8bJGR7c6qmOgyxeJhs59D
         kdVSSG1hdFanoiOCXBel9onFYaOkiEOCZ2R6Li+GOON34dayZIRCa//rymbf3AXeb61F
         c7vW1oCbbvMfBVQ8HN6xnOFXEkQs8012qIDUnCuVQGCzGk1bjetLYpFsz4Wj8j9tlefT
         0hBKkwKJ1R23t9WG3B8gejwBtMpzR0/pwfvQwXAcWy49VL3gB2GP6UpT2ZSntStWcjtn
         k/vInLsWMZqssVPSFsmXMAyCVuSl2r2WjDs4VFPl5KKh3HFnjKs8mgEBf2sRgmpF7ktV
         +CNg==
X-Gm-Message-State: AHQUAuakZ39zWYVTUHAB3qnjaZmAfVE3IRqUdB1qLhDGVKlbWMfTJbKl
        XPO0TdWoTrXnifeqM50+/zE=
X-Google-Smtp-Source: AHgI3IYmmUDqTXhhW9BEjR+xTTgMKOUF0oCKfoe2lb3denwxJt1af1asHiMLEml3gpplMb/ZJqkMoQ==
X-Received: by 2002:a5d:4804:: with SMTP id l4mr294832wrq.177.1550097812719;
        Wed, 13 Feb 2019 14:43:32 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j33sm487790wre.91.2019.02.13.14.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 14:43:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Maris Razvan <razvan.alex.maris@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git-pull Documentation
References: <CALZbgSSzpd7bDWE1iyfqAsv9oovsSK22oReDiPGG-Td5D2qgaA@mail.gmail.com>
Date:   Wed, 13 Feb 2019 14:43:31 -0800
In-Reply-To: <CALZbgSSzpd7bDWE1iyfqAsv9oovsSK22oReDiPGG-Td5D2qgaA@mail.gmail.com>
        (Maris Razvan's message of "Wed, 13 Feb 2019 20:13:09 +0200")
Message-ID: <xmqqsgwr9ung.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maris Razvan <razvan.alex.maris@gmail.com> writes:

> I checked and the current behaviour of "git pull <remote> <branch>" is
> to update the remote-tracking branch if required, because, as I have
> seen in the code, it just calls "git fetch".

The thing is, "git fetch origin next" did *NOT* update remote-tracking
branch refs/remotes/origin/next for a long time, until f2690487
("fetch: opportunistically update tracking refs", 2013-05-11)
happend.

The series did not update the documentation all that much, which was
why you are seeing neither "git fetch" nor "git pull" documented to
perform this "opportunistic update of tracking refs".  The only
change the topic with f2690487 brought in to the Documentation was
the attached bit.

Documentation updates to both pull and fetch are very much welcomed.

Thanks.

$ git diff --stat -p 67b57a90f4 db400949b31a Documentation/
 Documentation/pull-fetch-param.txt | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 94a9d32f1d..18cffc25b8 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -68,6 +68,11 @@ Some short-cut notations are also supported.
 +
 * `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`;
   it requests fetching everything up to the given tag.
-* A parameter <ref> without a colon is equivalent to
-  <ref>: when pulling/fetching, so it merges <ref> into the current
-  branch without storing the remote branch anywhere locally
+ifndef::git-pull[]
+* A parameter <ref> without a colon fetches that ref into FETCH_HEAD,
+endif::git-pull[]
+ifdef::git-pull[]
+* A parameter <ref> without a colon merges <ref> into the current
+  branch,
+endif::git-pull[]
+  and updates the remote-tracking branches (if any).



