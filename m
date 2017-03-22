Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF56B20323
	for <e@80x24.org>; Wed, 22 Mar 2017 19:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965932AbdCVTZy convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 22 Mar 2017 15:25:54 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33815 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935421AbdCVTYN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 15:24:13 -0400
Received: by mail-pg0-f45.google.com with SMTP id 21so78800413pgg.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 12:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=YRV1X6NSVtA0JOQXBobx1okNZnPdNVVAT6oyZBIGdyw=;
        b=jbfzZCxA3ApxZ4SbbAzoaHnTZlHUBNLu60znAFZZDua9wixBpp/J3G2uy3a3cZqaLm
         QoKcizRbdIweKj62yn7g38o1kgv5z6o4SF994Z7I+ujel/0aCJEI1n1n4Ymk8LDZSMGm
         CMlt/zVqCTchH3o01fN8yxUvwQsR+MsaOz3qwUWvyqfgR/yabyiys82Yzm/iWwc9ggx0
         nncKW94FU5on9F7NtpLOluDJmm0RfWCRO8NcSW/v3/E8bq98q+fRazn7lU87lPcWgRgj
         9VQ+9JQmRCkE4zsx98tWSiwNzM4lFTpfNU45+YWvZ6XsUM/SztDHM+d7hV6F3fgfm2G6
         1KZA==
X-Gm-Message-State: AFeK/H3mUO9ys9FFHUB1hEGrBm6bR/gMK1cvfc1VqRHfLrxT+Y9pD8gmx83XcLbtAQavRw==
X-Received: by 10.84.232.135 with SMTP id i7mr37320953plk.134.1490210621919;
        Wed, 22 Mar 2017 12:23:41 -0700 (PDT)
Received: from darkstar ([97.107.183.15])
        by smtp.gmail.com with ESMTPSA id l29sm5453032pfb.118.2017.03.22.12.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2017 12:23:41 -0700 (PDT)
Date:   Wed, 22 Mar 2017 12:23:40 -0700
From:   matthew@giassa.net
To:     git@vger.kernel.org
Subject: Question: xdiff and "pretty" (human readable) diff output
Message-ID: <20170322192340.elg2gpvcshhk3jq3@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: NeoMutt/20170206 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good day,

I have a question with respect to how git generates "pretty" (ie: human
readable) unified diffs. It's to my understanding that git uses its own
(simplified/minimized) fork of libxdiff, simply referred to as "xdiff"
[1]. Which tool/library is used to take the xdiff output and generate
the human-readable equivalent that is rendered to the console? I have a
program that I'm maintaining that currently tracks changes to a couple
of "sandboxed" files, and I wanted to add a simple console UI that
periodically shows the changes to the files over time and/or dumps the
"pretty diff" to syslog.

Thank you.

1. "Use a *real* built-in diff generator · git/git@3443546",
   <https://github.com/git/git/commit/3443546f6ef57fe28ea5cca232df8e400bfc3883>,
   Accessed 2017-03-22

--Matthew

