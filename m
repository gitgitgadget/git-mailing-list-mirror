Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 653E2207B3
	for <e@80x24.org>; Fri,  5 May 2017 15:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbdEEPk6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 11:40:58 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36141 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751951AbdEEPk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 11:40:57 -0400
Received: by mail-wm0-f53.google.com with SMTP id u65so27321942wmu.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pIOBIjwOJOl1P8P0mBdSiFIMFHVryNLKPNkeVuLAxh0=;
        b=NJC0dVqan3V7kjcnYQvrO/v6Uo7eULUbg+dCfTKyGJRIc+TLDSoAuKlcov4u+kQ20I
         YvX3/DPi/r7xIzAsVhhbKRIvv/IUjI87iouvhZrjPElP8ag79FOaHonJ3DalomWlOiRr
         ECbo8+52O8y7Xglvq0LLhv1pPinJeV+GnyriUE21OM9RnVOd7s7KLyyIEBEB1yS2Pear
         /NddhnnFo/OPh2k/leGO4SWFO1Dl+W4Vpl+hJ9zUGaORKZjqj9JvbUW2yanAiJtSlkqk
         yyzz8XNXsCqxVWI0M7DZLhibUuPUM4BsAE3s4D+k1cJwbqPUD4hlglPHXsn/KQUmPC/F
         TDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pIOBIjwOJOl1P8P0mBdSiFIMFHVryNLKPNkeVuLAxh0=;
        b=o/jGpCug2Ex4jjXHxUkAV75C71kBEfQxrICQYV71Qd+j2Qbtl2k6y531aSTcUUBL6Y
         8WHcLgjJOHuAx+JE0tOHEhtcoofHKnIKzjY6fvoLqGsvppV6NH3SZzk1/Ou/HHMWWQgk
         tYMHH1I4W/4dII/Fn6z9zzvJyAR5mR52008R+wWdjQvCV0WBXn5plVQeeCedN+5OPhU0
         dLDCn5CESd3S+2P2h8G9NqpXJHBO4Z/yxT63fD6Gy4UxDE8pWvqGQoSYg3Ktt8R7Y6cn
         9aD0oGR4bV5O50MG8VZXhp4bNRtytNBags+5u9q2odhqrcZfwm8TURNOaxqyQxsNjDh/
         OWDw==
X-Gm-Message-State: AN3rC/58INqmY2mYmb93cg/7QLXLi2mzhCHqZYyz5YWBw+6kzlx4ukoX
        pm6C57dZyOH8FQ==
X-Received: by 10.28.24.71 with SMTP id 68mr5902539wmy.64.1493998855722;
        Fri, 05 May 2017 08:40:55 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id f63sm2531979wmh.8.2017.05.05.08.40.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 08:40:55 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v1 0/2] run GETTEXT_POISON on TravisCI
Date:   Fri,  5 May 2017 17:40:51 +0200
Message-Id: <20170505154053.58128-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

this adds GETTEXT_POISON tests to TravisCI. Patch 1/2 is preparation
and 2/2 adds the build job.

You can see a test run here:
https://travis-ci.org/larsxschneider/git/jobs/229120495

On "next" this generates a bunch of failures (see below).

@Ævar: Are your GETTEXT_POISON fixes in already or are these failures expected?

Cheers,
Lars


t5316-pack-delta-depth.sh                        (Wstat: 256 Tests: 3 Failed: 2)
  Failed tests:  2-3
  Non-zero exit status: 1
t6134-pathspec-in-submodule.sh                   (Wstat: 256 Tests: 3 Failed: 2)
  Failed tests:  2-3
  Non-zero exit status: 1
t3415-rebase-autosquash.sh                       (Wstat: 256 Tests: 19 Failed: 6)
  Failed tests:  13-17, 19
  Non-zero exit status: 1
t7509-commit.sh                                  (Wstat: 256 Tests: 12 Failed: 2)
  Failed tests:  6-7
  Non-zero exit status: 1
t1309-early-config.sh                            (Wstat: 256 Tests: 8 Failed: 1)
  Failed test:  6
  Non-zero exit status: 1
t3203-branch-output.sh                           (Wstat: 256 Tests: 23 Failed: 1)
  Failed test:  23
  Non-zero exit status: 1
t7800-difftool.sh                                (Wstat: 256 Tests: 71 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t3404-rebase-interactive.sh                      (Wstat: 256 Tests: 95 Failed: 46)
  Failed tests:  26-38, 40-43, 45, 47-74
  Non-zero exit status: 1
t3903-stash.sh                                   (Wstat: 256 Tests: 75 Failed: 2)
  Failed tests:  70-71
  Non-zero exit status: 1
t7406-submodule-update.sh                        (Wstat: 256 Tests: 52 Failed: 1)
  Failed test:  23
  Non-zero exit status: 1
t7508-status.sh                                  (Wstat: 256 Tests: 102 Failed: 3)
  Failed tests:  18-19, 43
  Non-zero exit status: 1


Base Ref: next
Web-Diff: https://github.com/larsxschneider/git/commit/a835cd4775
Checkout: git fetch https://github.com/larsxschneider/git travisci/poison-v1 && git checkout a835cd4775

Lars Schneider (2):
  travis-ci: setup "prove cache" in "script" step
  travis-ci: add job to run tests with GETTEXT_POISON

 .travis.yml | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)


base-commit: 813ba54fc35ef2b9c03fe84a4803e4365c22cf49
--
2.12.2

