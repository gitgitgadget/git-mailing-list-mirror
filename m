Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C863320899
	for <e@80x24.org>; Mon,  7 Aug 2017 11:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753125AbdHGLJg (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 07:09:36 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35806 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752918AbdHGLJf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 07:09:35 -0400
Received: by mail-wm0-f49.google.com with SMTP id m85so4388607wma.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 04:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Q64idla6Uy4ygIvprhk8t53mtRhyuWKAe75CaZEAOsQ=;
        b=hPTtS2bgU2FIPQM91r8+xrugpO1OmykMoHINegJ2/WoUpnI70SU6MRDasre6XCVydP
         dhIKbUwoUXyrdWiarGw81GBJ6eqW5dWdA0gIMGg9xCo8m9kEoHWun5w+zLC6xRmj219Y
         laopYTcMakgJdzH5NCQHfFJMJ++e8fBNr8+4kHjXL3DKoN0SiS9WSXoq6CvzZSxeAOzl
         ywidZ9tfDKY0HVYMcxmhGlPGAAqbZj2tTVIu4z8UesyT7D6pbM6cIF0ONWan0eLibTGI
         g25ux8XqUpUSZLbK8vUdiY43JkuORBllPb/v27k/b6lo8myqQjoh/fkcyGUVJt3V99w7
         6JFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Q64idla6Uy4ygIvprhk8t53mtRhyuWKAe75CaZEAOsQ=;
        b=Z1oyuUfmJL0FKqJoMj/kSe+JM1DTYjowQ5hY7Si8Me8WcZ79tdsiqfbiiokWGtaQtz
         fbNTGN3GNfGcexWVBI5yjmomc+wVGmL8AYXXN9nRy28Sya07YeNBqwZNRBxPLbYlw3nI
         G1MNJdIKAGeNEJ6LBfT4uJxwi/OnVxL5He7+4DiloQeO+uQgu+vutWtPvTPuLBdCfamR
         W9Pxt6JZ/cZ/wL1o6BveDLTCWnu7bYBNL4wRgPaQ31FHVBJjVnnHHx70cMDZhrXZYiV5
         3/3SZRH5sGBfEA3Qk+bcZB/b22K1Dmy7WgfWZXvtj3ySjhIbpn19LWpY0vDUKDBhRoP9
         /OVw==
X-Gm-Message-State: AHYfb5hPHJeutlFL20YckpG12H7gx+eoZpBLCrtnOpd4rw4kqxnaX71l
        gkYdsaJbb/W9SIsoAFI=
X-Received: by 10.80.218.3 with SMTP id z3mr590334edj.228.1502104174278;
        Mon, 07 Aug 2017 04:09:34 -0700 (PDT)
Received: from snth (157-157-140-194.dsl.dynamic.simnet.is. [157.157.140.194])
        by smtp.gmail.com with ESMTPSA id j16sm6939787eda.46.2017.08.07.04.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Aug 2017 04:09:33 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1defue-0005po-Em; Mon, 07 Aug 2017 13:09:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     James Wells <james.wells@statseeker.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: upgarding GIT
References: <9a2576ed8b7146459585af4238613286@statseeker.com>
User-agent: Debian GNU/Linux 8.9 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <9a2576ed8b7146459585af4238613286@statseeker.com>
Date:   Mon, 07 Aug 2017 13:09:32 +0200
Message-ID: <871sonzlar.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 07 2017, James Wells jotted:

> Hi All
>
> I am fairly new to git, however I have a challenge of upgrading git from 2.0.4 to 2.4.12 and my initial 2.0.4 install was done via TAR BALL on my server.
>
> I have a centos server running git and Atlassian STASH and my challenge is for me to upgrade the STASH application I need to move to a newer version of git.
>
> How do I go about upgrading git from TAR BALL installs , is there an easy way as I would prefer not to have to create a new server and migrate everything across , I would like to perform the upgrade on the current local server if it is at all possible.
>
> Any assistance is most welcome and I would appreciate your feedback or comments on how you would go about achieving this task.
>
> Thanks
> J

This is really a question of "hey I ran 'make install' on this thing in
the past, how do I now upgrade it?". There's nothing git-specific about
this, git doesn't do anything special that 99% of the software you run
on CentOS wouldn't do in this scenario.

I'm not saying this to be an unhelpful smartass, but just to point out
that to look for a solution you don't need to search for e.g. "how to
replace git package" on Google, but just how to replace manually
installed packages in general.

You're going to want to install git via RPM/yum. CentOS already has a
package for it.

It may fail because of existing files, you can likely force it or
manually remove the files first.

Be careful not to end up with directories which contain some
Frankensteinian combination of old tar.gz installed files & newly
installed files. You can use RPM to list what package owns given files,
you should manually remove e.g. some git-whatever command that's not
managed by rpm living alongside your newly installed stuff.
