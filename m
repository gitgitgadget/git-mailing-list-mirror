Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25AF220437
	for <e@80x24.org>; Mon, 16 Oct 2017 18:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754279AbdJPS2U (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 14:28:20 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44275 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbdJPS2T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 14:28:19 -0400
Received: by mail-wr0-f194.google.com with SMTP id l24so3853916wre.1
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 11:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=79zk8BADREpZHMQHfWRz32pIKLxn7Wzf/n78BottDv4=;
        b=Jb6dfTDsgUMNsZHnpUArYqxqAjBSIXCTVwF0AY+jmZDghg6BDpTggURIhzhZBJBigS
         ynBVhDxH3Vduut3v312kuFfYSkDpNg4GQhavs1lpgeTVeZYUAojL6ZFTJ+3eplp3SRwv
         8ER8BLneUNN8PEp+Mlz4dzywWkp3GwrID/twwetZjizA+apNsDnOT/NBdKBS4x3O3rYl
         NIV39lt2/iRAdd2t7C6jvc+ww3Sej1s6j24hZG8vHVC14vyRlnN6Bj2/wAZQqzFVl4LR
         wAD1/cKDiKLjcd6r+VJU9jLey/vzlk29PQz/gVFqmpjJDCcTkWV2X6pozYxg0ljef0vx
         uwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=79zk8BADREpZHMQHfWRz32pIKLxn7Wzf/n78BottDv4=;
        b=EjbPNain4WVl5q9+TD794Po7Z4Ze7l360cptT1WOT6QNJ/ihTFZBRSfN4/NtL9UG+Z
         VQXeZl7FoPWRBcJdj1GYKoBHHI8bdx1Y3UNYZJpfoQ0fEm+qC5bFb8TXCGCimQfglYq+
         VLEsWYNHjHSiDp1CO+2jaKR/f0GpFtiSiLvqT8bh7QuuwaeFW9PF9cXw5LRwAYFyyjRR
         TqNnxIhNzE9/gX0nOa+AjCBihtzzjQyhH1mqqNasyjZ957tzcOFKcLZk+iFV7R2m2pEv
         0ePla5bo9g3E3EH8YbYR3gHCSvudipl86ru281rbGGvHwI1k0yA26k3fSKAPZ4doMrsM
         tt+w==
X-Gm-Message-State: AMCzsaWeYJLCXd/tJMSlULIJZ72mDHqFe5LLRBRQ0rw2jkXjNz6Alu+P
        wNMu7rD/vwz/N2ULciD9ZS/qhnQb
X-Google-Smtp-Source: ABhQp+TTqiRTMXFJsflaMpAvBv7HT7f7cjfgxOmNfcU7m01Y6nZs6oeVehZXrYFc0VocD8J3xp7u7w==
X-Received: by 10.223.150.116 with SMTP id c49mr1256107wra.246.1508178498345;
        Mon, 16 Oct 2017 11:28:18 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB64DC.dip0.t-ipconnect.de. [93.219.100.220])
        by smtp.gmail.com with ESMTPSA id e132sm9408934wmd.42.2017.10.16.11.28.17
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Oct 2017 11:28:17 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Minor man page weirdness?
Message-Id: <A4E5D8CC-19A7-442A-814C-FD5A46391982@gmail.com>
Date:   Mon, 16 Oct 2017 07:16:49 -0700
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just noticed that a space between "-f" and "git" is missing in `man =
git-branch`.
The space is present in "Documentation/git-branch.txt", though. I am =
using `man`
version 1.6c on macOS.

-f, --force
           Reset <branchname> to <startpoint> if <branchname> exists =
already. Without
           -fgit branch refuses to change an existing branch. In =
combination with -d (or
            ^^

Can you reproduce the "problem"?

Cheers,
Lars=
