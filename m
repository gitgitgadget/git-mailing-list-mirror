Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF38E1FBB0
	for <e@80x24.org>; Wed,  7 Dec 2016 09:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752549AbcLGJqo (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 04:46:44 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35035 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbcLGJqo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 04:46:44 -0500
Received: by mail-pf0-f176.google.com with SMTP id i88so76222216pfk.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 01:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=c3bSvijMrpZJ2FeF+Oe9qLwyQUgP5m/Rxyu6C40qhM4=;
        b=GRJ/f5Xe720XzbDI7CsZl/mFqOPMeKspYZ+kpth0nh4V9e961cLbITJ0Juafl1ZVzf
         VD5yzBHZpNDJ1+joyoy8bUoVVl/k+CqPvtAlim18jsBvhf4HavAoWNF5RHf22mK6/UxE
         g4dITEzUj7YeZVZnwW2wcgYpG/kzIsfbiUoSTOSygTFAaVg2AJzhk8rdfrWN0xbFeCvM
         pd3/BseigTHXrlj2VrvbMPyAv/8ta271BCMVLM8+sVwyZuxVV/meqx6v/rhLTNCNCcZ6
         gmqAUJMP+bpYBv4aOoCrEm4ITdxn4tyhwUe5bw4AxdmkncTnCrNy7cKKsaHhLzDBJaTY
         QZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=c3bSvijMrpZJ2FeF+Oe9qLwyQUgP5m/Rxyu6C40qhM4=;
        b=B/+r2TLOAMr4gEehumcdJYueZXtjKsmW5CrgBtEK3Yy6GmFkxc6bP2WrvELTlmaM68
         BSIvdCFNdlCCdnbakrzdz7ncvaMLzmNqZMwQuTamYNyWXzYoVTr38B7GrTlRelqANbuo
         qsIsl7DxkEXaiF8Fp62BgYk6IFQX4PmeVbm4KlGhtXcD/l5N1yY8NbIOGkpnDJRmMPlK
         u9VsusFtqEvOQnclOsqX1+1/38Fwg7LBtMUTmu3WpCe+xSsYZ0KypKxQU1+vdXffDDvB
         fKhiyzVMiW1nMND4ESEuQlGRq1iZFJYxBNHKmqHnIj4z0U4rJicZhFVrfWolQpZbMMKK
         B6aQ==
X-Gm-Message-State: AKaTC02TvF14AM6j3/mlsZhYIP00AVN+wU+1IaretFGtD7leO+9mQIYgja0HGvlvDa/LRw==
X-Received: by 10.99.138.75 with SMTP id y72mr119497465pgd.90.1481104003158;
        Wed, 07 Dec 2016 01:46:43 -0800 (PST)
Received: from [192.168.1.14] ([115.187.229.149])
        by smtp.gmail.com with ESMTPSA id p25sm41077926pfk.20.2016.12.07.01.46.41
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 01:46:42 -0800 (PST)
To:     git@vger.kernel.org
From:   joris <joriswu@gmail.com>
Subject: 1 files changed
Message-ID: <5cfee62d-0b47-897d-0882-387de68d01fa@gmail.com>
Date:   Wed, 7 Dec 2016 19:46:39 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When committing a change that touches a single file, git reports :

1 files changed, 1069 insertions(+), 1063 deletions(-)

Note the plural for the single file.

Regards,

Joris Wu

Software developer

Brisbane


