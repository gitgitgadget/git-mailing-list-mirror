Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 490F71F461
	for <e@80x24.org>; Fri, 12 Jul 2019 15:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfGLPd7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 11:33:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52516 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGLPd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 11:33:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so9345692wms.2
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 08:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=a7AvFsSH14S1oLI3p/vfSW8+/JHZx/XwkssjMauplpo=;
        b=qJa46XPb6ouUV29N9QROm2s4OLaFSLTKdnqsFVLIJ15muWdiTuL7bvXbVtc94hf5PI
         TDUB9olb7IgWq/+YfT5XYPFwQfWGHDGqqUtniMXLXxjpdSTvKonqn9+a7UdxE6VV4Vxr
         o+wNOwiCc3hkqS/AcmY4LFIdVq4wExDd44zSNfVIQ0HQ+7B70Pc/zeUVjsauGERLSjl1
         Iois/8KJ0NLLSF/2+pKqZZn1+oxgOXRWejSeecvdEPHJe+iZMpkkgeKQx8n94u6FlhOD
         rxjDwkIEXy4b7f2aUDSvQ353e8cLuuJB4vLYq9byzYzy6Sar3gXbn25PUGAHKvIWtboc
         bPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a7AvFsSH14S1oLI3p/vfSW8+/JHZx/XwkssjMauplpo=;
        b=drscCmC51EcnvPGm16QS7gpNere1cCqOgQmUvTwxDQl9jDFAPxClGeaJoBIHxdw2FM
         sdf2NtbwGEFc+9vCLNuf4+gd6V2653TcPUk5LFYJ1WWdIS1iwdi0ZgAOkI6k3P/g5TaT
         p7c5Ees6Axnuk9dbz03dzD4KUV4gLpX376sr49mkIl1c5eHKIQ7dWJ0t6gzKbVUm5n3R
         KRbK39bc2B2sm2UIyt2/mRs6kqxvSM9nRE8H1cJf+TTmU9sBxUn+mQYLhbZM3KT+tOpZ
         GbijOc2QW5WC7rnl/SZgGsh94L8J1r0wdwgfa20IBTGSMNpYi3gmYor4ktVUJuTNu41/
         wv9g==
X-Gm-Message-State: APjAAAVs3s/N7flQw6eLbo5qtTH0B5Z17qszcI48HZrZOfmvrIkGxK7z
        5lownYh5hRXdHERuhVy8hird+6rj
X-Google-Smtp-Source: APXvYqwfsMLbX4m5Dv3Uwlp7HS14TcKVPiyqq9kdRn/NVzpSeM+4K8+H7o6sU0xXxpafZzXkjM9GVg==
X-Received: by 2002:a05:600c:118a:: with SMTP id i10mr10070060wmf.162.1562945636997;
        Fri, 12 Jul 2019 08:33:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8sm3089837wro.89.2019.07.12.08.33.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 08:33:56 -0700 (PDT)
Date:   Fri, 12 Jul 2019 08:33:56 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Jul 2019 15:33:54 GMT
Message-Id: <pull.285.git.gitgitgadget@gmail.com>
From:   "Robert Morgan via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Update gpg.txt to correct gpg --verify syntax
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The gpg --verify usage example within the 'gpg.program' variable reference
provides an incorrect example of the gpg --verify command arguments. The
command argument order, when providing both a detached signature and data,
should be signature first and data second: 
https://gnupg.org/documentation/manuals/gnupg/Operational-GPG-Commands.html#index-verify
.

Signed-off-by: Robert T Morgan robert.thomas.morgan@gmail.com
[robert.thomas.morgan@gmail.com]

Robert Morgan (1):
  gpg(docs): use correct --verify syntax

 Documentation/config/gpg.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 6d5b26420848ec3bc7eae46a7ffa54f20276249d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-285%2Frtmorgan%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-285/rtmorgan/patch-1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/285
-- 
gitgitgadget
