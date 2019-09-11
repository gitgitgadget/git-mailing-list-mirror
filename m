Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6E511F463
	for <e@80x24.org>; Wed, 11 Sep 2019 13:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfIKNAd (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 09:00:33 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:43423 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfIKNAd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 09:00:33 -0400
Received: by mail-io1-f48.google.com with SMTP id r8so20575759iol.10
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rug-nl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=4sGhKB7EWIPvfE5g7nuCFxYLT10LE1vZwL6KUkrWK08=;
        b=1a0fHLPWOO1AxvPEfBNfRgpVdep9zoN1GLWr17rHOer9fJuxuT78edmBUWR3fAN8Ar
         pDXG9Uxi/UIsqWCRMajdIyAMUmaWi6Hp/hKpMZdr+FtwFqrypAHXkwOgAeKncNqh/YaZ
         fhSvWGNzkkxHnvt/S0tfn3Z3H+ff+SMA3bQ8lJi3imasdT3Vtfq5/cmYP7vsfGLtpDlD
         096Q5+xRCgJFHK6iahBlvQmid34oMKSodptamdjRbCo0VDr5h8Pl5CjqWpqUKx8edz1m
         LKawndj4PsLN8zPGOeDIRGl/UYrPpcrJetV3d+RSZj7zMC76fsoR1AH9WYjp0u0WYDQf
         BlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4sGhKB7EWIPvfE5g7nuCFxYLT10LE1vZwL6KUkrWK08=;
        b=sECItTXJVvQBIf11Q4CXaFLg5V8Xg4wh9jn/j7C1uwE0iU0wp52j8nRHZ3Pb7CuGM/
         md3UDDM+sVBydTUhycLcgei98ySmC+dCN6q5X5brAKdrasIhJ/Fa9r4y4/NGdkQ6KGoo
         FttkhEmRT2l+UZtwrF8mJRqCgTeumwWU6dHLmYGT4pWBOvs219UHxf8J6Ju659QPk6zi
         aoF0UHiyUNnH+W0kneDCkBRE73CS5AqDnm2qvhLyiDxb9jtOjF/G9kmCGnKARjo4u8Iq
         QNhkaBNBzTYaVOANF77MYJMYpxnPdoKAluMI+uM8Mn5MxNld2WNjGPn7CzUOPiBKDWE8
         wMKQ==
X-Gm-Message-State: APjAAAVQpIQQ0Oagu487x0sfsLJ16QXXht1MWcBpXWV27JGU98TUIB6H
        bSiLhHbRvUy5GQp/vls0u7VQZVFlxIfFknkbqBEi9OmmVvnfkA==
X-Google-Smtp-Source: APXvYqzcgJf3as1ps8lQYgpqskKbmfpZPG3j6oYmlCyPcnEMdsVmQBmGhY8rKUIE7gg30qKGQOhtRNQh85HfwbIsryM=
X-Received: by 2002:a6b:1606:: with SMTP id 6mr32775046iow.108.1568206832697;
 Wed, 11 Sep 2019 06:00:32 -0700 (PDT)
MIME-Version: 1.0
From:   "Castro Alvarez, Sebastian" <s.castro.alvarez@rug.nl>
Date:   Wed, 11 Sep 2019 15:00:22 +0200
Message-ID: <CAMr8YN58q94bnBkdfxrBR-Vw5Mk4akHzn4c1k2HjMQCXKWdWsA@mail.gmail.com>
Subject: could not fork child process rebasing required
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git team,

I have recently updated my computer to W10. So, I reinstalled the
newest version of Git, and it is not working. It gives the following
error:

Error: Could not fork child process: Resource temporarily unavailable (-1).
DLL rebasing may be required; see 'rebaseall / rebase --help'.

I tried reinstalling git, it is still not working. I have googled how
to solve it. But none of the solutions out there have been effective.
Some of them were like give permission to git in windows defender,
others said that there was some incompatibility between git and
cygwin... but I don't have cygwin in my computer... and so on. Nothing
works.

Now I have installed git 2.23.0 and the specifications of my computer are these:
OS: W10 enterprise
Processor: core i3-4160T CPU 3.10GHz
RAM: 8 GB
System: 64-bit OS, x64-based processor

Can you please help me in any way to solve this?

best regards,
Sebastian Castro Alvarez
