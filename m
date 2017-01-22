Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE96A20ABE
	for <e@80x24.org>; Sun, 22 Jan 2017 07:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbdAVH7U (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 02:59:20 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34672 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbdAVH7S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 02:59:18 -0500
Received: by mail-lf0-f67.google.com with SMTP id q89so11731324lfi.1
        for <git@vger.kernel.org>; Sat, 21 Jan 2017 23:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3jNAqbm7aQUg8RBW4j9JaBTOkJbmBLriNNstlxwjfWY=;
        b=A+XwFPPre4MfhtfrXepKTcdm/f6bNo4mhKUsrDKNg9bGU+TtwkqTKJ7SdHV4ySu8kJ
         66pxNeX6Ppeyg1CC/I9l+ihuCAz2O5XiuUmCPMpo0cyVK+6S8UHR9i8BdEbxm7l/GO76
         G17zuNbZaP+5nQsFWML6HdZ0NSE3YFCO1AoIWPFmVSOu/GuEQiiZlL9R+Epi3duX8/VH
         hQe+Z+s/Q7FH5KEWvHwID7BAwVRE8YDNoI/Dvhu+5f8WE6F+5TsJliu+LWQCIhp2yAgP
         n4R3GOGj665+3ZF6ft/V3v/FzX1KR5D80REXVTX5NnsrJ5atYErnH1Xq0hnx/rjoYWNm
         CZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3jNAqbm7aQUg8RBW4j9JaBTOkJbmBLriNNstlxwjfWY=;
        b=c2iC4RC4P16QjhYs63W3q5in9QhfuLTrEIC0IsHI7MVxL0/gAkBSksXS//PtHeths2
         IGu42wqi8KeTMv8XfdhgmI4Rthawqc+7UK6eNKEkpkaxaZir7KxrFT9BU2EZHbo3RSYW
         gOKInvnM1iGO72exnYu4z+spQAyt56TLv+msNSp047KGlDFiyLz0/qJcOCI2TAyqYe1W
         h8qN9IwJpRu1gkDIfHT3OdiW9O9xJ9OnU8tOzWaxEYomzLSt0onNRuln3Zp8nQ8zkURX
         4pp39o7Vn6dgu2hYxrFAHNTgCJo1JKPaQG65YlYhab4Faj6hc68ZoRdx0+VpBtR/mpys
         EwGA==
X-Gm-Message-State: AIkVDXK7eVwYRlRk22KuKBkPqOairoYyaZNqZ78Siwx21Ld2pFwPUOI212bzRKCcK4AUuEiEdZ9BhtrsS5NUvQ==
X-Received: by 10.46.69.7 with SMTP id s7mr9998022lja.44.1485071956600; Sat,
 21 Jan 2017 23:59:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Sat, 21 Jan 2017 23:59:16 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 22 Jan 2017 08:59:16 +0100
Message-ID: <CAP8UFD1+2Lb7c4DdtjBW8_2MG8LtiHAVZ-HoX7HwWhHrJmh3BA@mail.gmail.com>
Subject: Draft of Git Rev News edition 23
To:     git <git@vger.kernel.org>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>, Eric Wong <e@80x24.org>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Javantea <jvoss@altsci.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-23.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/209

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition but maybe I missed
some people, sorry about that.

Thomas, Jakub, Markus and myself plan to publish this edition on
Wednesday January 25.

Thanks,
Christian.
