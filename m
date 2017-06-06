Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA2A4209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 14:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbdFFOJF (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 10:09:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34084 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbdFFOI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 10:08:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id w69so24509390pfk.1
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 07:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=ubGWczAY+0S2/ibQM6TXRgLcJKf0FSbLbvJmHDA4fa8=;
        b=IbuPhBm5gepM4i432zsstAcBxbDJKRkg4yR/lyFmBolsap0Pa+m1VCX3awnbql47gH
         hfsYwTrABKKxGX4IrhBAn8Wtic9J0AhMEiT4BpyFt+Prwk0+pqsU6B9GKTaoOs+Q4xRa
         MnjTjytSgojfp5Rquijz+5nvFruvSfvtneS/GKwd63JvmZb7cGfJr+MPlhK5MO/1o6Bj
         OwF5TvMpUfvtmU2xNowS2iNeiW0ibMEyBZ7/XuXgpCHOFeP95xmsxxyPs7RFATwHyvDB
         3sYdm762uSg3qDfZ+9dYS0qFMx2RoBoSYo1ZvxrciRfpL1UMkNK3/6UZaucSYYEdBMpC
         vEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=ubGWczAY+0S2/ibQM6TXRgLcJKf0FSbLbvJmHDA4fa8=;
        b=pLqwUGy59NeGUwQXDQVpIhBtoK60og/YGL1LQtFip/v4wpbI+qplLZJRuhajYNeSPJ
         122RU6WA6lIFe0YbleUNaDFDSvlCazdMUqmljGLCfreUFtEw9967740YYVPYwPe95p0o
         DYa2Spw2VpC6vX2EBZprH2ld2CF2agtVVUgRT3dsC8+mrGKXX1MkB/OySBz8q43v3urV
         spaHy+IjPGh9r6Ujv7IDTmZgJOC6PeXSvT26xJR+csVLa5ssmm8OyZc0VYSqqrAGi3QK
         ktOQ/xAVPVqWPY9i4AdLqbDJcK2rEWoiUuWsBlA5VvBUtj6JKIGfK5BgAm242B9xhPD6
         Wd1A==
X-Gm-Message-State: AODbwcDohkSlBl2fuTzc26p+NqkYyVxnkLGyAEyFMFpWzOH23wr731Cn
        c+sZIwK8lh068Q==
X-Received: by 10.98.149.21 with SMTP id p21mr5600516pfd.37.1496758106320;
        Tue, 06 Jun 2017 07:08:26 -0700 (PDT)
Received: from unique-pc ([182.73.79.179])
        by smtp.googlemail.com with ESMTPSA id b72sm61235917pfd.118.2017.06.06.07.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Jun 2017 07:08:25 -0700 (PDT)
Message-ID: <1496758102.6664.2.camel@gmail.com>
Subject: Re: What does this output of git supposed to mean ?
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Cc:     David <bouncingcats@gmail.com>, Samuel Lijin <sxlijin@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Date:   Tue, 06 Jun 2017 19:38:22 +0530
In-Reply-To: <xmqqr2yx8h9v.fsf@gitster.mtv.corp.google.com>
References: <1496671452.4809.2.camel@gmail.com>
         <20170605231058.pgb4fgfb4z45bzmk@genre.crustytoothpaste.net>
         <CAGZ79kYp6GepJxZjaXhosX=vCh0vwa57+zFHK2gHFociiyTnDg@mail.gmail.com>
         <xmqqd1ai9bhf.fsf@gitster.mtv.corp.google.com>
         <20170606011151.qe5ycih77vqlqgme@genre.crustytoothpaste.net>
         <CAJZjrdWoK__rZVCG3vRSSEOPgxK7b_wWjpJ3YUQcLxw+J8KfGQ@mail.gmail.com>
         <xmqqvao9991r.fsf@gitster.mtv.corp.google.com>
         <CAMPXz=oorE7MQa4a_1eC-+Huf1Tf2XQFjEBcQxsOdso9BJ1S-A@mail.gmail.com>
         <D0E8FF50F1E74043AA0BD71E80C365E5@PhilipOakley>
         <xmqqr2yx8h9v.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-06-06 at 20:52 +0900, Junio C Hamano wrote:
> "Waiting for the initial commit", or "No commits yet", can be
> explained to describe the state of the current branch (not the state
> of the repository), and it is correct that we do not have any commit
> on the branch, and the branch is waiting for the initial commit.
> 
Looks descriptive to me too. Just for the note, I wouldn't have asked
this question if `git status` showed a message like this.

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
