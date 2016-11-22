Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D50A21FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 22:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933819AbcKVWbt (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 17:31:49 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34584 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933460AbcKVWbs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 17:31:48 -0500
Received: by mail-pg0-f54.google.com with SMTP id x23so11933049pgx.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 14:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5WgqGR/+5/5XBmUR9gHNMtGZctaGRQlAF0pBdI76+lc=;
        b=Oq+FdJmy7Q/JuOGc/ss6j4gdMiit0vKfcN4viAgSSvgAljSQCWAwzDfDJGkSocbzHi
         dDatSYsw88PBQ90l8wqbJjccXg3A4LznziRgwMhRmIoQ8qSPxykAspxT7BtChl6khmnC
         rUwnE0uuts1Rhnk4+AW3VbeYM8nakFJG390JTVjGPDXL6bgmk3eTSnwtcp655z8Ov2KU
         QjKNVBZ934UP4Wk1x5TYc0gIYkV+9SaCmpn0MrZKfs+GeNcrBWsoUYeG6GEeBR1u6dIG
         6TPL9/aNe1rE/J0nx2Fh5Wo6AzxlK12P0fpet6yu/wAg4db/8kPUF+iDvK8J1jPx4by5
         rGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5WgqGR/+5/5XBmUR9gHNMtGZctaGRQlAF0pBdI76+lc=;
        b=I45Wm+4KXql35N4pstKkQp2DbWpJ1v/H+Gtnznne3Te/8w+OCvyVdTWmqHTd/JUaED
         uqr+mrNZRozbmieA6yBAYX6YU8O1g2nu9bIRxzamEZpV/sHGqhK2LeRXg5Aau4r1Xlyb
         rOU403xLQAYHJBGR0HvutEHHHgN1zwJsYT0Ifev27nLCFyrM1R+stx/p/XVvfll1H+C+
         L6D/LrQToyCxPLT2WGHzWPKMp0vqHTC4e4ydhxs/vknXwr0J1RSm3SOTmY3tCH/tACWx
         hkDvOQYNtlW0Dd+ytB6v6WVfdP21SPPPm3VUPQLOQvthX3K/45Z6Mk4rkqDMTv7+xWYr
         W9Tg==
X-Gm-Message-State: AKaTC01CsLMd9gk3fn0+bDyOZzC97+fOCcWRzLUL2VPKXxCkwjopAQM8FEM8Y+YQZBR32zaZ
X-Received: by 10.99.185.4 with SMTP id z4mr47679292pge.133.1479853908089;
        Tue, 22 Nov 2016 14:31:48 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:a049:6e3d:16a5:8086])
        by smtp.gmail.com with ESMTPSA id v77sm47368916pfa.85.2016.11.22.14.31.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 14:31:47 -0800 (PST)
Date:   Tue, 22 Nov 2016 14:31:46 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re: [PATCHv4 0/3] submodule-config: clarify/cleanup docs and header
Message-ID: <20161122223146.GB65825@google.com>
References: <20161122201438.16069-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161122201438.16069-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Series looks good to me. At least the issues I raised are fixed.

-- 
Brandon Williams
