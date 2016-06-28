Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92B1E1FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 07:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbcF1Hxf (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 03:53:35 -0400
Received: from mout.web.de ([212.227.15.14]:60198 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbcF1Hxd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 03:53:33 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LmxtE-1bq2eT1IDs-00h3tA; Tue, 28 Jun 2016 09:53:29
 +0200
From:	tboegi@web.de
To:	git@vger.kernel.org
Cc:	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 0/3] unified auto CRLF handling, V3
Date:	Tue, 28 Jun 2016 10:01:11 +0200
Message-Id: <1467100871-2686-1-git-send-email-tboegi@web.de>
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
References: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Agn8qU//i0imOYHD+52uY+VvS/VkeIW1n9xpRubk55BBlgtFOWM
 wcNxb4da4cQRhyRDsCSJGXaueh9R0vipwFoY93EXxBQK1TcFmhWcYrY8jzoIj/zP+/Xq/Iz
 Hj/YUR88kOTPqrk+IutpsY43k7XUg9yfgiXF+vM+46Y7tYQHgWE3Djo8vwlX3hfZ/X9OfHF
 6Cq6hcsSObQDQx/KvyxAw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:cXvO5SPN+WA=:6Bpw/uiB2L/PqWLJlkMd1s
 1YqWPJwT5MPEyZLLFEwJ1S0g9d6VE3CLoeslsa+qcyOAHA0Z0XRNWXJf8EYb2VBMomF41MKVQ
 9AhvQXdY9y+4xtEDWo1XDOXi1fH61AMcEm7x4Lo6sN6qmaHEdMEr2yvvSeILzXHhaGNpHDYEi
 jvCE98trrMJsEbdY71yx/V5Lmo7wFD0Q7eqArglWhBVHJsB3J7se4PzKapZvnTzLIVPos3Bbw
 UZ55z4+TykuPVcUzzGlpUlp9Y4xAXxEvqW9ATNmMhUmFPjT8s6pJlx6arhYviTpAVpNjjUser
 QcRxTYSavNyhGrfP3K0eYoAWBtY4AMntdeHZrlmByZaadQxbHuFMSbp+mxdM5MRR+R6DKl4qS
 uZybcEMAM8ZK7gNsWs5b5dAJBx1YPdGGebuxSnva+cUqTTWFTAumCfvyDz7CMftzIFsMeqyO1
 c5bphRRFwr1YnmKR0GTZMA3E/qC2He7/o/1m1VaE04ks5IDn/yghlBYgZGvRGIfPW9I2LB9nk
 0uegLPm76cYcNrGXUFpKBI4i+dAivZU/Qst7+DObvspmfJjLcOgkH36HzkYwUZvFnI4yN7lEG
 Og3DPIG2iFC9GPCETMWlaykQC9vr6kHfv2eiEn8BJ/057NmSVTGsL06zz45heaSlpIq7sGvYy
 /vvOnjBlhPLnO9ntN8Jw4V7XwVCeVtg/vTF0bsA3TwYpV2e3K5fQ61hK6KtY98OIs1yERbPVt
 F1D/Gbt1KdNEUjG7ypjW4FO1jhKjyvJiAfLduG8zdJ9rvSdV9ANm3Xido1VXkLr/LlXp+lcto
 IJuR+Kn
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Unified auto CRLF handling, V3
I did the review, some minor changes: against v2:
 - SAFE_CRLF_RENORMALIZE is now 3, not 4 so that enum safe_crlf
   uses 0..3
 - V2 had unintentionally commented out the ident TC, fixed that

What more may be useful to bring this series forward?


Torsten Bögershausen (3):
  convert: unify the "auto" handling of CRLF
  read-cache: factor out get_sha1_from_index() helper
  correct ce_compare_data() in a middle of a merge

 Documentation/config.txt        | 12 +++----
 Documentation/gitattributes.txt | 15 +++++----
 builtin/apply.c                 |  3 +-
 builtin/blame.c                 |  2 +-
 cache.h                         |  4 +++
 combine-diff.c                  |  3 +-
 convert.c                       | 65 +++++++++++++++++++++++-------------
 convert.h                       | 18 +++++++---
 diff.c                          |  3 +-
 dir.c                           |  2 +-
 read-cache.c                    | 33 +++++++++++-------
 sha1_file.c                     | 12 +++++--
 t/t0025-crlf-auto.sh            |  4 +--
 t/t0027-auto-crlf.sh            | 29 ++++++++--------
 t/t6038-merge-text-auto.sh      | 74 ++++++++++++++++++++++++-----------------
 15 files changed, 170 insertions(+), 109 deletions(-)

-- 
2.0.0.rc1.6318.g0c2c796

