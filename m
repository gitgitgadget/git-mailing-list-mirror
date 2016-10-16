Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B71412098B
	for <e@80x24.org>; Sun, 16 Oct 2016 20:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757243AbcJPUOw (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 16:14:52 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35484 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757031AbcJPUOu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 16:14:50 -0400
Received: by mail-lf0-f44.google.com with SMTP id l131so207279680lfl.2
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 13:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rmx94ZuHWJT+f+ITCrEaxyS/+H2YBd8GIy8lvDlMELA=;
        b=rg1wSfX9YYEJCtLYuSh+OnsghmzDiqqppIo3UzPBqmKjhyeGmnfN46I6KymB06VuBC
         o7H8XSXlrhfRY0HccX9cr3OUwf8/1orQDrjn6cy2G0aUkSKKG2xYf22BkIaE2HMX7jn5
         n0QKBAeI34VyDsPmj96ZHh88xeHdkyXTxjvgDwjm0i0/GTOcJBtiOWsGyDBa4jHDO6E3
         Gd3biQc6nApOCzdLsUEqWYsxGkWHDX2FrXh4DghrotR+1YZBVY8+IiZz1WmROzBhllmJ
         IFVNq9uACJR20F5DS52V4XVpqpA75BwL0/N7cVRyc0+7bXWI+huDq/RL+1rtNAyeXhQt
         bi7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rmx94ZuHWJT+f+ITCrEaxyS/+H2YBd8GIy8lvDlMELA=;
        b=lGKAFL3eLk9/9r5Ia/aPmEvVOd2kWfTX2OX+4BhIliv6GaVK8EisPrn/OtsLRDzhwX
         BOzOZFVzo4RKm3T9uoXDeqg4wg3XcDX7Bw8jPiDMQra28A/YEsOgYfdzTZvaczZjaer9
         WoFhhm/zuXioiAVZtp+fZS64xyB/Vq157yAQ8tN+dyrbxVy8Iswlat6OlT63m2EI+FBO
         8iOpkYGxLPV0fJgQ5Y2Rza/PaW+6rd8FxBMtXtVLCpijYHwNjVcGnfEJ6OxC7REQXCua
         HShwW9t4xWhZrpOgRPgK72CdluJzeM95dvI6M7Tlk5FdsjBkA83FlTCL7KngcRLL/1/K
         1AXA==
X-Gm-Message-State: AA6/9RmohcwVgNRgtDYv0PBwYDkI2VuUwLOb26WCFMb4F9EtHOefPsU44FqprOjzVW4SxmsJrnYyZdFsiBtvMw==
X-Received: by 10.25.66.3 with SMTP id p3mr9662972lfa.154.1476648580602; Sun,
 16 Oct 2016 13:09:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.44.141 with HTTP; Sun, 16 Oct 2016 13:09:40 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 16 Oct 2016 22:09:40 +0200
Message-ID: <CAP8UFD3Pyyotbdpx9YePCgM8YEMMqHij8xUhiCVxCM4VN2oV7Q@mail.gmail.com>
Subject: Draft of Git Rev News edition 20
To:     git <git@vger.kernel.org>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
        Kevin Daudt <me@ikke.info>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>,
        Andrew Johnson <ajohnson388@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-20.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/186

You can also reply to this email.

I tried to cc everyone who appears in this edition but maybe I missed
some people, sorry about that.

Thomas and myself plan to publish this edition on Wednesday
October 19.

Thanks,
Christian.
