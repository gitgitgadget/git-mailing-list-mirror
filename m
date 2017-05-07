Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A93DA20137
	for <e@80x24.org>; Sun,  7 May 2017 21:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756111AbdEGV6s (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 17:58:48 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36941 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756100AbdEGV6q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 17:58:46 -0400
Received: by mail-wm0-f45.google.com with SMTP id m123so46345600wma.0
        for <git@vger.kernel.org>; Sun, 07 May 2017 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TNCXgFRwX3YGHZ1I0F5fC1P7YI5WZvS5qbxrMDS3V7c=;
        b=L+noUzzCYQwkgqcC8qWUZeU7UZkPvRmee+LAeVeOs14iq3URW1PQ/VdoiMzKrmyANK
         tKf/8A2WV+yNjqG9CO+jC6Q3Nv0MzwBcxOVR6dsckX/jS8lSbt9vJk8JLE0o13JMkGli
         2yqRauC0fuqOwyBO/QXfsllkAs1OrvutSmtiNjqRRcWLZ0JkVqMcDmV/JSu4NKhJ+fC7
         jhiRWdrxN3SSD/dIM+Ix7KdhDTpFkZtAXeYRV/Fgdzy/OMpOuxgULfNj7DUDNlTX6YS2
         AajFfEfQPpV89EMl6valkPi93IWPCuM5cDalad7Bs+fPvtl3rh7lJhzWHJd0FfcIX0ZV
         2K0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TNCXgFRwX3YGHZ1I0F5fC1P7YI5WZvS5qbxrMDS3V7c=;
        b=YJ0aia2XRIYJnPxsz+cWkxEzzGDvQmGwcL61BYv6dwMyZKcBEsMldAMlv/mh9xecXI
         1p8ixEaO/QAclzYSiLQ0ngi3CJ37PDvgEGNkTWBRPj3XGSZBa5Ob5BO9SAQza7NbYBcx
         vLpDsED+kXU/wllMUuPAQcxDXCyznDd6lYfaF4YJSAdrSdKYbdvWookF2Em1MkEyLCWY
         it0TcRslkzZCu+yK82F2EtUsPaZUYnVKYC0ABZRzzHOA1BHZyJlXWWzFQyeLUvked0fr
         xXpHjGi0S4CHz8eoKZysYtXaPMqjiUOf+HN6d0R3FpYTOLE2L+dxhqOZ6fmQ+cug/Qai
         cwZA==
X-Gm-Message-State: AN3rC/6/xqF2QdALuBLmPRm6FjCIz2im0vC+IqNlm3BoVDrgrvU0YUl+
        UmtCaHmClXiXfEcc/bkVSr1BRJlatA==
X-Received: by 10.28.234.24 with SMTP id i24mr11581715wmh.55.1494190562564;
 Sun, 07 May 2017 13:56:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.100.196 with HTTP; Sun, 7 May 2017 13:55:41 -0700 (PDT)
In-Reply-To: <20170419064916.18663-1-giuseppe.bilotta@gmail.com>
References: <20170419064916.18663-1-giuseppe.bilotta@gmail.com>
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Sun, 7 May 2017 22:55:41 +0200
Message-ID: <CAOxFTczgB05mS0A50ESdgk_4AMCpx1Odrdz4PKr3bkuwRFNHPw@mail.gmail.com>
Subject: Re: [PATCH 0/2] gitweb: tags feeds
To:     Git ML <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ping?

On Wed, Apr 19, 2017 at 8:49 AM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> A smallish patchset to implement RSS and Atom feeds to complement the
> tags view, accessible as verbs `tags_rss` and `tags_atom`.
>
> (I actually made this some 5 years ago, and it has been running on
> http://git.oblomov.eu/ since, but for some reason I forgot to submit
> it for upstreaming.)
>
> The patchset is also available in the git repository at:
>
>   git://git.oblomov.eu/git gitweb-tags-feed
>
> ------------------------------------------------------------------------
>
> Giuseppe Bilotta (2):
>   gitweb: infrastructure for tags feed
>   gitweb: expose tags feed in appropriate places
>
>  gitweb/gitweb.perl | 126 ++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 91 insertions(+), 35 deletions(-)
>
> --
> 2.12.2.822.g5451c77231
>



-- 
Giuseppe "Oblomov" Bilotta
