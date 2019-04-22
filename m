Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6985520374
	for <e@80x24.org>; Mon, 22 Apr 2019 00:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfDVAgX (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 20:36:23 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:37261 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfDVAgX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 20:36:23 -0400
Received: by mail-io1-f46.google.com with SMTP id a23so4632615iot.4
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 17:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jybQj0IAjx13qriIBUooJ4FFhY80nxSLfFXnvn058e4=;
        b=hnEWjJwlshrst1VRaxV4qb7l+mTslDHZC6MGreqF4gZgAmVr21XmSrEtFr3nWu4r2N
         VJWABsp2o0XA56E7gxD1mUrmJ7ja5wUkbBw4ALNb9xm0YmG5yC5Z8DeB4ZRUn7vv6UJs
         DsyFzVtMOh5xWNEuemLBbzu3OG+aI741dT24l455RK0QTxjWHHfXxpoX8AjNqSISlAvg
         iz9Ioy2BPo+gTQ0cMA4ZV+SYxXLo2kT999ZmrNWb8KLWkP0gIweEiMuocVdfzBkm07vJ
         6nIYz/7ToHdnnJ8xYmf1n9MpkNQ5jYkIq2Xv8GHD+UXaNIBD11qcYhxYnTDGyjdmGqI+
         GNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jybQj0IAjx13qriIBUooJ4FFhY80nxSLfFXnvn058e4=;
        b=sxe6A5kpiTl8eySr3sfe2tDgnIyt52NMGv9+IXU8J6w/1z7Aq1KqnMEJREo6o4e5UT
         /hMCvb2ejLal6GFt6jglX4pTLxr6PH0gHZbre7kHnDTsmqikjrsmMgdrrZVXJpE5DyVQ
         ZQIv5HRESbS/wo1mAgyzYvp/KGMXVFGtHfJsu1V+RttOMtkrGbgIxkd+Zz5G8W6DQdDR
         LSiyqmBv/VWpgWMnLG6KntoJTlYc2ydhzvJUcTCb/aLnjEhPi1YNMQxf4bOdfJNWUVXa
         2OlfGuMXyMGAktKV1pNJFCsBaFLphUk7LdXtuuIEZqe2yJS21WWZQd/cz6fYD2S2I5W1
         Kxzw==
X-Gm-Message-State: APjAAAV8EY8VFWDBrgW0jEfUGMrixA8UwryPbrqIbHCr3am9Zt91yUiw
        tlksQZD1MBSjiSyKyGXcgIZU3GazYZ+qbRaRCzSE2A==
X-Google-Smtp-Source: APXvYqyEBAFWKjCA+s/q4BlNKpq2Zb9T3uRLeo4MxJNMDPTn5Be+ZvH2cSt5NzXtaX/4rkUq9/turjtB32gAsG+Opmw=
X-Received: by 2002:a05:6602:58:: with SMTP id z24mr2031907ioz.118.1555893382528;
 Sun, 21 Apr 2019 17:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <d001a2b5-57c3-1eb3-70fd-679919bb2eb6@apjanke.net>
In-Reply-To: <d001a2b5-57c3-1eb3-70fd-679919bb2eb6@apjanke.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 22 Apr 2019 07:35:56 +0700
Message-ID: <CACsJy8C1w0zJm71KFb21MC+c2NAGnRLDtE3KNK21hO7U4Ax7Hg@mail.gmail.com>
Subject: Re: gettext, multiple Preferred languages, and English
To:     Andrew Janke <floss@apjanke.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 21, 2019 at 6:40 PM Andrew Janke <floss@apjanke.net> wrote:
>
> Hi, Git folks,
>
> This is a follow-up to https://marc.info/?l=git&m=154757938429747&w=2.

This says the problem with "en" detection has been fixed. Would
upgrading gettext fix it?

You would need to upgrade something (git or gettext) and if it's
already fixed in gettext I don't see why we need a workaround in git.

> With the current git 2.21.0, some users, including myself, are still
> having problems with git selecting the "wrong" language for localization.
>
> This happens on macOS in the situation where:
> * The user has multiple Preferred languages defined in Language & Region
> system preferences
> * English is set as the Primary language
> * Another language, for which git has a .po translation file defined, is
> set as another Preferred language, for example, Spanish
> * Environment variable $LANG is unset
> * git was built with gettext support enabled
>
> In this situation, when git is run, it will use the translations from
> the secondary Preferred language instead of displaying messages in
> English, the Primary language.
>
> I've seen this situation with other gettext-enabled applications before.
> I believe what's happening is that when selecting the language to use,
> gettext goes through the Preferred languages in order, looking for a .po
> translation file for each. It does not find one for English, but it does
> find one for Spanish, so it uses that, instead of falling back to the
> non-translated message strings.
>
> Some examples of this happening in the wild:
> -
> https://stackoverflow.com/questions/55145901/force-git-to-use-the-default-system-language/55160216
> - https://github.com/Homebrew/homebrew-core/issues/37331
> - https://github.com/Homebrew/homebrew-core/issues/31980
>
> I think an easy fix for this would be to add an "en.po" translation
> file, so that when gettext does its translation selection, it finds that
> first for when English is the Primary language (or a Preferred language
> earlier in the order than other languages), and uses it. This .po file
> would be an "identity" translation where the translated strings are all
> just the same as the original strings. I don't think it would even have
> to be actively maintained, because for new message strings that aren't
> included in the .po file, it would fall back to the non-translated input
> strings, which are in English anyway, which is the desired behavior.
>
> This would be a convenience for git users, because it would "just work"
> without any modifications to the configure/build process, or requiring
> users to force a $LANG setting.
>
> Would you consider adding this?
>
> I've put together a patch that does this:
> https://github.com/apjanke/git/tree/english-dummy-translation
> https://github.com/apjanke/git/commit/7e6704167018e1d47399af04230521927991811b
> Not attaching a patch because it's kind of a large file. I have tested
> it locally and it fixes the language selection problem for me. I'm not
> sure if the appropriate thing to do is make a PR for this to the
> git-l10n/git-po GitHub repo or not.
>
> Cheers,
> Andrew Janke



-- 
Duy
