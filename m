Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80CF01F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 15:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934024AbcIFP5R (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 11:57:17 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33771 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753186AbcIFP5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 11:57:16 -0400
Received: by mail-lf0-f53.google.com with SMTP id h127so46384337lfh.0
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=zrJanMVya660v1TlwdrhLys+BjjwlGYwFhiTedi5GGY=;
        b=cBbwVl5ByMMLuBSnWdTi49oSXZD21j8Cn/87vQTP167Av6v/HHvGBFIukjYnQm2iT/
         EX1wv0g9Hs8YtU20HiuYgdgyAbG6IBk9tqZh9li4i/49Aa8VlRNvdYPtauG9iYI9Z8Hx
         RbqaW+VJSGtFEYBLkU23yqougGsECY6GJ9ozxc1HZuQeKQzl/lyoEM9fmhCgAIv9ml22
         gwTIKxYa3Nfq7zi7HboKPxj0x8QJUrKq38g2xBDQ6PBYoPQSZWI1uapev4QHihR4CVb8
         PUJall9rMRx9N4S2Rb1/PzisEHgm3i1zCoYKTSldU/XjEtyu0ZoypWG+o2cA/fOSV/+4
         /UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zrJanMVya660v1TlwdrhLys+BjjwlGYwFhiTedi5GGY=;
        b=SOhO3CMwmtxhesyJsACzm58jdLoW6nINTu3kkLSg28/4BVgGjjuZZh/CGw1TWrl5AS
         ePFy3VDyHmnwcR4VLNYt4wms4nb/sQOKV6uy6OKtEROMU78nRLi7i9HAdENPbH8zQv17
         N8SFhQbcdh6Bm/4/YkXAPJ9D3K71HzulytRhJHKpnucV6Bvo+N7KTAFnRRtCAqV1+NyF
         e4QzgVzFdgQnY4EpvimWX/gr1JMTeT8X5eyutpoA/kv1k7t4yqdb5m4L16xAnqVJpv8T
         xNWoABHW5XDJorpxSUxWlA34h3e2JFZa84YMnR1ca7n4z3Mny+57qrtgDqSLP04oL1qc
         41lg==
X-Gm-Message-State: AE9vXwMbo7DIW41Boqr+lvfga7ug1sJZNPOz/L9NssQ37/nMqULWCkixYiWtTw8e574C9wBJ+fYElPkre7j71A==
X-Received: by 10.25.20.24 with SMTP id k24mr5039612lfi.207.1473177434789;
 Tue, 06 Sep 2016 08:57:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.36.167 with HTTP; Tue, 6 Sep 2016 08:57:14 -0700 (PDT)
From:   =?UTF-8?B?SmFha2tvIFDDpMOka2vDtm5lbg==?= 
        <jaakko.t.paakkonen@gmail.com>
Date:   Tue, 6 Sep 2016 18:57:14 +0300
Message-ID: <CADr93XDA3CdgGBqBJTdmCHg_ZzGhsBf5hwwORJaCNB-V7o+APg@mail.gmail.com>
Subject: Windows Git will not start external diff at all
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I am using beyond compare, but it does not really matter which one
because even I create a dummy script as a external diff program, it
will not get called ever. Only internal diff is started.

Re-installing git will not remove the problem. I am using the latest git

Any hints how I can debug git difftool?

--jaakko
