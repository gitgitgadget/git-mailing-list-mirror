Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E8631F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 00:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeK0Lbd (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 06:31:33 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39420 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeK0Lbd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 06:31:33 -0500
Received: by mail-yb1-f193.google.com with SMTP id w17-v6so8336280ybl.6
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 16:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccX9rQdsYN3olgtF/yhtlc/UcocSi0ba0Pq1htsfLXQ=;
        b=gT+AoM0KHlIt/rSq1oE3Puio/x3PPfMcsk1jW3m1asx9qBzIEsG+8NKCN3xhIiWvfk
         37t5VS9qAQOJRXRnFTyzKa9uYDwbw+Paumb83UBxuXFARDt5C3yGd8bqOL/RrTwXdZA7
         ygzyOWCU4NPxP4jpNaL9Odw+sBvhPKfxEfbTGZezb3Mn74gR1aIrzV4rF7IvSc7ierT0
         NpmLhe6KP9N9Xsl81bajLWfrNEmgQvaPlQ3KU1Qss1a0adVNus333eKDOS7PQ3/iq+56
         eWgdvGCJP5vDvhKIrCUlloiIlDv7bAJapltzPY/Ojkti9OkCcFS0ocLRI26SSNeV7isO
         q49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccX9rQdsYN3olgtF/yhtlc/UcocSi0ba0Pq1htsfLXQ=;
        b=gNYwRHhh1sKw9LZ9G261BpKBo08WlLF1KF73it+vaQ2zbBbgTJF2KU234UYOz+S0cl
         ZziyNs51Z2sWk6MdBnPUbb3+74M+lQIcinee57wgmVkrjt8at8SyM0ZKgkkC8lSexQwK
         xkBFhcerdMN3EH9rfjLkKp8q4GgZZp/plBmm35z+tX85RDMzCIaUyZTI9qV7UkIFuuWJ
         Xvgt4OpRQ0mWMVfE6mu2UVg/H9e56UVO5H1R6FhEgn78hR9X/WRAqGM9s+86ukVvI2CG
         oLRbcuQ1k/VyAdJzz5aug03XLRmJzJyZyLM2p6JvB1Pk7Ggl2TE/hw9rVitBNHUk6gwF
         XZpQ==
X-Gm-Message-State: AGRZ1gL6peXGiWRwxBwrJpzUopug48gBdhh9RAmyOb2hRAtfk/ZMPgff
        Znx8MvniPVFpG2A1YL+jBzZDocOE0gbK7qzvvHG+EJcc+tc=
X-Google-Smtp-Source: AFSGD/ViQWiZac+2nBCRe3LyZD9gx61jaXQe3BtT6q/Zwf4bbrxyZns25n/rRsR+UdvXIgSO4jHdyDmGeXte8nID0/Q=
X-Received: by 2002:a25:952:: with SMTP id u18-v6mr31028137ybm.464.1543278933768;
 Mon, 26 Nov 2018 16:35:33 -0800 (PST)
MIME-Version: 1.0
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com> <20181126173252.1558-1-tboegi@web.de>
In-Reply-To: <20181126173252.1558-1-tboegi@web.de>
From:   Steven Penny <svnpenn@gmail.com>
Date:   Mon, 26 Nov 2018 18:35:26 -0600
Message-ID: <CAAXzdLWBSD5coxqbyRN_d9B1e4AA-Q6VQ7iRo8BPuhBKDicMRQ@mail.gmail.com>
Subject: Re: [PATCH v1/RFC 1/1] 'git clone <url> C:\cygwin\home\USER\repo' is
 working (again)
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 26, 2018 at 11:32 AM wrote:
> This is the first vesion of a patch.
> Is there a chance that you test it ?

I can confirm that this fixes the issue.

Thank you!
