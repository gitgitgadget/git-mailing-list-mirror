Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63C5D1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 16:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbeI0WUR (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 18:20:17 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:50530 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeI0WUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 18:20:16 -0400
Received: by mail-wm1-f48.google.com with SMTP id s12-v6so6473251wmc.0
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=1Nbiz6YqGWmUMJuqGGm1Nag6g+gW+k2YQBGOy2ol2jk=;
        b=UTjs923Egc5RJUq5pz/l4B1h0NKUjT48hhkfc1U1rKlR4jZ9ZDwBHdkfB2bOER+oYS
         gP0oN5b0x7T1Qv4/F9I/WAa/Ij3yqVZm9w050JZa3sTirRNZqrLXYkEeETBJs3dZPOP8
         bYRDAnfPsP0Ybhhs92TtAYzT0itYtPMfJlTMVzb1ym+Yx5nly57QjedXuaoUnIe+grvK
         Sz+kZ5BdOWq+kSVI75MGB1T0GeJUV9zHJzjmCAQgR/0v9gfLpK1Q4bwpp7WU5BpfHC4T
         xPniJWYVKbE0aAJylZ/ZSOzFRfa6yc+fGB+qYRKw76K5YQW5doU92F2MePJJkTyG6Ora
         XVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=1Nbiz6YqGWmUMJuqGGm1Nag6g+gW+k2YQBGOy2ol2jk=;
        b=PTpzxHtY2IQH6j241ZQ0tVUVKrtHZwDNHGXJtd6L5jKtmOAn2XOPIuxfIjvAk8F4+b
         ArKbo+mUKzvKWTepFfhr4RvdMYi5ui5mfINrXZm8V5XcVSJpjYzl/Uq42d4a8n/mI+pS
         Cl8AhAO5xcW+yNNOIR1dqKikSyDqx258vxhwG7VjfxcGYJrKE9U3xEqxSH0NlMEkIhEc
         Ymz1/5SyEueC3vzzptT9WNHW+AwiRbm9L7ju5LNnPoOp9RwFmHR6jHSEp4MXBTewj/ax
         IHAclrFMgoTHOIvFGsJoqCts1zETlIXZJ5BHsslCyOyVEr+rGlh95CwZ4dMqxfsZvEXI
         0oqQ==
X-Gm-Message-State: ABuFfojEiVpZcayKF7+7BCyRpDVWKrVrVl3+mjRADbv9imvIY11UekI/
        3OMT8TwIrAG/OpQdJgtQRWuA5j5TiUA=
X-Google-Smtp-Source: ACcGV60Kn+hn2uG/KH0qBXfJCboXQS5a7iAXObaBBAelzvMVPbZCSs67LfsImW54AIG8m3xMkldLHA==
X-Received: by 2002:a1c:4857:: with SMTP id v84-v6mr8016452wma.8.1538064079780;
        Thu, 27 Sep 2018 09:01:19 -0700 (PDT)
Received: from evledraar (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id x65-v6sm2730650wmg.39.2018.09.27.09.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 09:01:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git-packagers@googlegroups.com, Git List <git@vger.kernel.org>
Subject: Git for Windows for Unix?
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
Date:   Thu, 27 Sep 2018 18:01:18 +0200
Message-ID: <87va6rhqup.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had an IRC conversation with Johannes saying I didn't know Git For
Windows builds perfectly well for Linux, this just isn't advertised in
the ANNOUNCE E-Mails, so I hadn't tried.

Johannes doesn't build his own tarballs, but these are provided at:
https://github.com/git-for-windows/git/tags diffing
https://github.com/git/git/tags v.s. what Junio releases shows:

    $ diff -ru git-2.19.0 git-2.19.0.gh
    Only in git-2.19.0: configure
    Only in git-2.19.0/git-gui: version
    Only in git-2.19.0: version

So to use these you need to grab the GitHub tarball, create a "version"
file saying e.g. 2.19.0.windows.1 or whatever it is (derived from the
name of the tarball), and if applicable make your own configure script.

GFW is a "friendly fork", but a permanent one it seems. The diff between
it and 2.19.0 proper is ~10k lines, and e.g. this last release had
experimental stash/rebase in C that 2.19.0 didn't.

So it would be great if this were packaged up by linux distro as some
"alterate" package of git. I'm putting Jonathan in the "To" line because
I'm mainly interested in this for Debian, but maybe there's wider
interest at git-packagers...
