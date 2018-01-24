Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD5851F404
	for <e@80x24.org>; Wed, 24 Jan 2018 12:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933554AbeAXMPO (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 07:15:14 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:39006 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932953AbeAXMPK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 07:15:10 -0500
Received: by mail-lf0-f52.google.com with SMTP id w27so3693041lfd.6
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 04:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=NqxwVIPKuMTm8N3Sb1XGlT2peFsqnrKgcTdIoenRdJk=;
        b=cLdPDpf9Zobb+W6/nvBozlkNXIhSR2CyNnQXfXXK2nPsDqH6kYLl+DeNh1I7Zz4P2D
         bj7B34+YKdX3y36mpivCjCzfQpZXc4lX6wvsGBk559RmJ6MeZqftOhnampaq4Pp1vQk1
         q08MaMqQJHWZ5U+yjU/nkJ9R9O4cLBNjEE2t8d5FMIRkJeDFQ93ZvQynq0eU8rdMSgh1
         r/u5MK583R0dCVHAKH4yEoaGXnZMeowZtVpIE2CuBQByW1WApcTeR/zIUUXTXP023tyT
         A4M24lbCKUGwCR7j1PTXcyP3nntYyJvIoKGlzqR+UcijXlXX6rzJQ7kpKTnN0EtI3Gjo
         b5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NqxwVIPKuMTm8N3Sb1XGlT2peFsqnrKgcTdIoenRdJk=;
        b=XYWs/zotWIZAyGm6QIFiMrW/4pumI8ETpbcO9BeLjJ1vfwx6Lit4MFcP7XUiala3mk
         Or1N2swpK90tH1BLrzq8t3GyqAUYQo0lPhlOTRWM+5Pm6KJIpYasJw9492nzjgUlnlG2
         zj30ufFPxtIeAruUsqATo5WO/b8CKasggna3XqUTT/pK3qZr7QhqOl0gvG9x6Cr6Bcs5
         +UFwWGwl64rzohivKH1kdty/9nOKeXVjXeyjIkbYHut2eArEeLrMgUejlfSfK1KpPOaZ
         vjUDEYO/lpPj4fxswsmDFv30y0yx6VByYm5bskIPmNcs8ncxyP68MmjkTSLq1fWTzMtg
         AOSQ==
X-Gm-Message-State: AKwxytfO0od6tMwn4LHK0C085QYCu+hmjr5KeK6D1w0unHwQ46psB75K
        agFnSsQibcMdY/ArBVz0ME/vyGA1dgVB74wRfPWlrT95C94=
X-Google-Smtp-Source: AH8x226IAgEf29qocwZmYqUi7lL7TGJHK2gmQ13Gikz4eMei8W/h5zRSlOJR3HJM9FO3VrcmNP5FZcJYu0cNINiZREE=
X-Received: by 10.46.126.5 with SMTP id z5mr3145765ljc.43.1516796108909; Wed,
 24 Jan 2018 04:15:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.235.210 with HTTP; Wed, 24 Jan 2018 04:15:08 -0800 (PST)
From:   Edward Thomson <ethomson@edwardthomson.com>
Date:   Wed, 24 Jan 2018 12:15:08 +0000
Message-ID: <CA+WKDT0rB0XV-99bnYYH7A7=a7doL2fqFR=FOq2DFuczUb9xDw@mail.gmail.com>
Subject: [ANNOUNCE] libgit2 summit: 9 March 2018, Barcelona
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The libgit2 community is hosting the libgit2 Summit 2018 on March 9th 2018
in Barcelona.

As peff previously announced, Git Merge 2018 is happening in Barcelona on
March 8th (and the Git Contributor's Summit is planned for March 7.)  We
will follow the Git Merge event and have our summit on March 9th so that
people can attend both summits.

We ask that you please register ahead of time.

https://goo.gl/forms/3HdRBeBWixxQE3rf1

Like the Git Contributor's Summit, we will likely start with a business
update on libgit2 and the overall community.  After that, we will open the
floor for discussions and/or presentations.

We will also provide some time to provide a getting started discussion:
if you think you might want to use or contribute to libgit2, then we'll
let you know how easy it is to get started working with the library.

We also hope that we'll have some time to do some hacking.

If you're a prior contributor to libgit2, you use the library, or you think
that you might be interested, we encourage you to attend.

Looking forward to seeing you in Barcelona.

-ed
