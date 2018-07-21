Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EB3B1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 19:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeGUU3a (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 16:29:30 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:38239 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeGUU33 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 16:29:29 -0400
Received: by mail-lj1-f182.google.com with SMTP id p6-v6so13722493ljc.5
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 12:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=z2SdpSYz3bmjLou7OYfupGiY6F8D51lzXELLYyd79BI=;
        b=mmThFnY4s5CMuJp3V9NMvjYbne9PgwE8YpeL0C9sZH8s65KTxmMVvsxxda2BYTnr1F
         wiUmntJJYhjwzYzj1rBKQG+rrsjzKSOrEA4ZXHN3O957Y9bV83rsj4PDbylYslBMC3oY
         kq0c7/rGED64xoLIlMTv9HmB2wU87+hMu+vvcXk43bgHuyxmiC8iQawPg88DYm/OsFVE
         IM6lrmjdaMGWQU0WAlzzYJLdv/tu8XHkzbNqGDFEI0dsjY6KVNc9MwldTiWklsNPFAdK
         mxdxoz/S46OtrdSSju/vnmc1OFauexf86p/h4nwvBjZAJyzLu+6TeC865u+bPQZffNPq
         Yauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=z2SdpSYz3bmjLou7OYfupGiY6F8D51lzXELLYyd79BI=;
        b=ZhFIn8lgUSrCVRCywTI/+clEbSxk086/UM4PJC2yqC3JA9UlIMnrvj9mPwIL+NpVvO
         Okk4SOBFgylP5hQ1O8RkIs0rNY2jW5bDaF/sbxxz1bJrFVWNDGiVcz4T8nNXm6a7NaRo
         uInaXMoMuFuDyAS22br/SsavqenfasRWKwpuKBmuAQM6CGB8AHuU2olVHqTAXTgiuBSN
         UV9mcSnTbm/3tYvnSsGnNF87OWAe18rW4Exf69ZSF8l1FR3pswIWbsZjAN5buJTBfop2
         cT2FEMwO0r87A18Z4QHEYEByfLUYTjpFZNfTqIdqf21nuj3spqTwXmyi8YCbIoXWylic
         KyCQ==
X-Gm-Message-State: AOUpUlH9PwhawydLmspV9D0DB7RJygT4lIZ8c1M49NH1vyISqRngC5ba
        HrBG0gOvWi8/fP2kho4YyhlAje2LEQUsQfWKIGPPJtSp
X-Google-Smtp-Source: AAOMgpe2ut8LN9WeCP+rOHqYjLTadrA5PDBI0AiaQFHbRHOOfQRMchkuU1hrqWhNhmfWbPWSQNo1Qt+NdlbmxJbPiNA=
X-Received: by 2002:a2e:4103:: with SMTP id o3-v6mr4651823lja.3.1532201736742;
 Sat, 21 Jul 2018 12:35:36 -0700 (PDT)
MIME-Version: 1.0
From:   Jonas Fonseca <jonas.fonseca@gmail.com>
Date:   Sat, 21 Jul 2018 15:35:24 -0400
Message-ID: <CAFuPQ1LtE2OgsfUOff=a_RDA0Q7B7Xk91kyAEWMnG2EW0TNRuw@mail.gmail.com>
Subject: [ANNOUNCE] tig-2.4.0
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm pleased to announce Tig version 2.4.0 with improvements to UTF-8
handling and compatibility with Git as well as a ton of bug fixes,

What is Tig?
------------

Tig is an ncurses-based text-mode interface for git. It functions mainly
as a Git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various Git
commands.

 - Homepage: https://jonas.github.io/tig/
 - Manual: https://jonas.github.io/tig/doc/manual.html
 - Tarballs: https://github.com/jonas/tig/releases
 - Gitter: https://gitter.im/jonas/tig
 - Q&A: https://stackoverflow.com/questions/tagged/tig

Release notes
-------------

Improvements:

 - Add 'send-child-enter' option to control interaction with child
   views. (#791)
 - Update make config defaults for Cygwin to ncurses6. (#792)
 - Build against netbsd-curses. (#789)
 - Change the blame view to render more like `git blame`. (#812)
 - Improve worktree and submodule support. (#459, #781, #783)
 - Support running Tig via a Git alias. (#763)
 - Use ISO-8601 letters for short relative dates. (#759, #760)
 - Change date formatting to show time zones by default. (#428, #811)
 - Use utf8proc to handle Unicode characters. (#827)

Bug fixes:

 - Fix `file(1)` argument on Linux used for resolving encodings. (#788)
 - Fix underflow in the file search. (#800, #801)
 - Fix line numbers in grep view when scrolled. (#813)
 - Pass command line args through to the stage view. (#569, #823)
 - Fix resource leak. (#780)
 - Fix various compiler warnings and pointer arithmetic. (#799, #803)
 - Workaround potential null pointer dereferences. (#824)
 - Bind to single and double quotes by using the *<SingleQuote>* and
   *<DoubleQuote>* key mappings. (#821)
 - Make Tig the process-group leader and clean child processes. (#828,
   #837)
 - Fix sh compatibility in `contrib/tig-pick`. (#832)
 - Fix incorrect behaviour of up and down keys in diff view when opened
   from diff preview. (#802, #835)
 - Open the stage view when maximizing a split diff view of (un)staged
   changes.  (#836)
 - Use fully qualified reference name for tags when conflicting with
   branch name. (#746, #787, #849)
 - Fix resize not working after entering command. (#845) (#846)
 - Use stack allocated memory to handle TIG_LS_REMOTE. (#839)
 - Fix deleted file mode line remains highlighted after hovering in diff
   or stage view. (#851)
 - Fix `TIG_LS_REMOTE` not working with git-ls-remote(1). (#853, #854)

Thanks to everyone who contributed (in alphabetical order): Bj=C3=B6rn
Andersson, Brtwrst, Diego Pomares, Jonas Fonseca, Leo Arias, Maksim
Odnoletkov, Max Odnoletkov, PaulChanHK, Pavel Roskin, Roland Walker,
Ronan Jouchet, Thomas Koutcher, hwangcc23, plgruener, rofl0r

--=20
Jonas Fonseca
