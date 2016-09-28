Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8971A20986
	for <e@80x24.org>; Wed, 28 Sep 2016 03:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756648AbcI1DOz (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 23:14:55 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:32862 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756332AbcI1DOx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 23:14:53 -0400
Received: by mail-vk0-f45.google.com with SMTP id z126so32121271vkd.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 20:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=9pKVoMszpHihbsKjVi0ZRp3Nw1m3h5LxijfJapCUl00=;
        b=MNvzzVD0V6lUzb+4yKmxtW/kA+3FlJ0mM+5XHnOFIZ4GHfdlBAijqYvLIHz88HNUak
         4VgPj8SGhXzTY66S67XUmDJVgZDuuWrHlsL55xrOHYFnmqp4ruSjpiQEWSlYG+IC17+K
         pAyUqyxO6Q4ELN0ltrZbx2TKwdAPRnb3rQYqNMDSzaqVnLpLvAxPNAcr6Aajp5elBpsC
         4YOxfS97RaSYZVEwoApzGISYVNG/w0S4Z31yTZ54n3RjAriH+wkI8GtpVGs0DFjvItlY
         /FmvMfGK3YnDYbKKEtBbKg82/Gady5aBBPUmoI7MRLI5jCaBikshTViV0fK5KDu7Lx12
         CD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9pKVoMszpHihbsKjVi0ZRp3Nw1m3h5LxijfJapCUl00=;
        b=hzlpzxy8iOcAEwmGPlPp+Pi8v4+o6g2tPPJT84y94eR5btg/Dr0QvowUrm7jNicVTb
         0WKC36LEY6tqwftTEtcg/gw7sXx2uXsWFOWLHLtyW1W3F9pHo35Y30bj7pXjR9I/bD1j
         F613bILOf30im94jliS6Sv+SBjn31dYZ++P3HuXPPLHBoMx4MCrTJihTYXydolWIZ/IJ
         gcIvJecCfGm6i8rlNXLqMF+oOoLNNy8IiPlZdKKNPJiMGPu3fx8cRqtGxHppoJOrDtsa
         po9hJDSlj3AaBIEwetN2YOq88ukqY3ySGoRdalwbamHeMcCtlF97mzTxxyykZ+XI7LDn
         B9bw==
X-Gm-Message-State: AA6/9RlRPvyU7HHIP57rOK5j/Jm2dk8esRHfU4NIamFN5sKLSoFdze2f+OGgrSPJYEt4YtHCkV3Srks6H1NzzQ==
X-Received: by 10.31.5.19 with SMTP id 19mr13125154vkf.75.1475032492094; Tue,
 27 Sep 2016 20:14:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.122.196 with HTTP; Tue, 27 Sep 2016 20:14:31 -0700 (PDT)
From:   chris king <kingces95@gmail.com>
Date:   Tue, 27 Sep 2016 20:14:31 -0700
Message-ID: <CAJQwtsidixAAJKp7-b2PmXgs=mS+PbT5ebOmKLJU1nEn7UJ2og@mail.gmail.com>
Subject: Repeatable Extraction
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, first off thanks for such a wonderful tool! I have a general
question and I hope this is an appropriate spot to ask it.

Is there a way automate extraction that will repeatably generate the
same files? Currently, each time I extract git portable many of the
binaries change slightly. For example, if I extract twice using

    PortableGit-2.10.0-32-bit.7z.exe -y -gm2

then Beyond Compare tells me that many of the files in usr\bin have
changed at offset 0x88 and 0x89. Why is that?

Warm regards,
Chris
