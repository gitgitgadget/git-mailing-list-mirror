Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FF0420281
	for <e@80x24.org>; Thu,  2 Nov 2017 18:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933431AbdKBSfw (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 14:35:52 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:47655 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbdKBSfv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 14:35:51 -0400
Received: by mail-wm0-f48.google.com with SMTP id r196so802730wmf.2
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 11:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xBgCnyUDgR6ExHZLAdLJjNkIx2bHdSizQazkg/B2a9s=;
        b=SuP4v1fvIaoKVJ7xI7RwIKfeN//i7WVdTWFCsFowbxUYQUOdBEZNjebXMKjIIR5+RF
         33GSqr85Ag+l/zibsxWTn+Kj2BQO29VXaM+hLEKS1v3pzZUpPUn1nFRR74RLBtzs0JOQ
         +4Yt9bSQPEbMH0vhvgdK70S145CrvdUndZZ8TdjQzKVmNfva6w+5sFjOgvL3xLETNEWg
         tuyGfx2JyQFJqrIbwbmOKr3YT+/lx69lZIbctDmQPwk8JaqfR85WW3473frEhKjADcbP
         iFiLgyIy0QDkjUoiGkDszldU9F69Dg95Eefu/flntdVMdhQBqeK0xGdtTtZkjEPP8HQn
         1KXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xBgCnyUDgR6ExHZLAdLJjNkIx2bHdSizQazkg/B2a9s=;
        b=tVgaX1mf4BmoBuV7b55xbvIOqRcbfAxqRQg7awmQKP3in6rAwAZj9s+LaEYitGLqlk
         fAARZedcmnV7Ht+YwoS6XcowLmffMkE1k6qgKfMV7UThITWIWysGWNaNffLiuE8bbEkL
         MxF94sCgdn4OMrBxH4QuqXwAEGbN943rL0PJuSK8PaP+gvlCVxTF9i+L1RexXHheese1
         SMTh0vv6469lYZL2+CEx0x5oXP8NQmDlYG2JpevOEb6kSMDoowGc2A0JPkRSsRORnr94
         HsmccDWvf+mPMHkDa0GmN2qKpwB24/c0CkDuaJKUqpyKL3VNBxMoHoXP79vGbE0JH98M
         gsRA==
X-Gm-Message-State: AMCzsaXNkXkfzVV1H8TcDL/0mEkxxCOZSvytevXCu0uuEzzsLyBgADSm
        XMpQxIZU/Wj1NE7u0xY6QIJhWwgCCWssLH/ordtgIw==
X-Google-Smtp-Source: ABhQp+S5nlFnjIpNiMsyl+Th8IOyk3eQQgDOySGMv3Ao6pg+zu4YcDR0vOo67v3rGFp0yOksm09SA4KUG4HmIVqZwjI=
X-Received: by 10.28.208.2 with SMTP id h2mr2256310wmg.13.1509647749993; Thu,
 02 Nov 2017 11:35:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.195.125 with HTTP; Thu, 2 Nov 2017 11:35:49 -0700 (PDT)
In-Reply-To: <CAOAxMp-vAM7mCWuanj69coM09zF-Sxe=G=-XMd_RmaAne8qFvw@mail.gmail.com>
References: <CAOAxMp-vAM7mCWuanj69coM09zF-Sxe=G=-XMd_RmaAne8qFvw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Nov 2017 11:35:49 -0700
Message-ID: <CAGZ79kaDB+nnTZVw-7msVa12RQa3sHn_zFKQ2-5i2eosuHutxQ@mail.gmail.com>
Subject: Re: Git libsecret No Unlock Dialog Issue
To:     Yaroslav Sapozhnyk <yaroslav.sapozhnik@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 2, 2017 at 9:00 AM, Yaroslav Sapozhnyk
<yaroslav.sapozhnik@gmail.com> wrote:
> When using Git on Fedora with locked password store
> credential-libsecret asks for username/password instead of displaying
> the unlock dialog.

Git as packaged by Fedora or upstream Git (which version)?

> If the store is unlocked credential helper gets the credentials from
> the store though.
>
> --
> Regards,
> Yaroslav Sapozhnyk
