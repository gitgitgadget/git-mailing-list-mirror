Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43338C433EF
	for <git@archiver.kernel.org>; Sun, 22 May 2022 18:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbiEVSlq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 May 2022 14:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbiEVSlq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 May 2022 14:41:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFC01A062
        for <git@vger.kernel.org>; Sun, 22 May 2022 11:41:44 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n10so12155599pjh.5
        for <git@vger.kernel.org>; Sun, 22 May 2022 11:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=T/Z4HGGUcPRs+MW8NRWtHpsqrx85MvVs0xV5589v2mg=;
        b=kmGl8W69JOL8RGuzmd1YIXoSQQCO3HtcDxEhFl3IijQqfUh4qBG/2PyqEDb2+uCOIu
         fGjI25aC8xptxNSufQoiWP3t+E1P8mvnsHnX8d4YfBbeTUEq9AyWYWLalrDRa5ipOU2Y
         MYhqVmmSyI6lJ/gZWv7l4P0mtF0vYMwEaGP5/7ghau0HqxcJBBnh9NdPbKSm14kxpB03
         24IZf2U1KmA779saIPooLdqomFvdiLTWaiesbu4KtwM/P9HKb/KzZ0KdKIHj1zRZfl5d
         b2gvxWAgb2mgqAlV5pK4G+Go6dFXCezScTTC3dPvdJ+I8M38QVrjrf490N46K38mj28u
         x6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=T/Z4HGGUcPRs+MW8NRWtHpsqrx85MvVs0xV5589v2mg=;
        b=kdp5bws3749PBP8FXwI9wjwggr05fA7DGU0KzvC2LYfExBegrLSgLAKkJYP2Rrpl0q
         oTpbsTFvWFJvhlfYFzzjUiFukl1KjUis5lFHchhNj/mGRh8CCwDQyAY1bhKIO/F+Coc2
         AcQp3nBT1iJlDvIS1S11TqNVJpZD8LrTJXex+KVM1eb/vvg46YDVoJcixeMSgOmoANsN
         6i4svs4WgzKW2+5gQ0sIIDpgREvAg+8ubOlrzIaZg80lSeQikmT4RWqlGp2ZPx5PL0H3
         29ZARsn3OB5al/UP0d//w7o+0DpE80x8G8/dS9RVGgH26VpXlNSPtFAlyJextecN3oZs
         hTjw==
X-Gm-Message-State: AOAM532YVB5nrAoVHNpCTkP0vwlN3l3utWS+IK6+HqrYZktEt3fLFAed
        qEw7cIISsT9xvbUs7fppS35RF8eaz/fTyQ==
X-Google-Smtp-Source: ABdhPJw7Pqi+y/CS3g8lhDsg+wM3I6kgtCfagOZjFtwOBGwP/BTfLuZ0BNeNGpx6wpLqTn73af7GBw==
X-Received: by 2002:a17:903:1108:b0:156:73a7:7c1 with SMTP id n8-20020a170903110800b0015673a707c1mr19248022plh.101.1653244903926;
        Sun, 22 May 2022 11:41:43 -0700 (PDT)
Received: from [192.168.1.6] ([171.49.247.183])
        by smtp.gmail.com with ESMTPSA id e24-20020a637458000000b003f5e0c264bcsm3235126pgn.66.2022.05.22.11.41.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 11:41:43 -0700 (PDT)
Message-ID: <ccb312dc-c2cc-ca3a-e659-0f87ceec0d15@gmail.com>
Date:   Mon, 23 May 2022 00:11:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     git@vger.kernel.org
From:   Hrushikesh Rao <hrushikesh20thegreat@gmail.com>
Subject: Git commands version documentation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

I am working on git maintenance project in Jenkins. We are using 
git-maintenance to improve the performance of the git commands further 
improving the build speed. Git maintenance was added in git version 
2.30.0. The aim of the project is to also support systems having git 
version < 2.30.0. Few git maintenance tasks very available before the 
maintenance command was introduced i.e gc,commit-graph,gc and 
incremental repack. Is there a way for me to find out in which version 
these commands have been introduced? Based on this we can support legacy 
git version.

Waiting for your response.

Thank You

Hrushikesh Rao Naidnur

