Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF50320A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeLJSrM (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:47:12 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:40205 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeLJSrM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:47:12 -0500
Received: by mail-ed1-f49.google.com with SMTP id d3so10382808edx.7
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9Wjy9Z2uTWwaVMkD5i1lHOZnb7NFoejckZlaC0+ByuQ=;
        b=mfA4N2rn2gqfAGOEUSxRIVY52KYz6pM8yQmdLTQHRqfokIz80jNmHzDmGKSJWiD1h+
         2Y5aPYG8pJWFyStDDw34Xh4aX7BET48jpLldMOz1jZIIaLuTA7VT/EXo56IUE0toIjEs
         B+t6hR/pBLX/laeXos5dRMmrrRK3NKOBAunCgnuaxQYlceAlMjlglaBEMPVjGtHZ4bGH
         S2IW3+0KlQ86idwhVa18OA+JCC6EnCwccOK71fVw+OC+VCpIfSyorj4JkHnzdEyim+pQ
         lGryJV6dreRaAWs2qgnryjAmhfVw2WdVtU3THVy4QBnItvM7tQAoLudx4wsmqg8Ooxli
         NcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Wjy9Z2uTWwaVMkD5i1lHOZnb7NFoejckZlaC0+ByuQ=;
        b=AU/Li8Vzaw5GpidXycj590pmoOZmlbdztw1jPTov/kUyak4dMwAVf1dKTFEL1oHUYl
         zE+xoP/RLeIJoDHAI2u1kDNcKNC9M25k7vH99aHkvX2K/jVddx6jMbNGHPUnDjtl80kP
         OqRFGEWgXwzw5+kzhcAbQiz+6vq0UW3PnqoH3F0x5NsE/DEYENXdCSqznQ2XRWy6M52e
         6RE0bFhuAMryygpzhjXHrR5y+FIv9F3yxl4gMYR4BO7UbUt6MhcS+Mtu9MpHBOC+c1Fp
         p9n8KV1HM0YRvVZXSTVXaA3eK+1NBvzAM5eWjXeuPKTfhcPfBPJh079YCDG+AnFYND0Y
         +Kiw==
X-Gm-Message-State: AA+aEWbzH9z8O0MshISj62p7vcWMHUMVKVDwwHtqPGd2Ga7Q3X077U3k
        ojGJ1zXA3oeodLCNu5Sc5hZBSV6GJYEIDbT0CjH/5A==
X-Google-Smtp-Source: AFSGD/W+d0vGr2iav3Y8+8J1HjFoFSiaCzaNeXYe7feWSS4qIqxrtNdN1KqO0GuOxdITD6cTnceFJWDlpoxtLhSBFTc=
X-Received: by 2002:a50:bac6:: with SMTP id x64mr12708705ede.191.1544467630169;
 Mon, 10 Dec 2018 10:47:10 -0800 (PST)
MIME-Version: 1.0
References: <20181209102521.5301-1-pclouds@gmail.com>
In-Reply-To: <20181209102521.5301-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Dec 2018 10:46:59 -0800
Message-ID: <CAGZ79kZpcgRFs=2NgaYHUAfRQ16u-LG7CjEJJg4+=oxUQ6Bbnw@mail.gmail.com>
Subject: Re: [PATCH] style: the opening '{' of a function is in a separate line
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 9, 2018 at 2:25 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <p=
clouds@gmail.com> wrote:
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  bisect.c                   | 3 ++-
>  builtin/config.c           | 3 ++-
>  builtin/push.c             | 4 +++-
>  convert.c                  | 3 ++-
>  credential-cache--daemon.c | 3 ++-
>  diff.c                     | 6 ++++--
>  git.c                      | 3 ++-
>  imap-send.c                | 3 ++-
>  remote-curl.c              | 3 ++-
>  sequencer.c                | 6 ++++--
>  string-list.c              | 3 ++-
>  t/helper/test-sigchain.c   | 3 ++-
>  transport-helper.c         | 3 ++-
>  url.c                      | 3 ++-
>  userdiff.c                 | 3 ++-
>  15 files changed, 35 insertions(+), 17 deletions(-)

Can you say more about how you found these?
(Are these all of them, or did you look through some subset of files?)
Or did you use a formatting tool?
