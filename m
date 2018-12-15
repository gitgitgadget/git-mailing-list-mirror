Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 276A21F405
	for <e@80x24.org>; Sat, 15 Dec 2018 05:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbeLOFBO (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Dec 2018 00:01:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56035 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbeLOFBO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Dec 2018 00:01:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so7419128wmc.5;
        Fri, 14 Dec 2018 21:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=VswJgG7it5Q1jm3GYiiCXHIERMYE0/nKe9e0nOL8x18=;
        b=aYEggcRTKItUfulNlrHg3uixHHTUEI0EgJTS5S1IqZsflA85u+E4XBX2rQNAFEx394
         v4BejI7sjlm6zLWie0Nx8BWMgJOLQ6XgVYxoz0ifXCrgTgLA1LxzmVTUPcWCLt6DEOOF
         Y0AecUipeErVf5wv3V2/xWyuSoCMMvVRmGSHDpm4WVLLIZX6Iwy4IfuH1R6BGqBQm/CI
         Y5xASgibezyAGw1ieH2szhcJnkkYJRahKwSNANVEYq2KnV8a4QDeJQaTKkHF9SV7ZL/L
         v5niPQOoPYHE3rNBCgIXAHZEQUMiw+4wFzke1zTcM8kmcqeYNT0mWScz/CD4Dk/OPLkX
         gJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=VswJgG7it5Q1jm3GYiiCXHIERMYE0/nKe9e0nOL8x18=;
        b=CauJhn7SdEEnEXmtWHCmoxM/yFROrRHhsDAittb3/MeIcfVoYth/PP1J8jbG6JN1SG
         b2iUhaQwPPjLCwL52cOFyoq7e+hFsGfg3ZoQkFtZfTQCv2Mx8MGLIro0xybJtFX9gB0J
         xB789z9Uw+Tt0MbE7b2aDN4ESXN3ZbzGwodKC8ChEoBWygU1XgT1OVBIanryBNvSIBTr
         j6iWtB50ZfHDSk+wFvCw0OZxNeE4qex5b+QyHwP0MCWNeG09AlfbwxCUQUGaEKBAoKAS
         QyxBhE6gAZ/pxNmO+2a68aU36WCc8V8PbOojcdGN5C0OADuFZ33rFfzh5mvF9v9n4nc/
         J0Ag==
X-Gm-Message-State: AA+aEWZnRldqDF5kXkqx34nF+vkwnPNXXVzngkADRnV+5V49bRYrwbd6
        IE6tTGFafGzwXmUCLsslBfPy+OwiRcE=
X-Google-Smtp-Source: AFSGD/Wy8ijdFTufkBYNE3dbNo7sqvDQLJeKmAq8quhCBL6B355SqTS8k1JR0kBPDB5unDPw/niPtw==
X-Received: by 2002:a1c:8f95:: with SMTP id r143mr4908698wmd.65.1544850070918;
        Fri, 14 Dec 2018 21:01:10 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i192sm6316934wmg.7.2018.12.14.21.01.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 21:01:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.20.1
Date:   Sat, 15 Dec 2018 14:01:09 +0900
Message-ID: <xmqqsgyzbcyy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.20.1 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.20.1'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.20.1 Release Notes
=========================

This release is primarily to fix brown-paper-bag breakages in the
2.20.0 release.

Fixes since v2.20
-----------------

 * A few newly added tests were not portable and caused minority
   platforms to report false breakages, which have been fixed.

 * Portability fix for a recent update to parse-options API.

 * "git help -a" did not work well when an overly long alias is
   defined, which has been corrected.

 * A recent update accidentally squelched an error message when the
   run_command API failed to run a missing command, which has been
   corrected.

----------------------------------------------------------------

Changes since v2.20.0 are as follows:

Derrick Stolee (1):
      .gitattributes: ensure t/oid-info/* has eol=lf

Johannes Schindelin (4):
      help.h: fix coding style
      help -a: handle aliases with long names gracefully
      t4256: mark support files as LF-only
      t9902: 'send-email' test case requires PERL

Junio C Hamano (2):
      run-command: report exec failure
      Git 2.20.1

Nguyễn Thái Ngọc Duy (1):
      parse-options: fix SunCC compiler warning

