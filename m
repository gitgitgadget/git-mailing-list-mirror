Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85B8B1FF76
	for <e@80x24.org>; Sun, 25 Dec 2016 08:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbcLYIpg (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Dec 2016 03:45:36 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:38288 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbcLYIpf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2016 03:45:35 -0500
Received: by mail-it0-f54.google.com with SMTP id x2so133683031itf.1
        for <git@vger.kernel.org>; Sun, 25 Dec 2016 00:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=J0j0wNpJlZ6tyjhxDdndf8pqeU1cOvkn8abIcals4w0=;
        b=HL7V4Nm0hqvsV3I6MwuU2nDDFQRvN/S3stPQNSmFYSGp8fQz65zfCZ5OrS3LLKRBci
         4CFkDCF1s0p6c5bpuGqDAftTrOj9Bqrcz5gBffhk9n8IvjK2yajiy9cSDJssAB9mAZWS
         bajMKdRKel9zPrUDTwSG7tX2CEkJ/edxfH3puLr7D05EJUZeuQLX9wayusmNf+vlabQt
         pidfKISz4LAYkXJhoweomFXWE/6oP6ZWghrvADW48dR6uXZs324/bh3vtLrVKZmvedmN
         XOHs7yupZSB68dPkv2Bj4QM62dJJRu+LwqsBHPIVCUGerzxl+iDUc8DxCfSbudIS6UIu
         0cDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=J0j0wNpJlZ6tyjhxDdndf8pqeU1cOvkn8abIcals4w0=;
        b=ZxRxYhA5qGm7UnMwZsbRxdlDAndH8op+zFKhHwX+oyanelhlXdnzWgViz9V/7iiJOF
         rTqoJlEYTriuuvJ3ICt8J9Id2s2h87QcQsJzXJBOw+DGMFgegwTNFbGEyO8CMLldlIEk
         l+5bqTt9ZANZtJEKqpZ9hNyCnL+r6abyRSNPiQP3Fze/X96ZvNto5SLMBbBv9IxHdq9x
         MYTC+n1x4SlI8X1VWg9A8/gXvjSOdw2c3Ov0BE0+YX08ywKoGqL2yzCucNC2kbo0Snx1
         AdPv5XBhKO4tw2aG1Y4c1tQU8aRlCwVV3HymvuGk/rfLCSSTkbB0oleBJGwUm/rdyMy7
         rG+Q==
X-Gm-Message-State: AIkVDXLikE83pUn8viLOtNzzOiUpp6ZejBvZAoAWXGfAY2VPTG6GKvglPHR/yA+xSwCp/MBWitjfUHJUNL2LKw==
X-Received: by 10.36.0.74 with SMTP id 71mr11906825ita.106.1482655534087; Sun,
 25 Dec 2016 00:45:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.11 with HTTP; Sun, 25 Dec 2016 00:44:53 -0800 (PST)
From:   Salil Surendran <salilsurendran@gmail.com>
Date:   Sun, 25 Dec 2016 00:44:53 -0800
Message-ID: <CACbPg6=_VPAJao2XAW+Hkb8_jYQTT3vzeS+eNAUJQRtSA-+EvQ@mail.gmail.com>
Subject: git blame while resolving merge conflicts
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I often rebase a large open source project and there are merge
conflicts where I need to figure out who made the change and when it
order to decide as to which change to take. So generally what I do is
that I go to both repos and look at the file and do a git blame. Is
there a mergetool that will provide this info during conflict
resolution. I would like to know who made and this change and when for
each version. Right now I am using meld.

-- 
Thanks,
Salil
"The surest sign that intelligent life exists elsewhere in the
universe is that none of it has tried to contact us."
