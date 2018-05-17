Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E0AD1F406
	for <e@80x24.org>; Thu, 17 May 2018 14:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeEQObl (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 10:31:41 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:45929 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbeEQObk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 10:31:40 -0400
Received: by mail-lf0-f52.google.com with SMTP id w202-v6so9059811lff.12
        for <git@vger.kernel.org>; Thu, 17 May 2018 07:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hhAm6CErk6i7GMD1e91J8MEozshySFlTKv1Q4sASuTM=;
        b=gTKepWIcr6EBZnIkkTtBFg6AUxyPvNT+L4zBhDWKzfTlRpIBIDMsLl7Q1SQVkTkUco
         TAoagYtuGS6P4TAQ7lYQiUiwObq7AOZfHft1KPdq1QAF3MTTx/7n2kDAI6o3rR4p7rpl
         7sY0gAj5BCEdfgDdUb/+XF/1OGLNLkExytx9sk1/pupVh2O421CM0HakUIuh6rUQl65e
         CXWU91KCVaKzuBHuylWz8uU1Ea9SmYdV/LW89oyxqYA8uTdw2y/Li/P7ZTTJj8elt/gF
         g4M+tojPcZY6wW2mZsJtJvEftuVMLB30N224DBzQzfGNWiqSDu3C9hr1MTRRN4RvbsQY
         z5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hhAm6CErk6i7GMD1e91J8MEozshySFlTKv1Q4sASuTM=;
        b=ijSdhJrbWmm145J/pCO5fY8yceUvVhRb9hyvElhacgvcGVRJZiybiZTu71RueISej0
         lMLEoVZHCTsQgyFyHjPJ0RWfZPZzFsL4V+gVIicnDT5ZgakXBCHh6OU9t3jhTLCn9Siz
         zW+9THUoRkyB4r20VHlkH/nCH+R13z1Lu0IqHIBNksDugbzABENXcM9+HuSfvmIorrm0
         v+p/OBzHEkHN1fIBUSKEt4RSfeAF2nL9GUH+mQkDzq0DvFIzbIZHUOlxvxcWZKaLDoen
         zskYyXt0UXXQB1AlNSZC+9zgQECNbOHZYMN0NucXdy1ZHkHTnTkbog/lJDAdDuvf1BlD
         EvBQ==
X-Gm-Message-State: ALKqPwdW+w6Bc5Rwr+lNByKOSFgb9BNL640KpN5L4DvBGjjeU5oOrsKJ
        yODk2Ajk9UuxchFiB6EWgItqoLLGPv1i1CHoE1WWfg==
X-Google-Smtp-Source: AB8JxZpEN/UKDHL6d6SzbBT91a++caahMdEjdY5MT4AuRU3gJ3W/N2lpHHtdLxv5L4zXjbrnBHr4NSxelED/tG5NjII=
X-Received: by 2002:a19:1444:: with SMTP id k65-v6mr19058158lfi.80.1526567499139;
 Thu, 17 May 2018 07:31:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:1247:0:0:0:0:0 with HTTP; Thu, 17 May 2018 07:31:38
 -0700 (PDT)
From:   Bartosz Konikiewicz <izdwuut@gmail.com>
Date:   Thu, 17 May 2018 16:31:38 +0200
Message-ID: <CAAdU=LtfkKOKnJJC9yvxG+dZxqUh-Pwa5=ra1DOTfxQSY3e6qg@mail.gmail.com>
Subject: Troubles with picking an editor during Git update
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there!

I had an issue with Git installer for Windows while trying to update
my instance of the software. My previous version was "git version
2.15.1.windows.2", while my operating system prompted me to upgrade to
"2.17.0". The installer asked me to "choose the default editor for
Git". One of these options was Notepad++ - my editor of choice. Vim
was selected by default and I've picked Notepad++ from a drop-down
list. As soon as I did it, a "next" button greyed out. When I moved
back to the previous step and then forward to the editor choice, the
"Notepad++" option was still highlighted, and the "next" button wasn't
greyed out anymore - it was active and I was able to press it and
continue installation.

Steps to reproduce:

1. Have Notepad++ 6.6.9 installed on Windows 10 64-bit 10.0.17134 Build 17134.
2. Use an installer for version 2.17.0 to upgrade from version 2.15.1.
3. On an editor selection screen, choose Notepad++ instead of Vim. You
should be unable to continue installation because of the "next" button
being disabled.
4. Press "prev".
5. Press "next". Notepad++ should be still highlighted, and the "next"
button should be active, allowing to continue installation.

I find it to be a crafty trick to make me use Vim. I have considered
it for a good moment.
