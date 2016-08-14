Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECA691FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 17:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbcHNRPD (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 13:15:03 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38182 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbcHNRPC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 13:15:02 -0400
Received: by mail-wm0-f45.google.com with SMTP id o80so64778617wme.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 10:15:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gbyml1AySDhFaaXAoVb+eOGpncDmw+g+VGKO63jV9s8=;
        b=Qe8ZMkx7urjbGba9jom+051sqEoV+7nlc1tkWoJeN+Vx1o6CAG4jZW5ccqsNvkBuOh
         yNCrRvPIhbJvijbPz4t+Az2QalcapXlXQFrlu6YWLT19kXZFxEQN0++bR4EnNvDkeYGe
         DexCxjfd613TBR3ZmFCbqwrw+BdWAHqWfrzotEeeRpykdKZFplW0uN/xckJKZDO52udK
         tkcGvn4O43ZsYZreQL/I0Axx+byUnq+T2M/ZZTbB8KJrkXkCBU5uMYamHT9eiX0MbaYI
         oe+l92XuiJ0xVSFCu5M5FmtdWmqA7Up/k6RLnFnVIkvxkkyD5v73rFTNWz59rH9r4bKT
         iC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gbyml1AySDhFaaXAoVb+eOGpncDmw+g+VGKO63jV9s8=;
        b=hvTZkxbiPVgSzfyiFu7lkbm2/NXC9aCOP3x0P8VVqMeB+sQm2YNoTUoIr5bPsuz22H
         ODRyhPtfBUU/B7DzGdOET4+t/jcvdVb/rETlBxJWy+SuuPmyaCTbjp/MvIQ3CwCWb6mG
         5F2WqKkaHykAnUwvcEsmvJXv9doPY6z6rgQwKSNK9LHY1MQjmvxCNFeciqvRBptEDnOP
         +by+4aH1zPbp0nVEaWM2AruFDLGXP1UbXAC9xEisS2NHepa5WvmR4MZrayIR7aBE8SOx
         P1V2bT1bSEWyi4OO9QgRrYxCEANWxBLeqF/h+jz5IBPYegiCNekmA56klyNdYQd0tnSG
         RIRA==
X-Gm-Message-State: AEkooutLr3j50GWgHPe4bVxTyJt0tM4YQWNn7znoLv78DSeLOfcVaFKymvAgc7irvw+lhVlh1hsOn4LJ3YHg4Q==
X-Received: by 10.28.153.202 with SMTP id b193mr10443474wme.62.1471194901364;
 Sun, 14 Aug 2016 10:15:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Sun, 14 Aug 2016 10:15:00 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
Date:	Sun, 14 Aug 2016 19:15:00 +0200
Message-ID: <CAP8UFD1iveotLsMOBnpa=hU4ohcQjZ-X7tjnzY4k+xz5KJvqBw@mail.gmail.com>
Subject: Draft of Git Rev News edition 18
To:	git <git@vger.kernel.org>
Cc:	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <durden@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-18.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/170

You can also reply to this email.

I tried to cc everyone who appears in this edition but maybe I missed
some people, sorry about that.

Thomas, Nicola and myself plan to publish this edition on Wednesday
August 17. Sorry for the late draft again.

Thanks,
Christian.
