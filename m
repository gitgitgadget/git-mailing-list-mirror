Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A40D1F576
	for <e@80x24.org>; Tue,  6 Feb 2018 09:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbeBFJlr (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 04:41:47 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35748 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeBFJlp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 04:41:45 -0500
Received: by mail-lf0-f48.google.com with SMTP id a204so1792131lfa.2
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 01:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oEJus/EUYTERC/TUvdXM1WH3CIYs9eFMh2n+KKtNL8g=;
        b=rdsaSjp1uPlbt6NFfPWYZmVPKRrdV3b/uoB8hacampVFIjIq+taeoUZOZqHZCU+5nd
         wW0UWCtoY9IXP4M+LUYDwEW4c/hwjjaFMj3flrT9Gxob+p9Y4eXfjOMhtsD05Ki/gRIR
         hZkDi9cBG36+42OQtoZ3aYR8ScOFcKXg4jE7Pl+TOipriWYMWAj6gBpjHLmFXnwDmeRv
         9zHP+eSSE9bljWaA/MAGAYKd14iNvuuU5R/UB5OxM+BtRigo3oCb9gkq0XIMW63jHpRL
         8Q7mB7qfXZl5Tdbqc7B3Qtrqt8SAQ5micAJ1xCFA8wnPDHgneMX83VZLTICdAFW2Rzdq
         oldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oEJus/EUYTERC/TUvdXM1WH3CIYs9eFMh2n+KKtNL8g=;
        b=FVpZVEnKQBVuMfRKKOL47WbINUZA20qQErvTnfCXBCKi2SrtWZpT9eUWFsVE0q1AxO
         0XoP9L3xdio33vZxyhd7+qCQ0gKqSohB1p4o/xf74ENx11m3zfBEivCfL3o5meZJuVQ9
         T+TCKjoRrwQSwQebxxEFDoyG2+mkJE/rck6A4sf/aQQT1KegWSkpVQhy45irZ9L10EhW
         0UkBCwz5VVeNJC6NERXuk1fh8LNw1j+0GVuRbLG2dvCkdnwvLei8DBLN6A4un6aW2F1Y
         TZF3zQ0zaDKo3hU7Mbfi/Fk2cmhEQZf8ftPr+F+oNTvisu52clUCiyJiK6HFIob9LCsM
         ZStQ==
X-Gm-Message-State: APf1xPCyIvYdHXi03PmnujgGtqXXhm5PwyExLct+n0GhicilpPXV7T6D
        KXxG+jIwrV0AEu2x90inieKcBYOjaQ1f28G6pllMzQ==
X-Google-Smtp-Source: AH8x224q9fBhCwEqMi6E2OrmNOPSgjKnt3R2ZdDXLT4fnv5Wqe7KAgoeEK2ywd+8Rmo/k4uTQcwF6mvkLPBlsCwNqFA=
X-Received: by 10.46.5.210 with SMTP id 201mr1271722ljf.34.1517910103136; Tue,
 06 Feb 2018 01:41:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.181.210 with HTTP; Tue, 6 Feb 2018 01:41:42 -0800 (PST)
From:   Zsolt SZALAI <zs.szalai@gmail.com>
Date:   Tue, 6 Feb 2018 10:41:42 +0100
Message-ID: <CAOKXNqBSqEP7aikjM1GE=p7jWBsN13Xy3qVL-on7RnrUrwi+bg@mail.gmail.com>
Subject: repository history?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I wonder if there is a feature with which the history of the
repository can be listed?
i am interested in especially the usecases of pull and push, i.e. to
query when the a branch was refreshed with remote changes and which
commits were pulled, things like that.
Is this possible?

Thanks,
Zsolt
