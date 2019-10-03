Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4A4C1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 22:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbfJCWh1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 18:37:27 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:42635 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfJCWh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 18:37:27 -0400
Received: by mail-lj1-f169.google.com with SMTP id y23so4453837lje.9
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 15:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WgHRHo0sUJ1fGVzo+ZOA9peyAm3Fy0HP/AJ6BV1bJG4=;
        b=P2XgpN9xFDdHWHd0SeTLu5AF7Acv7UEEcS718fkFrSKPE7eaSZurspr+IEwe8DzpOh
         obRnBs06n7TMd9BcVoIpKCaCq8RCoLu6KllfHp/dJ2Ck0h9xTj4i9iQTfvOVAto3Az2F
         B1LijWN6boeVA2aqVsB9xle1elfdaEV3HkNqCOdkoGSUHj6zr+wLy6HxU/vM3R/OgBv7
         a0c8mCRy5T9hSMHR7tCn0r9/b+LafQX6gdDMMLcZAQrwc0m26g+ZYnC0E0BqnOI7jCAF
         S2vD+hljgCXLmUbAyAFZVeuMvyG77ng5YCy5Aoi0Ag4n//tQ0Zg1DWcBoXCEFlNXcYqP
         hDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WgHRHo0sUJ1fGVzo+ZOA9peyAm3Fy0HP/AJ6BV1bJG4=;
        b=svutcGa+u6kQGoK0NlNrnODIMEbiUGLp+UOzodyNqpMEcnF2aFUolZfj8IhzUlytzk
         o0tBKi8OzMAYrCHKZPjcubNBdlCXIP1kmYxhXT3MUD2ak73EdZ+fMJfYHzXLMXPHJaDQ
         /oBd9lfMFHNpo/xcnU+x64/HSFC+dwKSximuvjXw2/1MfiqGagNgUGCnJ7HOE29MusOV
         4l53hzXL9Hw50K7WjhlhtsbrwLZcC3abtVluLCMD9roaXkMY03oAESw2LzGUM+6giAUg
         m0ZGDYsXoo0UoNdVP7YLbwbW0ywN0za5sSABzbCXw3n/VuePPwhoyA1ZPgrMHJjlM1BQ
         /U1Q==
X-Gm-Message-State: APjAAAUpkYp8uhAGDvyufneUi+LGE/XOw7PgPwV1aRPQb58BWVpORxkp
        7FAIiDk3TdlPZ+YrJBByTFvlfXLSYKFv9+nC+1NzCa+3
X-Google-Smtp-Source: APXvYqyAl6RYIKGGD+yz8W5/BSfm6nI5jUGxcqOYZFDR1FpFnU8fZ4NW4Ie//fOtfvceBmTjNdwe9on9B2ePFTGcAok=
X-Received: by 2002:a2e:5dc3:: with SMTP id v64mr7694267lje.118.1570142245368;
 Thu, 03 Oct 2019 15:37:25 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Thu, 3 Oct 2019 15:37:14 -0700
Message-ID: <CA+KyZp6MKqL0mz-iCHGEcvZi09P+GmS7QEogX10-2OJ5nMPDRA@mail.gmail.com>
Subject: bad error message - Not a git repository (or any of the parent
 directories): .git
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

when running git commands outside of a git repo, we often see:

fatal: Not a git repository (or any of the parent directories): .git

such a lame message lol.
can we get an absolute path on this message in future git versions, eg:

Not a git repository (or any of the parent directories): /home/ubuntu/xyz/.git

ty

-alex

-- 
Alexander D. Mills
New cell phone # (415)730-1805
alexander.d.mills@gmail.com

www.linkedin.com/pub/alexander-mills/b/7a5/418/
