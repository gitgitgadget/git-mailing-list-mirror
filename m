Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D249620954
	for <e@80x24.org>; Mon,  4 Dec 2017 23:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbdLDXqM (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:46:12 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:35930 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbdLDXqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:46:09 -0500
Received: by mail-it0-f53.google.com with SMTP id d16so11012765itj.1
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 15:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZP1Reo42OGVKRM9wwDuku6qZyk3WSdf1vc1Z8eKNDUU=;
        b=W1ZjykLStQe4PmiYuryGA05IYKgMTAM2YHCeoQr/9Q38RWa/lLPfOWIBd65nMQG41u
         SeXJmuUe4p84IpKHpr+V/kfOIoJUqrCpSs5FZ2vO8gCrajqh8ySN2Mhc5tRjNsRt6P5D
         x/jz3fuGyAUgRvea/1Jifck7aKJkki6tiUz6iHkVGLmYjbL/Z8x12mvKTgfQKRORTUCq
         YUJ1TROYh+eVw36pt1yefslFOlKShWQO6yRYpIDdC4fGym2VeJGZre7ppXU21U83C9ck
         uQlryUoSeyLD8VGtMbLBQJbsyRy9sj+adHguie1GGfWX/rWYzS9OoWu0Kv3LSAcALA6o
         I0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZP1Reo42OGVKRM9wwDuku6qZyk3WSdf1vc1Z8eKNDUU=;
        b=XC+18719+PtyqLMD3o/Ch4ORlOc+napPr00gs1J4dHCbMxEyWKF8W5NHtBHYtipNPO
         6HeC0FHvAjCfqOwOci2/YbgeFAIzQbG6iawfpcC7CwDUPd2qn0rffvF74ELbx/r0zZvT
         Q7NmvNf7zE6AbgOv/6SqKJusiwSKns/vTgJxG5D0nBxOj/lFdvFs948GRtOiCTiD4GG1
         /SGtJdy8GN4ZYXAVc0D+qxJKimpFfjbPGfLGABXKFJSENKSjSGaJ+UdkZstTYR0PBS0t
         jLvCPtv02Q3jBl8Kggyh8VCHDdoBaIttR/mEKzoHwzjtUWdgw6bmQEC/CAdtqagnuRls
         w4KA==
X-Gm-Message-State: AKGB3mI6fhlaJ6+0pss9XiEUFf3CvLu8FFbf10nHiKSqUY8AbKYR3qKK
        HJwOxObQLmvdudRfnthWkAkKsA==
X-Google-Smtp-Source: AGs4zMa4V9rW5vjcgxkZvWRHqhL7aBbVhrSRr3ed5vk+p2AzVMlYSRaJCWXY+Lvbdv+UQScmFmHPRg==
X-Received: by 10.36.162.76 with SMTP id o12mr6940418iti.76.1512431168828;
        Mon, 04 Dec 2017 15:46:08 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:e1ac:91cb:ab21:275])
        by smtp.gmail.com with ESMTPSA id v65sm4412814itb.30.2017.12.04.15.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Dec 2017 15:46:08 -0800 (PST)
Date:   Mon, 4 Dec 2017 15:46:07 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: What's cooking in git.git (Dec 2017, #01; Mon, 4)
Message-Id: <20171204154607.2e29acc6eb269ce4c96ee9a2@google.com>
In-Reply-To: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com>
References: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 04 Dec 2017 13:46:43 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> * jt/diff-anchored-patience (2017-11-28) 1 commit
>  - diff: support anchoring line(s)
> 
>  "git diff" learned a variant of the "--patience" algorithm, to
>  which the user can specify which 'unique' line to be used as
>  anchoring points.

Is there anything I can do to progress this? Johannes Schindelin wrote
that he is in favor of this feature [1]. He also remarked on the fact
that the anchors are not freed [2], but I have replied [3] that it seems
that diff arguments are not freed in general (so there would be no good
place to put the freeing statements).

[1] https://public-inbox.org/git/alpine.DEB.2.21.1.1712011447550.98586@virtualbox/
[2] https://public-inbox.org/git/alpine.DEB.2.21.1.1711300134560.6482@virtualbox/
[3] https://public-inbox.org/git/20171130152605.1b775e9cc2ddd7f917424448@google.com/
