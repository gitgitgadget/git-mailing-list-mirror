Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D2F11F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 14:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJIVvG (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 17:51:06 -0400
Received: from mail-yb1-f170.google.com ([209.85.219.170]:46303 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIVvG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 17:51:06 -0400
Received: by mail-yb1-f170.google.com with SMTP id o8-v6so704439ybk.13
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 07:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=8loq67AmhPItLSL6WSprKUlOls+NBYZU2g5/P+E6dLo=;
        b=vH+VGcyYgkMLa1d8348P68sKWZcttCyqfrtfS0daELdsdD6peHCU91fTFDy/PEsTOc
         irVt59eLzPBR7p+t7ED3XcAaFEnoRoX7VJYAvgRl/SOeq5kUhjcwCquXTxQKXhP+IwwL
         7jatj5K2PFkNCDP53tK5HsPI0AnugoBV4y5pxBNvl2Os5pQYXax5Dyt1d3giRCZpyj0E
         ZD86pbFZeHJk7PH/tqG2wHkchPckCeeyFzaAke4gGfSVcSkFQYtzkLl3GsjezDXij2vN
         pxqCCIywV0EL5Ncw5P315/rnBbDZ+43LojWeudGQuBvnBGE4fiHkMLJ5SJV9PaM/asMv
         yOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=8loq67AmhPItLSL6WSprKUlOls+NBYZU2g5/P+E6dLo=;
        b=EddbpwGqg9ybk0zYNVbC49RFJYejmkLTFxIdHxFuck+WqHCl8IzHnrNDS7Ni+Aigk9
         Ghgrsh83UZ0VCnuuGTj35Mn25ruj9Q238JWxC5adUPKX6t7v7DMKs8a5gMIwYbr4lI5t
         HD18D02q4rDV8Yc0NEg3W7P+FxmJhcmAxK0m7mMXTFhc04pWCgbv92d0pYR6mnybwFys
         uTkD2PvuuRiUeyP6eXdOZljVy0Sj1RttKvN9MPTGH+/vli2sIPNmRBrgg9hQAPoZaIqV
         PdJYBle82g0a4UJ5FU1ucYDG38G0qU+GeV7uzhq8uatPMGZn94tQBHR0j+6igLjYMED9
         sjgQ==
X-Gm-Message-State: ABuFfohILXv4aE8tqdbAQAvNkh73KheDKio1QlekHmS28JkJQxtVUeKX
        fGm9RhfRKJUz6p3ulsUMZcCbNTPNVJXJ3nC2lhi/FUV5
X-Google-Smtp-Source: ACcGV60cJKD8JrzlmVfkRld9TWgKocz/1iWHyf5XoWD5V6iYOLz8fycT+3r55ZJB+u/wTMUd4FUq+p8K+8rPVU9eDbA=
X-Received: by 2002:a25:ba13:: with SMTP id t19-v6mr15660058ybg.473.1539095631642;
 Tue, 09 Oct 2018 07:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHMHMxUDN4xKD9GfmOEx1bW1jDeWUgYgg_xdAtvLrFgMV2oCLQ@mail.gmail.com>
In-Reply-To: <CAHMHMxUDN4xKD9GfmOEx1bW1jDeWUgYgg_xdAtvLrFgMV2oCLQ@mail.gmail.com>
From:   =?UTF-8?B?zp3PhM6tzr3PhM6/z4IgzqPPhM6xz43Pgc6/z4I=?= 
        <stdedos@gmail.com>
Date:   Tue, 9 Oct 2018 17:33:15 +0300
Message-ID: <CAHMHMxWutm=jWC2nLJCEEE4CZ-ERc79vvwrbo8VnfC0VGwei0Q@mail.gmail.com>
Subject: Fwd: git difftool does not give the --cached option
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have install the latest git version from the PPA:
$ git --version
git version 2.19.1
$ lsb_release -rd
Description: Ubuntu 16.04.5 LTS
Release: 16.04

However, trying to autocomplete git difftool --cached gives:
$ env -i bash --rcfile /etc/profile
$ . /usr/share/bash-completion/completions/git
$ git difftool --
--dir-diff          --extcmd=           --gui               --no-...
         --no-prompt         --symlinks          --tool-help
--tool=             --trust-exit-code

Please direct me on what would require more attention.
/usr/share/bash-completion/completions/git is the same as the
git@master/contrib/completion/git-completion.bash and e.g. here:
https://github.com/git/git/commit/6cc4bc15f92e85b41d9da9075905f20c6a9008fe#diff-f37c4f4a898819f0ca4b5ff69e81d4d9

It seems that --cached exists.

(Side question: What is the "--no-..." option shown? I cannot seem to
find it anywhere in the documentation :/)

Ntentos Stavros
