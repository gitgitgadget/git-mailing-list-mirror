Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 834481F404
	for <e@80x24.org>; Fri,  6 Apr 2018 05:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeDFF13 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 01:27:29 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43353 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeDFF12 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 01:27:28 -0400
Received: by mail-pf0-f195.google.com with SMTP id j2so10149877pff.10
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 22:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NObDgeTrZQdL5yFgZzSiw78ej3wXMJbhc2p3VLFIv+Y=;
        b=mdtF3yl/MMxZ+qfYASqAeg1rFfC3q/DgKOVpxgujZkokH6JdpUuGpH7EBUrW6uoudr
         g0zXfWkF8UG7SKziyAGCKKo5ZbkImBXQILiMgmXdNrv0lO+OaCYl6Ap1rTEOzSLUAPK2
         MYahgpHC+SnuftbS/rPL/TCsqYcbPnfkXl4X02LQYc3ol+5dkiXhFaxdNr/Rg8m2N96K
         QXXAXKdcd5JRMrgSy2QwLloso9SSrAUK/2DubLLHDBr/1osZkpPsRC9PuNWWdQ5hEMJG
         T6zNV0ejyX4omtj1/s8qcUBcxdx6CX8ElmQiL95Zz8HR4Hn9jFtihnyInrUaEWFrjqTY
         rSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NObDgeTrZQdL5yFgZzSiw78ej3wXMJbhc2p3VLFIv+Y=;
        b=hRcNxNjY62cBH+0cbJwRq3BuBlpOY/KvO0lgS56z+EgW2PSzH9R9p0kwEdRdpBPJZa
         Oa8KF77y76ksuLm6OVXXtlSGeCra+NryaVoYIOuV+HwQ6L7erdfKlj8oxwXYBHHFbv2H
         iY1kIwGBRwU7+vO/+mC+kt+LCK8LKVH2SvLy0vdBE+tM7zRd6wPmwnv+xdZIpJNG1po7
         JlbyF6Yyw79pB8vT1DMIp09VBI0SneKra3SrB3eTvGgVsB09raFou4nNKU3wlpUNTaku
         uAHKujAH4nDWmzcL3uN4zTxqeri+6xBoVTmiYNOatWu8qmpsGhS7cAOUc99lktYpiJ+G
         KCUQ==
X-Gm-Message-State: AElRT7ERIHc5U2IpBf8G44+clhC5JUX077nJluinKDJfBBicJrkb1ESO
        7QhtQ2HWFEIgjYVjhJgdbCVjpCflVHE=
X-Google-Smtp-Source: AIpwx4/j34IftXnCi1Bfk4BygCVUl3Naz2fcWMwqUvb57CIk6K9Il35x4ql42Su8kpCOJowH+L9EVA==
X-Received: by 10.98.171.7 with SMTP id p7mr19434268pff.215.1522992447058;
        Thu, 05 Apr 2018 22:27:27 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id x76sm19384900pfi.151.2018.04.05.22.27.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 22:27:25 -0700 (PDT)
Date:   Thu, 5 Apr 2018 22:27:24 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v5 0/2] *** SUBJECT HERE ***
Message-ID: <20180406052724.GA60769@syl.local>
References: <20180329011634.68582-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329011634.68582-1-me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

*** BLURB HERE ***

Taylor Blau (2):
  builtin/config.c: treat type specifiers singularly
  builtin/config.c: prefer `--type=bool` over `--bool`, etc.

 Documentation/git-config.txt | 74 +++++++++++++++++++---------------
 builtin/config.c             | 77 +++++++++++++++++++++++-------------
 t/t1300-repo-config.sh       | 29 ++++++++++++++
 3 files changed, 121 insertions(+), 59 deletions(-)

-- 
2.17.0
