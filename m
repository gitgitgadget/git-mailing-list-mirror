Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C64561F45F
	for <e@80x24.org>; Sun,  5 May 2019 19:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfEETnN (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 15:43:13 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:41259 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEETnN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 15:43:13 -0400
Received: by mail-io1-f42.google.com with SMTP id a17so1215176iot.8
        for <git@vger.kernel.org>; Sun, 05 May 2019 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=r1XqctzI+fAY0MSHWDVrILFNt1qUscFjD2JplG4zZWo=;
        b=imcJpfnUJTkVgHt8TY0dh0BtL/Jg3hhBAFBeksfPM9aFc3K82xPdDskYhVvRdhjxIM
         V917EVEnhmUSQW1RW4vKBX3q5BQiUw0taBkhF9CePmCNeOfL9QMNyPU+7GY3NM5VhSYm
         DbBSaRHivfvc9kM0VR+2fP9dRWwCEF5wHxrYgGG9Jg70E4aWR/BfvgGEgYLmhcXqSxbH
         aM2xrzhwMs0czkAK31V0kqepBsxnD1O8SVyz7Hhatgin37HzfPOo0+nQlIgrr5PYLk8s
         kx//cGeOazxYkpHMZMKYRdTOb+5C6ZjObKCQjLxNLYXICqbQ9dqfqV6f9sqPJc1bMU/K
         fE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=r1XqctzI+fAY0MSHWDVrILFNt1qUscFjD2JplG4zZWo=;
        b=DlnjBSIFbNtmsIIFXnKxZlAl3erCF5Gu4pXxUVEaoe7IOPmUlNJTl9zqEHOUT8yMfv
         NPoEs94W6COqBJVyU0UU0YpHB/I3KjW6Ls8edOtlP0qjKPpGEgaBOfiqp2NuvJGF1jQm
         7Cl4KnXFymTbTNsOFeLsh/lcppIIKyUfodvRJwvQIqXIkndMoOerYa5EgvnqdH+Ouim0
         upbQSzyZaZEHYJExXcgjzR4jDUz2Cr0BXmWdZed1pqA3CTW6/egteMmluyNgXASeVhym
         GDfOqGPBBLwK4NmKwguCWoKNFUA5Nvtk4swmQFVN8SPPXXGImgM2Ka4y05gM9rmBMrb+
         6PtA==
X-Gm-Message-State: APjAAAW7ToYoAQzjfCv0qaizPwns6qjOxlzdfARfG6dTLk/J3vZkdQUa
        UDRyGF3o2jPUenRdu0O0DHUOM9HS0yKI1xisaKui9/yY
X-Google-Smtp-Source: APXvYqznWxiGnX5qnalJVzB9Lt2czPTp2kcvgBGJyFfO7kiHTTg+DAjjwhpjrAhtaAvQiy3P5oe3UBuaz/SEFB5JD2k=
X-Received: by 2002:a5d:8357:: with SMTP id q23mr524431ior.10.1557085392260;
 Sun, 05 May 2019 12:43:12 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sun, 5 May 2019 15:42:45 -0400
Message-ID: <CAH8yC8nTyq5Fjc-6fUNn1iwkCO9i1Vrc0vFqxEVg4Eor3h-0Lw@mail.gmail.com>
Subject: Git build on antique PowerMac
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I have a PowerMac I use for testing. It provides several testing
differentiators, like OS X 10.5, Bash 3.2, GCC 4.0.1, Apple cc-tools
linker, and big-endian PowerPC. (I think Gentoo provides a Linux image
for the hardware, but I don't use it).

The Git libraries and programs build fine out of the box. They also
seem to work as expected once installed.

The pain point is the self self tests, which I have never been able to
build (or execute). I'd like to close this gap.

make -C templates  SHELL_PATH='/bin/sh' PERL_PATH='/usr/bin/perl'
: no custom templates yet
make -C t/ all
rm -f -r 'test-results'
readline() on unopened filehandle       test_must_fail
run_sub_test_lib_test  at check-non-portable-shell.pl line 34.
Modification of a read-only value attempted at
check-non-portable-shell.pl line 34.
make[1]: *** [test-lint-shell-syntax] Error 255

Does anyone want to take a shot at this antique system? I can provide
SSH access with root.

Jeff
