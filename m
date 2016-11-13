Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFFAA1F40E
	for <e@80x24.org>; Sun, 13 Nov 2016 20:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934987AbcKMUzh (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Nov 2016 15:55:37 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35759 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934805AbcKMUzg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2016 15:55:36 -0500
Received: by mail-lf0-f67.google.com with SMTP id p100so5370996lfg.2
        for <git@vger.kernel.org>; Sun, 13 Nov 2016 12:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=nfjJXU/I6ubu2YT97MuC8z3mCP4KvLQ+jmIGv3lsQik=;
        b=DhqqCj9E7FmwhsZZG/YOvgAIOHH5iqT016ozfWIzocCAes3SqkMb7ml2fmJVqlpo04
         HMALUmiJ9hGnFgfF5LGcmfI1KW5L8Purrq6ZDtV1lvzDCthlw1NlT1Ef5G05e90/okxq
         3ypDwXa30NQ2/fZctrjt21jj/Sh3o1OlPcHm5+pwvZAD39XoZYCgkke1hxNvE3NbwqmK
         8CLW1Sd17Mrjk99JYzOy4QatFzwm1e6nZz1tEVAakltz7T/ocJBuF7+cFaUHkrVKw3wC
         KrjeEr7TT8ZzwOvU+kJblTg/uKpBb6eg5c9WUrTKMmPnQqYcvBbdtX8Fz5+0XrwNmXki
         MkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=nfjJXU/I6ubu2YT97MuC8z3mCP4KvLQ+jmIGv3lsQik=;
        b=SQOSGQKtdqcfELnce06D7xprWkO8s/I51Z16r35w88c9QwqmVQ8eri0wjT+QEqwNMn
         by1dMgV2crDSU3Dx9ZqJ83i4keEHmsXbXD3xJwMNE8kHMUCCoV92FbvJ1NWBXfnWsd8M
         aPq+z4r3w0Il5sG4IqAYnI7nAt6ZKhLCgVAe/rgaeBPY5Syfc39tG86/hOyiukHSbhh1
         KbvEeE0wyAYTxdDFu/BNkEGgJNMwB9Xu7viSE5ZOoAOzUm2aRMRtiOuEjoEi0XVrtWY/
         FaHI84HL9/OBsWorFbM8O69zCoJjH7+cECJZbsP2+9dq5zuQWgKCZodgIYn5nW0T5fBA
         0Nmg==
X-Gm-Message-State: ABUngvc77lHkg8CgJhljxNT/iEYCelRtU7DYE2fyXINHnz0WuEsNC/Gw8I8gcKhAyBu9j+GWuA2IcbyU0v6xMQ==
X-Received: by 10.25.170.198 with SMTP id t189mr5476427lfe.129.1479070534402;
 Sun, 13 Nov 2016 12:55:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.25.142 with HTTP; Sun, 13 Nov 2016 12:55:33 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 13 Nov 2016 21:55:33 +0100
Message-ID: <CAP8UFD3Tf_C_ASfOiC9RsMCCfhMyyCAWONP1Y4o9J2e5GcbTyg@mail.gmail.com>
Subject: Draft of Git Rev News edition 21
To:     git <git@vger.kernel.org>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Aaron Pelly <aaron@pelly.co>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alexei Lozovsky <a.lozovsky@gmail.com>,
        Martin Braun <martin@gnuradio.org>,
        Brendan Forster <brendan@github.com>,
        Parker Moore <email@byparker.com>,
        Shawn Pearce <shawn.pearce@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-=
21.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/199

You can also reply to this email.

I tried to cc everyone who appears in this edition but maybe I missed
some people, sorry about that.

Thomas, Jakub Nar=C4=99bski (who is now part of the team, welcome Jakub!)
and myself plan to publish this edition on Wednesday November 16.

Thanks,
Christian.
