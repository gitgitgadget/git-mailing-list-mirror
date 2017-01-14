Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 223092079E
	for <e@80x24.org>; Sat, 14 Jan 2017 08:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbdANIsd (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 03:48:33 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36277 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbdANIsb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 03:48:31 -0500
Received: by mail-pf0-f193.google.com with SMTP id 19so301629pfo.3
        for <git@vger.kernel.org>; Sat, 14 Jan 2017 00:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dq/WIVyJLAljz+2ycWvQEg9FuO8m71yE6gD1sYKS+wo=;
        b=uL3gnFEmK2u2EdSab0BUjohtyx5e3gdcHcfrxGKPtX+8U2DZJ6WRjq4pqx9pJeWxmz
         twsAcJJLLBjppco39KLI8EzWGjsEPzRupTzo5c0vPwZg4k2c3oqKgLfCGnu167rC0bZE
         oihnuvQYRFL8k0d4JBUuxfsbR1KdL1Hmp3je4O/P0+12vuvMCyQgKgNF5czS7QJTVuOa
         2CXTs3pa3GD7uqvmTUIhOSID0u54ZBpLlwxzYK3sfUp4wDdYCFmBgfiGFfV+5XVpQLrB
         pgGt7FhahbRkXpqWAQRRMPfUlG76Rpkb+0wDMKmmr4qZvK/cdNG+AocYBv2ylLNZfVwW
         o1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dq/WIVyJLAljz+2ycWvQEg9FuO8m71yE6gD1sYKS+wo=;
        b=K/BRdbKsj1CoTvyUoUitXrZKY/IVS7Xt/O71OnSXzg7+cgKXPcl9OnB5d83rKu4QpC
         MfwjMHSp/0ahKH3A27mApRQlT3Zo7kpy8pjmMcAe2M5xFgaWFZiTv/9NrccC5/6rz7U/
         DSJ6MLlo59HgD79JWsPrflY1q9vx+gogTJSRQnTfihXsb9V9byj4KqCI9EB9VIWDCnZR
         j23M6grYjuY7RxnCCUd1aYCmcbd1c1VmEqQu58zy2KIXS8wGImiwpBuJtkLMgdyP3RCf
         WHyO2RB/rQMLq3xOoc/CpRkTbMhUdKfrrXqq6KLQ+3Q372GO2GxSzn2HwusKYlRMbMp5
         ocug==
X-Gm-Message-State: AIkVDXKKsvN2iNy0wR5fOFkliajvl6o/uijs5mtzKDT/SbI12iCYUqz8Hxgp8+THz6HR7A==
X-Received: by 10.84.169.169 with SMTP id h38mr35440677plb.48.1484383710991;
        Sat, 14 Jan 2017 00:48:30 -0800 (PST)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id t14sm8070377pfk.85.2017.01.14.00.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jan 2017 00:48:29 -0800 (PST)
Date:   Sat, 14 Jan 2017 00:48:25 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Andrew Janke <floss@apjanke.net>,
        Paul Mackerras <paulus@samba.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: gitk pull request // was: Re: gitk: "lime" color incompatible with
 older Tk versions
Message-ID: <20170114084825.lcecrbtxny3ntulf@gmail.com>
References: <03babaa1-9011-0010-c4b3-6cad8109d3ab@apjanke.net>
 <CAGZ79kaO9T+Qc=M6s_ZdpAfLZCVQEYNF=zNxDWArDmsA7jjCWg@mail.gmail.com>
 <20170113112043.j7nowdilolswyk2k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170113112043.j7nowdilolswyk2k@gmail.com>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2017 at 03:20:43AM -0800, David Aguilar wrote:
> 
> Ping.. it would be nice to get this patch applied.

Sorry for the noise, and thank you Paul for the fix.
This was already fixed by Paul in gitk@22a713c72df.

I'm sure Junio will merge gitk.git into git.git soon enough so I
can sit tight until then, but while I'm here I might as well
send out a pull request:

The following changes since commit 22a713c72df8b6799c59287c50cee44c4a6db51e:

  gitk: Follow themed bgcolor in help dialogs (2016-03-19 14:12:21 +1100)

are available in the git repository at:

  git://ozlabs.org/~paulus/gitk.git 

for you to fetch changes up to fbf426478e540f4737860dae622603cc0daba3d2:

  gitk: Update copyright notice to 2016 (2016-12-12 20:46:42 +1100)

----------------------------------------------------------------
Markus Hitter (3):
      gitk: Turn off undo manager in the text widget
      gitk: Remove closed file descriptors from $blobdifffd
      gitk: Clear array 'commitinfo' on reload

Paul Mackerras (2):
      gitk: Use explicit RGB green instead of "lime"
      gitk: Update copyright notice to 2016

Rogier Goossens (3):
      gitk: Add a 'rename' option to the branch context menu
      gitk: Allow checking out a remote branch
      gitk: Include commit title in branch dialog

Satoshi Yasushima (1):
      gitk: Fix Japanese translation for "marked commit"

Stefan Dotterweich (1):
      gitk: Fix missing commits when using -S or -G

Vasco Almeida (2):
      gitk: Makefile: create install bin directory
      gitk: Add Portuguese translation

 Makefile    |    1 +
 gitk        |  166 +++++--
 po/bg.po    |    4 +-
 po/ca.po    |    6 +-
 po/de.po    |    4 +-
 po/es.po    |    4 +-
 po/fr.po    |    4 +-
 po/hu.po    |    4 +-
 po/it.po    |    4 +-
 po/ja.po    |   13 +-
 po/pt_br.po |    4 +-
 po/pt_pt.po | 1376 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 po/ru.po    |    4 +-
 po/sv.po    |    8 +-
 po/vi.po    |    4 +-
 15 files changed, 1549 insertions(+), 57 deletions(-)
 create mode 100644 po/pt_pt.po

Thanks,
-- 
David
