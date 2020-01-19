Return-Path: <SRS0=wBnH=3I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B30C32771
	for <git@archiver.kernel.org>; Sun, 19 Jan 2020 01:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDA220679
	for <git@archiver.kernel.org>; Sun, 19 Jan 2020 01:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgASBlP convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 18 Jan 2020 20:41:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50900 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgASBlP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 20:41:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so10992405wmb.0
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 17:41:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fNueihrkzLW6edqdoNXErnDqw1UremxvzM1aeVvv3kY=;
        b=bMLRHCJLScvjCbzmXSKLoxTpe0nd79zodTBPTOXGgB/NKK6DoQMdkP15P10h1ph2ie
         kSu9jzzQhcHSvvUygVxjXgzRv94eFEt8tb3t53/v2QTbQJyvankjaNtLjRIykflazjB4
         CIK4dLXknHn3LjQ0OE1yqI9vdAOXEElVGtiU0Tt+g0k6e97Y7xJMFviUuzUyq0M2zmok
         pe83M+/Mc0ocg3f8R28iedgYAyLk00bNZhTNu7hGnZ5ry2Wkbc2wKiAJIcgGpvsJukyf
         qI5LQFeVNGJnIkoPje72G9SF6UhHvlFSCmh+I5tZ0khVhSuHtQTuYlw8PpKE4bjUeIrb
         esKw==
X-Gm-Message-State: APjAAAXaT+psAIY60kdpcEt59GYFkjIdwXroKVk9HQT700V9yi51KAfd
        vNVXoNpQn+tE6sEEmvP9t77Rhui7eo2IKqVccamrIA==
X-Google-Smtp-Source: APXvYqzkFlTpwf5L1oe5C+9QYmauaCiVBYcDmbMs//riK7yYQL8iJHTgEEZRXHDqwZ1LjsAQ5bFto6kvO77GXY+zQBs=
X-Received: by 2002:a05:600c:21c6:: with SMTP id x6mr12059246wmj.177.1579398073743;
 Sat, 18 Jan 2020 17:41:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.523.git.1579263809.gitgitgadget@gmail.com>
 <6e0e664026757315a337dead8079167f4fb29c4b.1579263809.git.gitgitgadget@gmail.com>
 <CAPig+cR82mrG=eiOMtyd3sAAqRRL2FD_VG2+W_j15uhWyx30gA@mail.gmail.com> <6C3CA640-EA4F-4D24-BCE3-FCEBB818026C@gmail.com>
In-Reply-To: <6C3CA640-EA4F-4D24-BCE3-FCEBB818026C@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 18 Jan 2020 20:41:02 -0500
Message-ID: <CAPig+cR_51+yWwvkyZFDAcmM3yV_vrtV-AoBqk2CBrmAo0r-AQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] t2405: clarify test descriptions and simplify test
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 18, 2020 at 7:21 PM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
> > Le 17 janv. 2020 à 08:56, Eric Sunshine <sunshine@sunshineco.com> a écrit :
> > The unanswered questions which popped into my head when reading the
> > "While at it..." include:
> > [...]
> I can explain more this reasoning in the commit message if necessary.

Yes, please.
