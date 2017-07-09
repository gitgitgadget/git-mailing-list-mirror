Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7794202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 18:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbdGIS1e (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 14:27:34 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35539 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbdGIS1e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 14:27:34 -0400
Received: by mail-pg0-f68.google.com with SMTP id d193so10131900pgc.2
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 11:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:disposition-notification-to
         :mime-version:content-transfer-encoding;
        bh=vInOaoaC0yvbcxM+TapHQvry58pTJNgeSTul3mlI0Tc=;
        b=Vd434173PnXGtN90aLcwGpS6WTwgOFfwfItCsWWvAXTcU0vQ5ene73QeSXamQSeZEl
         VWTas/Sdpibp9DOuvJJqIrDeloot9KodBHsfEdChNHz+B4cxDnrdXyVd3KL1o6hY1v+C
         uAqW4PTFsRSOvOyU9753LUzWCDVmcUy7cMb7VoMoVHK5A87QW3tETrOJg2QyTA2E5j+a
         SBXudQHkEHJQ3jMWhofg6fpEEGnGf53bjKAMlCFnPQF9kpKcEMXHlco5BHfV5B8lgf09
         xLWB9NMFUf/WP/DoplSb+wdpJ2Qne+tVW1LivxUTv0PSGCgvMJf954F8OiBLBItTy5gr
         pjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=vInOaoaC0yvbcxM+TapHQvry58pTJNgeSTul3mlI0Tc=;
        b=Incwcy4BKvYrsGkna/VIm5ROktgX1adj4TZhv1G2ad046k3f4teX37l4dIJ4IOZBK6
         lTwkj9Am/13a7I0oFJw8oYOQvNA5ycW5Bh1Ov3Tlnjba69Ev3Dz9P3vy5JJbMW+FUQyO
         byj4nF451dnJ/OM0M8SjhDLKSbhvKyPkdyEkns1YBFkAgj7cGxv9aIWwcrXVgQVJduLv
         YMiKJa6e8XGR2p2fBG2Ay2obPluCMzcdA4hcZbraT3Q0wj7rrSug7ndEpOqI3Pq+DnhF
         0mLuEmElsce+Ztxr2xe+TlPZWcBIVhICP55dyS+X+PDkrKk4/3N40l6YR1SpCeyKwkw3
         4dtg==
X-Gm-Message-State: AIVw110BIkcYYxfIB99M0FvP14l882FJjNW6G19bkHDDbe7Rnw//l+q1
        SWCRGQJj4BToub3FCMk=
X-Received: by 10.84.232.7 with SMTP id h7mr14154591plk.193.1499624853099;
        Sun, 09 Jul 2017 11:27:33 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id n3sm1530616pfb.87.2017.07.09.11.27.31
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Jul 2017 11:27:32 -0700 (PDT)
Message-ID: <1499624859.8552.9.camel@gmail.com>
Subject: "Branch exists" error while trying to rename a non-existing branch
 to an existing one
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Date:   Sun, 09 Jul 2017 23:57:39 +0530
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I recently got the following error message by change as a result of the
command,

    $ git branch -m no-branch master
    fatal: A branch named 'master' already exists.

Note: no-branch is an hypothetical branch that doesn't exist.

Shouldn't I get a 'no-branch' doesn't exist before that? Wouldn't this
behaviour make the users search for the non-existing 'no-branch' in
their repo?

I tried digging the implementation a little and what I could interpret
from it is,

    * only the validity of new branch name (master, in the above case)
    is checked
    * checking for existence of the branch being renamed(no-branch) is
    not done at all. It seems to be left to the lower level commands to
    identify.

I'm puzzled by seeing this. Why isn't there any check for the existence
of the branch being renamed and warning the user about that first?

-- 
Kaartic
