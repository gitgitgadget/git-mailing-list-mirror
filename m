Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 389E120248
	for <e@80x24.org>; Sun, 31 Mar 2019 10:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfCaKEb (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 06:04:31 -0400
Received: from mail-it1-f179.google.com ([209.85.166.179]:38610 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfCaKEa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 06:04:30 -0400
Received: by mail-it1-f179.google.com with SMTP id f22so10577910ita.3
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 03:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bPxkEGmdxBwZNvaME6gCk1OBfzfbYxFNp91TAd0INgc=;
        b=i7HkuHgaAmjRIlHXzzST3GL1l49fTgJESn4P4D9/sjnVN3qXGDPih57jDqMRSOG4GM
         1o+IGlZhsMRZ4SG1Wes5ZvhPNLLmNRKaGLXoAmkr7PRZFSJMSG3W+OSX+u54P2rXo+zR
         L4wDKu3Q+zQEmmALDkTBLCLbxBLyB4SS+FR5eLdGZ5N83ztGqHhbjWn/7G9NBjspIdhu
         2HDrDI6dx1V/a+ZgN29t8jcoyA+MtOFM6MVQY7YB1kRkTeF602YUZhvGxFxoXw6Hyq91
         BO/ZmqfxHsXfMituMV9FyjGEHIyUvRDEud2rNte5X8Jj+M7b6X+7uWsC9V07gCQPRY81
         8hDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bPxkEGmdxBwZNvaME6gCk1OBfzfbYxFNp91TAd0INgc=;
        b=HOYYgca1PBuSxvDiDrlV+kdZRg4YxhMXl0i69QFVi0nmh4PYJST4awu5RnlaU3x2p0
         2CEW6gUi4UDpjO6Sla1PJ4RrLql+9jDc3JQj7xboB5iJNeG4EwTMzkj//mSGaXQVoqSa
         uBiLRirjxLC3nxQgG+JA97Z/rV9Lm1CIcTv+n+1PjRFP/mIh7gXPCVkxmCmhjDheomXA
         GXgC+b0Dn82czQaX7zGmZXmnFTrbNlRcVxL3bg7AxgfQUm2Zs9ldXA4uptYVU1loiH87
         HZ9yX+Vty/2LShdjsWVmDhlaA3qpgmcxKFY+OSCQox7YqgQkBeXxYLRfzACqtDeNw5q0
         yVsg==
X-Gm-Message-State: APjAAAWc0mXl9WHrYvEm4Hsj3dyfbwbM/dpbHkEw/fbm4AanPxyvw0dc
        PeZfm1Z/aocDO4Pv6JKoccTTPeGO/eUH1cVZc+ii+rTE
X-Google-Smtp-Source: APXvYqwFh21b668gk1vSf/ndxeov9pLasxlcjd2ewQusffHC4OymbEjnB/Y/TqkbxpXW8Azc24mzJk9nOHFIFxPafVc=
X-Received: by 2002:a02:1c49:: with SMTP id c70mr35338111jac.92.1554026670045;
 Sun, 31 Mar 2019 03:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAKrvxcUkLcJ782xe-ETAPNWvD-zv_KXmu0VxRPvJhOGnrChVOg@mail.gmail.com>
 <CACsJy8Dz1TLpMSRNwGtvv9kBHKJsKcses+LegfOfpz2_N3eEHg@mail.gmail.com>
In-Reply-To: <CACsJy8Dz1TLpMSRNwGtvv9kBHKJsKcses+LegfOfpz2_N3eEHg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 31 Mar 2019 17:04:03 +0700
Message-ID: <CACsJy8DmcT-2pArqtC2HGR9zBU5Mzksbcv1BcnxSAt7QoQDSsg@mail.gmail.com>
Subject: Re: Typo in the .gitignore docs?
To:     "Dr. Adam Nielsen" <info@drnielsen.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 31, 2019 at 4:54 PM Duy Nguyen <pclouds@gmail.com> wrote:
> The "does not contain" is correct, but perhaps the wording is a bit
> too easy to misunderstand. If you go back to the original version of
> this document in cedb8d5d33 (Create a new manpage for the gitignore
> format, and reference it elsewhere, 2007-06-02),
> ...
> I think the part that trips people is the 'pathname' in 'checks for a
> match against the pathname relative...'. I think the key point is
> matching the pattern against any pathname _component_ in the path
> relative to the location of .gitignore.

The desscription before cedb8d5d33 (in git-ls-files.txt) uses
_filename_ instead of pathname, which is probably clearer:

- - if it does not contain a slash '/', it is a shell glob
-   pattern and used to match against the filename without
-   leading directories.
-- 
Duy
