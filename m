Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ED231F855
	for <e@80x24.org>; Fri, 29 Jul 2016 22:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbcG2W4V (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 18:56:21 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36010 "EHLO
	mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbcG2W4T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 18:56:19 -0400
Received: by mail-qt0-f195.google.com with SMTP id u25so5276179qtb.3
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 15:56:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5WcaIA/3PxlEICE94wMhlwOlJrXMVb7d+ihjHDfc/Nk=;
        b=o/yLKd0hIrwLzxMsHmcW87NJIRtN8Fj04s9I5f9junNn9rDZQ6mjbJVk54fQsM+Nt1
         z93yIA4exa6FHnSSm0a+saGV1WRZ166VOihm2YhWc5wHQuHqBX2CcqBb1fcrnBXI8D+h
         sV4Y23VbruOAnXynJZjPQ2H+ceQrKOpUAeq1/WhBQs9LcX6PGFPzHTqsY0AqLkWE9ysd
         qpcBlGNbIteykHShy+05ORnm/9rIcyfg/wAB+B2D/VUcfdfJ1ayZIKzeQX6pcHUlQ9VJ
         KxAPk1foPTzcgQoat/n51eerQuaJMaD6UjkFsnIjEiOdCtaY23XQPHNuAwKhQVySz3/t
         aV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5WcaIA/3PxlEICE94wMhlwOlJrXMVb7d+ihjHDfc/Nk=;
        b=MmF6VzRPyQ4ATthUhWGyOWpmenHEBOA5FK9/SXpgyc+kOf473SLEln8X3cV0BKFrR6
         62q9+i4DRa9CjNwfUWyynfBZLtSE0cgZGYAJCzVHLGeaJumvmZ6ppeKsEYdM1/YHlFGj
         TOAzTT0p2WtSHndsZiHUXSGtNbS/MmDSHECokMBOskMs1ljBATQlD9XibLieW/guf9Yr
         ZFKZ0I82rdPC6BEtM9SrRjYLTT3m7IXGhc4sdP8fMPZOflhCturz9TtarDTp5zSmJLZF
         v9SeGDutyJFZh1DCbpQrHBVanF2+K+l6xAy5JJl3+bRq/fO25qfuKmm53/Btk/6+Py73
         CBiw==
X-Gm-Message-State: AEkoouuBIBFF6UBNw1hTBnSGr73HIHCvjzvrkZ3zvVIUwnrZS5DG6Zp91VhS94nYpY+Y4zE6Og5h5hS+VqIp/w==
X-Received: by 10.200.57.108 with SMTP id t41mr69528311qtb.33.1469832978703;
 Fri, 29 Jul 2016 15:56:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.36.77 with HTTP; Fri, 29 Jul 2016 15:55:59 -0700 (PDT)
From:	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:	Sat, 30 Jul 2016 00:55:59 +0200
Message-ID: <CACBZZX5gzu5TRzsd3o6uYfe_uNCqY2jwUUEzpxJg0zH1G-qgSw@mail.gmail.com>
Subject: Does anything document --date=tea/yesterday/noon/midnight/never/now etc.?
To:	Git <git@vger.kernel.org>
Cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	ohannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

These were originally added by Linus back in v0.99.9-230-ga8aca41, a
bit was added to them since then. See
https://github.com/git/git/blob/v2.9.2/date.c#L927

The v0.99.9-214-g3c07b1d commit also has some info on the warty edge
cases these have to deal with.

I was checking what documented "git commit --amend --date=now", but
Documentation/date-formats.txt only mentions ISO/RFC formats.

I thought I'd just submit a trivial patch to document this but a)
maybe it's in some mysterious part of the docs I've missed b) after
reading v0.99.9-214-g3c07b1d and some of the date.c code it looks like
it won't be that trivial to describe this.
