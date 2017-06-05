Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 109D31F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 21:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbdFEV2I (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 17:28:08 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36188 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEV2H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 17:28:07 -0400
Received: by mail-it0-f51.google.com with SMTP id m47so75636306iti.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 14:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P/XoM0iO3STMBV1ebXMXFXBNpkrgICcmMLb0eIzzVJQ=;
        b=omCpKxf3tbWQTgqTqRznLwyN7HLMwkfXDbUjoCbAKtgpMKwt+tS+0u0j05poLfnckL
         SjlivMBGLmez96iqw7OFS2Jf5E/PwAwAhBpXR7L8VtQ6OW5zcDAucYq4ZgRKl3LBbvSP
         rVIOrDsLH4NqpSXuJrq2kQRhD9Ke9pi4aFnl+BmrPToKuMtF2AzVFrnY9nVoa5XomCnk
         FDHZdYTy2GeUq6Lm4bK/GUbBEzOWQ6cU+92EQZ5OwOuLB9cFcQ9wUm98JxoxWU13lC6V
         4R+FXKEMeYQaybRHH0tIC4pNLNg5BN/R5KrmwGy13LSi77XYqWc8TId8WiChrnk8tEQz
         hDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P/XoM0iO3STMBV1ebXMXFXBNpkrgICcmMLb0eIzzVJQ=;
        b=ALOYtSrckUeAgXmgmZN1ZmljUq5i2S9Ii7YfxTOiifIvQsx1FVzDyaTQZu16OsJElC
         h3MCoPQpc/tSOgtR8nIO8ZtkorearT5fPhQzGvS3OdTWGbMQNRW+9rvVsBqjN6IknKSd
         RTJG+J8WoblnevihDDqto95WoZOMfMmful1lDatSQKg9lNyOVt0ImnIhfcnPWtcQgRsM
         ZEid+kqS+osQzZAgde6Uw9E1sgA9vD+OGFvc7pHXcrdGVs9Z0HgcitcIqac7xPsoHv//
         hj8dpRWK8DCOMCvoOqUlXZ+e+vg2ln7qDliFbF4/3lWUTdJxJW67sqptVdnt5rWK4Kp6
         VMJA==
X-Gm-Message-State: AODbwcD1SmLaVxhie0STWW6wpNhIyX4JRVjHIID5cIfTANfGK3YF5LRz
        JyG20TJZ0kWSmGoHCCwDizvfcxm9KQs/
X-Received: by 10.107.201.213 with SMTP id z204mr2862902iof.160.1496698086385;
 Mon, 05 Jun 2017 14:28:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Mon, 5 Jun 2017 14:27:45 -0700 (PDT)
In-Reply-To: <5935C999.5060801@winserver.com>
References: <5935C999.5060801@winserver.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 5 Jun 2017 23:27:45 +0200
Message-ID: <CACBZZX4t+dJA-G9r+LuskmkpR5oR7+YMUSCZgL3GCgPcKkda2Q@mail.gmail.com>
Subject: Re: Git "Keeping Original Dates"
To:     Hector Santos <winserver.support@winserver.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 11:14 PM, Hector Santos
<winserver.support@winserver.com> wrote:
> I'm implementing GIT.  If there an option or compile/version that "keep"
> file timestamps?

The git datamodel stores files as a list of names and whether or not
they have the executable bit.

If you need to set the ctime/mtime/whatever on the other side you'd do
that via some script you'd ship with your repository.

This may not answer your question, but it isn't very clear.
