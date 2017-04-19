Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E519D207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 06:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760149AbdDSGFW (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 02:05:22 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:32831 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753634AbdDSGFV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 02:05:21 -0400
Received: by mail-vk0-f49.google.com with SMTP id j127so7083395vkh.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 23:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6+5pD11tncVMGgOLjixRaF7fgL0eavhorPZiBvTKa1w=;
        b=IPx/l3pE9aFjw1IXTe8tz+cu4qjbZMxpMZIRCAsenyOGy+4LGpcFWMeX7m47xZNiEn
         oqY1yH6ahIdtEhedeh89j5yD2H9kovvM2V4+NF1Sby+qTer814SuirXYMatBjOpPhYuM
         M2oH/BlzKN/O/i5Kv5i5NeMqgVkfM2lattr78auOQw5uMnPMyfLNbISKnm0MT21SL7Zc
         r32vEoQfWt+MmB8r+CLudukb7pxHkhHm2SK0Hhfw87Lfp7HU4wBpUS76BAK0i0VvbhbY
         SzBT9O42Ip8f4/MhKfRApJkaJ6txCOCZBXYvrIN9nBg07/OP2PIRT6bklj7Q1bahUSla
         yDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6+5pD11tncVMGgOLjixRaF7fgL0eavhorPZiBvTKa1w=;
        b=eYix6OxJqMVVdu51xP23o93QWcxvBZ01iM7+utPRrqW6PKmmS/nytQCMrGhMcLJKkb
         2OcqC3XDvpDJyvj/zBg24fp+YC05YuAfTTKjqhWyC0XaQi8xB4tvO+DD7ZemWkVs5vYY
         fS75EUU1x4/WysvsO8dya5fJMy+ZIJyLfLwr3smi/sXJNPTRCalMG9jZwpoV1ZPSINxM
         ZQfiXdl466Z3x/dQqQkpe10eV2xtCIUHsak/nFvwfBnsE+54xsrEwSyDMr7yqQQlTpuP
         JLghDLiPTuR5JJMe0O9DuIyuqFkhsx1lB7vCxagG3xiJmjdh+MTsLg4zeyokg/FDpxKW
         /EbQ==
X-Gm-Message-State: AN3rC/5HSHZxWdTKDAB4JwuwNRz8P7JtUUh8LGgyA2KgPNqOeCjRXwDe
        8GuE6k1wpGWz8j/oW9meKC5NkaIYnNes
X-Received: by 10.31.32.144 with SMTP id g138mr352141vkg.21.1492581919912;
 Tue, 18 Apr 2017 23:05:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.6.105 with HTTP; Tue, 18 Apr 2017 23:04:39 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 19 Apr 2017 01:04:39 -0500
Message-ID: <CAJZjrdWNQFkWwAO_hmHMzVGNNMfynxsvbWufGvRWX8bZD19Epw@mail.gmail.com>
Subject: [bug?] docs in Documentation/technical/ do not seem to be distributed
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's possible this may have nothing to do with the Git project itself
because I have absolutely no idea how this is handled on the packaging
side or, possibly, if this is actually intended.

There are a couple of links floating around in the man pages pointing
to pages in technical/, such as to technical/api-credentials.html in
gitcredentials(7) [1]. On the website and man pages for Arch Linux and
Ubuntu, this link is broken.

On the website, nothing in technical/ seems to be linked to at all.
(If it is, I didn't spend enough time searching.)

On Arch (git v2.12.2), this link points at
/usr/share/doc/git-doc/technical/api-credentials.html; however, this
file does not exist:

$ ls /usr/share/doc/git-doc
git-subtree.html

On Ubuntu 16.04 LTS (git v2.11.0 from the git-core PPA), this link
points at /usr/share/doc/git/html/technical/api-credentials.html;
however, this file does not exist:

$ ls /usr/share/doc/git/
changelog.Debian.gz
changelog.gz
contrib
copyright
NEWS.Debian.gz
README.Debian
README.emacs
README.md
README.source
RelNotes

[1] https://github.com/git/git/blob/v2.12.2/Documentation/gitcredentials.txt#L184
