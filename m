Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725301F453
	for <e@80x24.org>; Mon, 22 Oct 2018 06:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeJVO6v (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 10:58:51 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:52868 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbeJVO6v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 10:58:51 -0400
Received: by mail-it1-f172.google.com with SMTP id 134-v6so10644181itz.2
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 23:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iatVGCVbJTYYjf94lb26rDahdednoE7LU+/dcy/QWiY=;
        b=F4P6unq6bqA0f9ykdrbla/PBK8PutcmzQ2Q6al1U2E8WKSm98VEN6VyHtiDTZFhoUc
         xIGSphVRpjaMl1OznddvqL16zqCP/hlFVqzOZqnmSiNXEIVbLAWW7oNWDWDHBJ66DdV/
         nsMzWf+phBPPSBJH/6Te7voborAL7qMd+1reSGh94HXHmaoJ7DkXtflNAA3rSRMTbxHa
         izKZAyowxw39ov7uhH1q2BYG4uDg+lmBOPGdZ9M18zPimnX6kmKybsj0Mb888B+x/UFW
         X/N5Af2HO+LHKHYSo5Ev6DHC2Czr2y3ISYhFBxXq/q7Sg4ut4NHFunqQMOLS+h4l0CO/
         hrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iatVGCVbJTYYjf94lb26rDahdednoE7LU+/dcy/QWiY=;
        b=lZnA9+m7S67qG10v4k6TFubpx2uaMUZqYUBSi5nnJobwL6FU+Qn01TC/T4x6bHKuL0
         PERqlEOSR0/uzACus6md0g97PZl1HRyMV8IhODy2Im+SGyy75TY9IS1VnXnda5ioW4ls
         4yvh/0OAG8g3OdKwHHepAVhHMLHSBRlcsKWSseFjYZiOTTwjQH2n7or4HAqgZ2HzhXD8
         NocD/BGjiReH4A7RHBiKNwqH+VDEZCMVrvkGRrWpbDdY0ODCMjR9pzgN1/bl0sFncsq0
         Qq91yqY4oKPUZUyelcA4DO/ZX48vbwEeCo+rSla6sPhwdQzz+NhZMxhrccycWP4i7UQv
         u7aw==
X-Gm-Message-State: ABuFfohh8FBRUfQMoAsdubYlq7G2kO2kl9o5TWOcKydEaPH8UkyAOBi2
        sNkE2nzNjhCSIfPn8WyuxB+c79sY/O0wVbHondM=
X-Google-Smtp-Source: ACcGV603UGyzQWx+i2X7f4iuZ7DqBgHQ2uw3elyqDaC03VT2BaX4iItXhsdia+EniWNL86KqUHFLnk5s9OR2MhI4GWw=
X-Received: by 2002:a24:f58a:: with SMTP id k132-v6mr9470300ith.68.1540190499914;
 Sun, 21 Oct 2018 23:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181022053605.81048-1-carenas@gmail.com> <20181022053605.81048-3-carenas@gmail.com>
 <xmqqin1uv78g.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqin1uv78g.fsf@gitster-ct.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 21 Oct 2018 23:41:27 -0700
Message-ID: <CAPUEspibPrTk-nG4iiKZD0Sx_hxqD0hTEhqMx0BdG_tPCLtEQw@mail.gmail.com>
Subject: Re: [PATCH 2/3] git-compat-util: define MIN through compat
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I agree with you; dropped
