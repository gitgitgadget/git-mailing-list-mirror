Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3C9C10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 19:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED772206E6
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 19:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgCFTHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:07:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36274 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFTHC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 14:07:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id s17so2714629wrs.3
        for <git@vger.kernel.org>; Fri, 06 Mar 2020 11:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pg+g7QQ45morW1NcDOwvxIMRkisNZ+9R8hWzmwER0a4=;
        b=WgtSG0APp5VDHp1oKDH+XAaj8ngwcqon+Aq+GuPV0sdUC1KmdTngJRQtZzQY+IAOMH
         51ukQIgOfFqAh6ycm1JqSex2KXCOa6yT5Q+yQzH7mkDuE9T2igDDAgyt4L/xvaEi85PH
         pOUAlxcyASO+7Rewt/Guo4Yb+Deb8nbh5youTxG0Cq+f8QSUwtlMrRZnTjSgwG/hYM8+
         Sg0w1MlRvcdvn2m2rrIhdk7rOnzCtbVHadeAJF/VP96twmhPU01dGDqwApXweOOwjkj4
         exvdvo2MCvrA6Bhk074FtWyqtqS1k4Fstm0Dtu0JEJbQfBjHFewdXYW3VEOjsjGkFYqS
         b/Mg==
X-Gm-Message-State: ANhLgQ2inIYige6WxZcIwk3PbI7ahkXaKqXzk0v/+QQ6cmWfQRFocn+N
        rSaW6dXFJ1aWi0gLra4Ulm35RA0eT816IjmBg2M9Nw==
X-Google-Smtp-Source: ADFU+vs8cuPsErNgP+mr6uZT3XJYfvHz+rDUC6RxeopEeWVTNStQaCXjXOzdrk3c+A3FhkcRRBiFLdN1aiZHydJAXfI=
X-Received: by 2002:a05:6000:106:: with SMTP id o6mr5326400wrx.120.1583521620630;
 Fri, 06 Mar 2020 11:07:00 -0800 (PST)
MIME-Version: 1.0
References: <xmqqimjl6pvn.fsf@gitster-ct.c.googlers.com> <CACg5j262bzzwifXXC3tGu-bbNtojKQe-j1=byaAbrSNo=WtWgg@mail.gmail.com>
 <xmqqpnds5c1v.fsf@gitster-ct.c.googlers.com> <CACg5j26uLyyHRx0ouVhUbJ8P20uJgvN4WCqunP5OoXhGyxuadA@mail.gmail.com>
 <xmqqzhct2y91.fsf_-_@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhct2y91.fsf_-_@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Mar 2020 14:06:47 -0500
Message-ID: <CAPig+cStRc2hTmRBEfyaqhyx=M5nQ84rPzOEMVVLabQ2PS_Qzw@mail.gmail.com>
Subject: Re: [PATCH] update how-to-maintain-git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 6, 2020 at 12:24 PM Junio C Hamano <gitster@pobox.com> wrote:
> +   Whether it is the initial round or a subsequent round, the topic
> +   may not build even in isolation, or may break the build when
> +   merged to integration branches due to bugs.  There may already be
> +   an obvious and trivial improvements suggested on the list.  The

s/an//

> +   maintainer often adds an extra commit, with "SQUASH???" in its
> +   title, to fix things up, before publishing the integration
> +   branches to make it usable by other developers for testing.
> +   These changes are what the maintainer is not 100% committed to
> +   (trivial typofixes etc. are often squashed directly into the
> +   patches that needs fixing, without being applied as a separate

s/needs/need/

> +   "SQUASH???" commit), so that they can be removed easily as needed.
