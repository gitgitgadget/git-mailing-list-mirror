Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBEC320248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDFLkx (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:40:53 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:40035 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDFLkx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:40:53 -0400
Received: by mail-ot1-f44.google.com with SMTP id t8so7991155otp.7
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Llp0OIzDbou48gU8Ylt+AxMsACeK/3FltojTlTy2ZdQ=;
        b=W9hg6X9lO19QFka9sOfDxP/KtDLqW+GjAitJjWEYa0I8HAz/YFN2b7PZROpCjudXkz
         zf5YsmKarAckMV9tlPHBRTVv2LO5OZuzPDjzvfSFNZWJdepXLSnRlwJwxBuhtI/pvnpH
         i/EKflilBC0ZphvgcfEGuZB1lrnvjXsD0j5X/yHJe/W2r1tpZRWLgP4sMzLRnfyr6kqy
         f7I5CNg8bVgfK4MIrHwRF106wfUuATOAfsrWE8GnwUpu80Kn/jrxdEAkCZB+/Z9w7E6Z
         PL26z3w7UR4nHjtWsPk5CQzkyG9e8xt+8OeA5t0yaaStsYjzzQh+5WfcQ/haXNunOWiS
         oD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Llp0OIzDbou48gU8Ylt+AxMsACeK/3FltojTlTy2ZdQ=;
        b=JFE80fCSrpKwHHz/MyLnhkAHQDthYmiQPpB4PAJnyfHlPbIZYvs09SC/Jjf0OuvUiG
         sHF+lpsrcS7HMMr0kZLHJcds5KysoNJhoYZJLwrYb1dhSIEMj44nUzd8kQuLOFeVWVcs
         CGrAHp3/PTF1If8DmV2AD7VfaTtzhH/0EuZu6shpFu/arYDKdec8PH7tDtaAYdTk8+yI
         1Q35JZ4YrQF7pdffBNq5ZA8J06fY/WOnGcmi86QcVh/ldPRr9++HIjWNPU/nemoqC+Y8
         Lsw3RDbPwpK7spC1b6oBZdQ4zA5Ps73bCRg+nxH+h9KDOJWOXafRaKl4AYTdPop00ms7
         U5Ng==
X-Gm-Message-State: APjAAAWXi3kEaOtLRU7khfDDECK8MS+RH0evl1qxrYHyxyEVnEsI5YRE
        47eNbHT2hzcNg3Lz81EtNIcHyMND6Wj9ka84elq0F8zQ
X-Google-Smtp-Source: APXvYqw76ap3CBD/K/AyWHIvquDXYZMPrZXHd3bnQ2cjGqg2MntJYxBtQnPrRSwFsD0yD8o8dNV1nMrMM9x+2MwItkc=
X-Received: by 2002:a05:6830:9a:: with SMTP id a26mr11370938oto.317.1554550852455;
 Sat, 06 Apr 2019 04:40:52 -0700 (PDT)
MIME-Version: 1.0
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Sat, 6 Apr 2019 17:10:41 +0530
Message-ID: <CAMknYEPS68VEkUbNxeKQvVDGjzVpBXKNAi3uA04pLwN9k4ZTfA@mail.gmail.com>
Subject: [RFC] TODO in read-cache.c
To:     git <git@vger.kernel.org>, Johannes.Schindelin@gmx.de,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

i found some TODO tasks inside `read-cache.c` in `read_index_from()`
function. which says:

/*
* TODO trace2: replace "the_repository" with the actual repo instance
that is associated with the given "istate".
*/

this same TODO occurs at 4 other places in the same file.

Will it be ok, if i complete this TODO by modifying the trace2's
function signatures to accept `struct repository`
and change the calls to those functions accordingly ?
