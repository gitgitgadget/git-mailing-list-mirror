Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEB351F462
	for <e@80x24.org>; Mon, 10 Jun 2019 20:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389307AbfFJUL1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 16:11:27 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:44708 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389099AbfFJUL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 16:11:27 -0400
Received: by mail-wr1-f41.google.com with SMTP id b17so10460482wrq.11
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 13:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=user-agent:date:subject:from:to:message-id:thread-topic
         :mime-version:content-transfer-encoding;
        bh=9iiGAVkeZHS6UL+qThR9QzjZi1kHDhlnKmDbHEJ3808=;
        b=thUkwpp9lxe7Cz5DHNxV962OHWbrwZ7cTbvYTEv4sayQunajdAFpUzuKnPTmKOMrE7
         ndQG/R09aR8fRdyrxdngPBpClFG05U+SMv8eLwkXy3J2kNk5XvJJ5uIOoD9aBwkETX0r
         S5SHAxx+3/wKBldPJq9XWEVizbHwGO9rjaMglCvNAT7pG2YOsw96B1s3GLbSkEZjhwcc
         pLnZtRLkcRJRou/XJ/smlc+msgyUa2mTWQF6Jg3onrJS1IF5MeURKHJ0DJzJEo5MspK/
         PD9gh1Rk91F0YgDS3ss+HP1/sADnl7zT/gUH0EH4sejptdl7w0DmYktKPJTUcWmaW4v9
         fj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:date:subject:from:to:message-id
         :thread-topic:mime-version:content-transfer-encoding;
        bh=9iiGAVkeZHS6UL+qThR9QzjZi1kHDhlnKmDbHEJ3808=;
        b=Z3RvFWPhRVESe8wfFX0VVSJxR0RFQvLyZ8nztVa7DR1wqcCNm2tSm0zWB/a/xdMqW3
         gvumskb+jeNsJIX25AhVt2TAbS6xdRoRO0fKNcNDvBkIhcDDJRk6W5zHArQGntxOQuji
         WKirlrtA3wc+nGcvXhW5I/amLPn7PZzl15l7vx/+TOTvxq1prkULLEzFusVphOYCw2uJ
         8qKcmPR02TWAboNFHPWpxkdCXddDDbKO7+YC1dWHukRFHTKT+Zwh1bU7CXC8cdbMLKaF
         HmHP4XT3g8RCzwwTQD/OpqpbSG+lUCPjBH2sEjqnD1qACa5HRT7WLrdp4fOLaEhQIIiG
         8lSw==
X-Gm-Message-State: APjAAAUm5gyxLrd9RBGhkbSNGwvwEhQGl/SiouQ4kQdnVNQ+kK1/b2Wd
        srKeJIj1XMnxzelGoatuF53UmimmHas=
X-Google-Smtp-Source: APXvYqz47WRM4LbSKjm/nxUBI2/iHurOuhSHPHgIG+XoR7/hm3GqVVnONwpK7OsbdpNKlWw2p6d/ww==
X-Received: by 2002:adf:e40f:: with SMTP id g15mr2477455wrm.174.1560197485624;
        Mon, 10 Jun 2019 13:11:25 -0700 (PDT)
Received: from [192.168.1.100] (93-40-190-237.ip40.fastwebnet.it. [93.40.190.237])
        by smtp.gmail.com with ESMTPSA id l8sm5239650wrg.40.2019.06.10.13.11.24
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 13:11:25 -0700 (PDT)
User-Agent: Microsoft-MacOutlook/10.19.0.190512
Date:   Mon, 10 Jun 2019 22:11:24 +0200
Subject: Re-enabled a folder set as untracked
From:   Samuel Rabini <samuel.rabini@gmail.com>
To:     <git@vger.kernel.org>
Message-ID: <4AB7124D-0704-4C6E-B3B1-C0C1BF5C89B0@gmail.com>
Thread-Topic: Re-enabled a folder set as untracked
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Using SourceTree I issue the Stop Tracking command (I think it executed the add untracked https://git-scm.com/docs/git-add#Documentation/git-add.txt-adduntracked). Is there anyway to revert this command and re-enable the folder? I was able to re-add to the index all files into the folder by the git add -f pathtofolder command, but new files are not asked to be committed and pushed.

Thanks in advance,

Samuel Rabini
Software Architect
M: +39 339 81 24 118
samuel.rabini@gmail.com | www.samuelrabini.com <http://www.samuelrabini.com/>
 
 


