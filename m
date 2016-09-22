Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7B161F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 23:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757363AbcIVXCj (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 19:02:39 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35164 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757328AbcIVXCi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 19:02:38 -0400
Received: by mail-qk0-f176.google.com with SMTP id t7so91170487qkh.2
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 16:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=0IEC6qV4qGpODRslPuRVTXyyZ83l/R5yzN5pSvhkm5g=;
        b=aLJ13bwh76d/3I49sDYhL7U+q2QNj7qK+6rYa5UO8suqyWDkZYoBgBXllpYgQB/T5r
         qUPP/d+N2FSMlqmy9sW/PxOYj3oqpMIcxi04TDH2dSw1657H3nAACSYb5aK2kkfzDfo3
         b+z7QMh2yKJb+5lxmr3G1Um02Su1DbVqg4fHdocoCfA+mhRRjihiiQLHvOJ2GGrKCEC/
         3y1fRwWEd0bUoRoPIBoLa8S5gp3yXHj8up7gEBm6eNNHdPz52rvpRpsb/c4C+G5mKs29
         ajY1LMEh3GcwZziw22+svYd9SuhizStXeoet6yGUHUM9vWXJ0d8KGp/VFvh0NWmuYm6O
         Q0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=0IEC6qV4qGpODRslPuRVTXyyZ83l/R5yzN5pSvhkm5g=;
        b=BzlGZ/n3dN3e4Z42wc0fWiBRthFhllGw1IgNMOBIjsu4yRJazElBNAnqiPUnqkZ+QN
         ocTC6i1fzxVxrlzdi3ds/+3GEfma4YukpFWMFpHwtFh0AZkM+PAhbQAyJKhspXxMG260
         niCczbmu1CU8bBKCtuhVrYg6IoD1X6JPipIKt7CUtGJw1vYOZSzSU+L/SrbyAc+sZ6dT
         33Pyj1qvVw5L+hk5fvEI/HBLTQwPZC1y0bOEI97UgRrZbcyrqnJqiJ9Kg+uZXRuZASlK
         u8mSk1ho8bS6PXdHxzCnO1OIJSKpUcG1/kRQquvcUSI4bLGV9x1ZKDzjOMK+iXQ1gwv8
         c3qw==
X-Gm-Message-State: AA6/9RnYzOGZREOZ+M90oPuy+U5U+mIgI+c4/oFzr+Q+vkEAcH8kEsTsMCL49DgatdxDHw==
X-Received: by 10.55.169.134 with SMTP id s128mr4760290qke.32.1474585357235;
        Thu, 22 Sep 2016 16:02:37 -0700 (PDT)
Received: from [192.168.0.11] ([181.170.137.94])
        by smtp.gmail.com with ESMTPSA id l6sm2222383qkd.12.2016.09.22.16.02.36
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Sep 2016 16:02:36 -0700 (PDT)
From:   Luciano Schillagi <luko.web@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: error
Message-Id: <15EA3A56-BAE8-4FAF-B277-9628307899AF@gmail.com>
Date:   Thu, 22 Sep 2016 20:02:35 -0300
To:     git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

please, what should I do to fix this error? thanks


Luko ~ $ git init
error: malformed value for push.default: aguas
error: Must be one of nothing, matching, simple, upstream or current.
fatal: bad config variable 'push.default' in file =
'/Users/imac/.gitconfig' at line 16
-bash: __git_ps1: command not found=
