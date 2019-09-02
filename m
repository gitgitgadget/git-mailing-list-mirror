Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ECA41F461
	for <e@80x24.org>; Mon,  2 Sep 2019 12:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbfIBMGH (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 08:06:07 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:37137 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731195AbfIBMGH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 08:06:07 -0400
Received: by mail-vs1-f54.google.com with SMTP id q9so2938519vsl.4
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 05:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fs65fbc//Qb6M8TVWmk5wkNmaN7iUOpronudKKlbuRk=;
        b=IZu2Ktz5By4dnxWRRW6VM9ATCX7/MK9viFNFu4+jk3S3K4ENssegsG83xdDsiCYYAN
         umCG0O0ZJy2Xxtq3tRWUmo1JCn2+lPNDYSgLkTnQQ/JBP+0OA7fxNBrvfQGD09B8sLRT
         AYKyGsIApP3m8JwTg8gKbH2elUfgKTMRTKCDV9Ovue98SVPNoYO/37DJw2c8BYdk9WMQ
         0m+VIqMt1xwml5uSxe3Ls8CbmStRECIJAH5nq4htgMcSQymFrq3et+HFUXfdNxNBaJyn
         bE82ZumACB6bKsGNpwa8JnZY1f4Rw1fG7QJxU2yHzZHK5WDeE3gCNV7miP5634epUZIY
         f6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fs65fbc//Qb6M8TVWmk5wkNmaN7iUOpronudKKlbuRk=;
        b=gSoDbfkJW4okUsBsOzGOWom/jDZ0iQ6MVbpngmPezb92yZZ9LMrOjM12UeC0PTFOeZ
         qkvEOoS+hzxuz/CafvzIbrzyCVjc+CxQeOvrkwIXpVUtXCam/3mG+tBw6uVLD35XtVp9
         9hQEry0tchSiHUnqX6KIM04tDca7au0uKhYQ6HNY/OuFDfvTJQk+tRzPxt8vgGfNM6op
         8zUAs8r/cDlj/lU+JJ4xftzGxd20u1iEwpnG3xCwaXVj9TCGDsCEdL59HHe8ualw/nCX
         24XOrxy3U88qNOoeQEFv16yIXzEmyq2ELyhs153hLW36pdrQF5tV/7a46ArV2jnSE/Eh
         8ebA==
X-Gm-Message-State: APjAAAVgPZoU5pWg1kJ99TI7+YHKRpUbZlh605gjvFPLoDMnpIZ0L0y1
        vHiL7Ml66G2Tqurk+DhG8N4NTYwX4o9n7YSFTyA=
X-Google-Smtp-Source: APXvYqyGWg1/JjhMpDVdfYcqX7J3AB/jTRY2/pzjo7eAslh11z09FT5SLcDV+huDV5HMwk0pRInS2u505MKziAS7xJU=
X-Received: by 2002:a67:e45:: with SMTP id 66mr15670796vso.197.1567425966343;
 Mon, 02 Sep 2019 05:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=+ThYVyZUiU1wnt0yL+MzF1RXvHnbwo9NWyh95cLyhNRQ@mail.gmail.com>
In-Reply-To: <CAGr--=+ThYVyZUiU1wnt0yL+MzF1RXvHnbwo9NWyh95cLyhNRQ@mail.gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Mon, 2 Sep 2019 14:05:55 +0200
Message-ID: <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com>
Subject: Re: git-gui: Long lines in commit message gets hidden, no scrollbar appears
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Birger,

On Mon, Sep 2, 2019 at 11:13 AM Birger Skogeng Pedersen
<birger.sp@gmail.com> wrote:
>
> Hi,
>
> I just noticed that long lines in the commit message widget does in
> fact not show a horizontal scrollbar.
> So if a line in the commit message is more than 75 characters, it gets
> a bit confusing.
> Should it not have a scrollbar?
> Example shown here: https://i.imgur.com/I3d6nBJ.png

the old reasoning was, that you should not create commit messages
which are too wide. While I can follow this reasoning, hiding content
is also not a good idea. Thus I tried a different aproach. Instead of
not showing the content, I pop up a dialog, if the commit message
contains too long lines and add you requested scrollbar.

As I'm currently unable to send patches per mail, I pushed it to GitHub:

https://github.com/bertwesarg/git-gui/tree/bw/commit-scrollbuffer

And I will paste the scrollbuffer commit below.

Best,
Bert

Author: Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Mon Sep 2 13:57:24 2019 +0200

    git-gui: add horizontal scrollbar to commit buffer

    Sugestted-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
    Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

diff --git a/git-gui.sh b/git-gui.sh
index a491085..919d1e9 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3363,14 +3363,20 @@ ttext $ui_comm -background white -foreground black \
        -relief sunken \
        -width $repo_config(gui.commitmsgwidth) -height 9 -wrap none \
        -font font_diff \
-       -yscrollcommand {.vpane.lower.commarea.buffer.frame.sby set}
+       -yscrollcommand {.vpane.lower.commarea.buffer.frame.sby set} \
+       -xscrollcommand {.vpane.lower.commarea.buffer.sbx set}
 ${NS}::scrollbar .vpane.lower.commarea.buffer.frame.sby \
+       -orient vertical \
        -command [list $ui_comm yview]
+${NS}::scrollbar .vpane.lower.commarea.buffer.sbx \
+       -orient horizontal \
+       -command [list $ui_comm xview]

 pack .vpane.lower.commarea.buffer.frame.sby -side right -fill y
 pack $ui_comm -side left -fill y
+pack .vpane.lower.commarea.buffer.sbx -side bottom -fill x
 pack .vpane.lower.commarea.buffer.header -side top -fill x
-pack .vpane.lower.commarea.buffer.frame -side left -fill y
+pack .vpane.lower.commarea.buffer.frame -side top -fill x
 pack .vpane.lower.commarea.buffer -side left -fill y

 # -- Commit Message Buffer Context Menu
