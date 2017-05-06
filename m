Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAADF207D6
	for <e@80x24.org>; Sat,  6 May 2017 08:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754745AbdEFIlK (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 04:41:10 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36409 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755203AbdEFIlI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 04:41:08 -0400
Received: by mail-wr0-f172.google.com with SMTP id l50so14300579wrc.3
        for <git@vger.kernel.org>; Sat, 06 May 2017 01:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:from:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=aJ+GoqBWX+TV4a8BChzPhnWcSxj7DkwignRB2E6w/DY=;
        b=GE0RA7DkiIlr2apWDZhCXFLwXDSiABOuuSWhYnF65oH46jDNUUmFtKUvkQoh9EjTwj
         WyB/cBXbQSpTIy0ZtlZEPyJ+f5QRWPG2XrWG50GdyLZAwTFlj2w/hBA5TAfQksneVACY
         Wt8qjRamXT7e6PuL2JMBJUOWYPMRYoymP1ym/9QUh051bC6MUhM/tNZKIJS5LFDPoMD1
         VNvEUKyuLZDZ4o/xa7gNxuRZdj1U84STQ/nJl5yM9b3ysEDZttIW+E4yIEHD5pJWkDqm
         77jRZyUQ4JM/UfAD6aWwjRl+14ky5m8/2Mk5sfg7SY55PzarCbdIQP0BSbFs7BvP8V6b
         moXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:from:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=aJ+GoqBWX+TV4a8BChzPhnWcSxj7DkwignRB2E6w/DY=;
        b=rEZdJFhewmAvibEIoKyoDkWfJRHyuIsESIyYD57+NT4xvSj9llVneypBE4Jjc4kJly
         5R/oWdQ1MXq5oUS4t5J0mnWsVuSxjX+5kYg2cNhcDec5T/MvKACEMM5gdE6FtAXusIP8
         eCoxaFt9ollWJ0bWL9L3LrtgpQRTFSgJHasynQm+a7nRHKG4xQ+cMMzLp3/UBnwLLgY0
         BokNyDiCYRYoT5VFg8UZb2t+xbKHDjteUbFEoixZF9IPvK24vq4TJUNUhXV/KEKWEvds
         wdUCfhcntkRr8aTSx0evTb3m//NwgSsPRaZmrp3FRe+skIA5hlvjXB6zx4jl8VNMYWPy
         mkOQ==
X-Gm-Message-State: AN3rC/6Ks02ErKph0Ob38m6M9RVVQRR3HdVedealms5hJmJJVppDnFiF
        2pda6bWAVmXlxLGY
X-Received: by 10.223.169.226 with SMTP id b89mr32255075wrd.147.1494060066962;
        Sat, 06 May 2017 01:41:06 -0700 (PDT)
Received: from [192.168.1.38] (83.red-81-36-55.dynamicip.rima-tde.net. [81.36.55.83])
        by smtp.gmail.com with ESMTPSA id i11sm6401997wrb.44.2017.05.06.01.41.05
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2017 01:41:05 -0700 (PDT)
To:     git@vger.kernel.org
From:   Jordi Mas <jmas@softcatala.org>
Subject: Not translatable strings in Git
Message-ID: <f3bfb85c-1722-e720-3d36-40c29a692867@softcatala.org>
Date:   Sat, 6 May 2017 10:40:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: AVG (VPS 170505-4, 05/05/2017), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

When translating git (https://github.com/git/git/tree/master/po)

The following strings cannot be translated:

  remote: Counting objects: 331, done.
  remote: Compressing objects: 100% (213/213), done.
  remote: Total 244 (delta 184), reused 34 (delta 29)
  27 files changed, 3399 insertions(+), 3320 deletions(-)
  create mode 100644 build-aux/flatpak/org.gnome.Nautilus-stable.json
  delete mode 100755 build-aux/meson/check_libgd.sh

Since they are not in the PO files.

When working on making these strings localisable, I suggest checking 
that in the same modules there are other hardcoded strings that cannot 
be localised.

Thanks

Jordi,


---
This email has been checked for viruses by AVG.
http://www.avg.com

