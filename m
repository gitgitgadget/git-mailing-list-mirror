Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D85711F453
	for <e@80x24.org>; Thu, 14 Feb 2019 20:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394289AbfBNUKV (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 15:10:21 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:43486 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387507AbfBNUKV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 15:10:21 -0500
Received: by mail-yw1-f73.google.com with SMTP id r8so4448276ywh.10
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 12:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=p4ABS653p+V6oC+cUhyF+1zJeHGP1oZAbiJQtGF6arQ=;
        b=bHkWtw4flMg4rhan4mwIXsYxRbEJUDJzNZ63f8DSR8VShi0Kfnwm6Z9s3og7F61t10
         mARd1SaVpFgN74DVvdvoC4A4R+8F1jwPGWy/H0+S7OMkxFODrKu9/cAdBMlOCAIExfuT
         IkpZAyVBXgOTAIvdl6wcyDLU56GHxQnRt258lGZC1k3HaetDRilNHS9sY8SRLtbthaF1
         52vc4fC3rmFMNzjOqQR/EcCloqnZj75Z7P8oK5kk1bGVAipuKADb6syDAZ4sabR/XbeI
         5Ij5j5QRGK84lYwnCyzoy+P2TTgYFwoADKLMW9JcJkDBHtSbayhneJHcbWrS0qPVe6wf
         NVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p4ABS653p+V6oC+cUhyF+1zJeHGP1oZAbiJQtGF6arQ=;
        b=bbLu09tcA8IgpapUsg2yOs0G/owjYvv/xkaYeFt/BnP7N5sCAeONzu+xVaIddbSnNU
         p5f6V6bqQ5eCMfbQP9bg8gZalvxMYRZTWnqJR/BRHOE9k+mLe0kEydg2NKw6VDcLldyo
         2tArKJNQT6qFCOuazeimzEpq48aRt/H3MEC+dY67Q1y9V1CU98icXFNkJmqo/fy23XqS
         HNo0uPVj712I5E8hal1S/Lolo2TnPOVe+OUY83dx6denISStfhdAyDCj/ebqtEd90/44
         Qr0al5kQKnhcPLF8Pj9a/aer0K2vBA60dxCB9469937rdEw+u4bbNTjFj1JFR7/WNn76
         AMcw==
X-Gm-Message-State: AHQUAuaRIDRzmAqlpFAMzhHtiqcpAJa15sf9Xq5lC5Yz6X7TwUaMLswF
        MknJX0Z1tpgBzQhArAgXmIJiJnsO+6+daY2DTt/x
X-Google-Smtp-Source: AHgI3IZUXw98SBDsMwaUwP2qRISNsOrZ+R1RLsTXhGGCKI49vkm+4SRZFCWfC23GqruW0JWRdPiQ6NV997moXLwZ5ulA
X-Received: by 2002:a25:288:: with SMTP id 130mr2602521ybc.22.1550175020700;
 Thu, 14 Feb 2019 12:10:20 -0800 (PST)
Date:   Thu, 14 Feb 2019 12:10:06 -0800
In-Reply-To: <xmqq4l979h8d.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190214201006.127960-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq4l979h8d.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: What's cooking in git.git (Feb 2019, #03; Wed, 13)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * jt/test-protocol-version (2019-02-06) 9 commits
>  - remote-curl: in v2, fill credentials if needed
>  - t5552: compensate for v2 filtering ref adv.
>  - tests: fix protocol version for overspecifications
>  - t5700: only run with protocol version 1
>  - t5512: compensate for v0 only sending HEAD symrefs
>  - t5503: fix overspecification of trace expectation
>  - tests: always test fetch of unreachable with v0
>  - tests: define GIT_TEST_PROTOCOL_VERSION
>  - Merge branch 'js/protocol-advertise-multi' into jt/test-protocol-version
>  (this branch uses js/protocol-advertise-multi.)
> 
>  Help developers by making it easier to run most of the tests under
>  different versions of over-the-wire protocols.
> 
>  Blocked by js/protocol-advertise-multi

If you don't mind, remove the last patch (remote-curl: in v2, fill
credentials if needed) from this set. Peff noticed some issues with it,
and I have sent out a separate set [1] that better fixes the issue.

Peff also noticed [2] a minor issue with patch 1 - I used
strlen(git_test_v) instead of *git_test_v to check that it is non-empty
- but that might not be worth a reroll.

Other than that, this set (with the exception of the last patch that I
asked you to remove in the first paragraph) looks good to Peff [3] and
me (besides being blocked by js/protocol-advertise-multi).

[1] https://public-inbox.org/git/cover.1550170980.git.jonathantanmy@google.com/

[2] https://public-inbox.org/git/20190211201959.GA9072@sigill.intra.peff.net/

[3] https://public-inbox.org/git/20190211203827.GA9010@sigill.intra.peff.net/
