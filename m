Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9DE21F453
	for <e@80x24.org>; Thu, 14 Feb 2019 19:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405055AbfBNTEd (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 14:04:33 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41384 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfBNTEd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 14:04:33 -0500
Received: by mail-qt1-f193.google.com with SMTP id v10so8119321qtp.8
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 11:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QKoaT7c1v6UotdlCS8qx4qvC87aur4OGI7ptsF6wn/A=;
        b=Lng6ZMRgZDYO71IcNAi73J6pKzzshb1lE+MThspdvfv6ClXvMO8RZuuWv1mNHEf0h3
         k43yrtY9Fi8a2BNB5cYpVHWn9OsM54FG1be8Ft0dlmKzVZ1iiBWlA2teByhFVMc+Ah56
         Ifytcori1trqEuCC49oa2+isUmOVFBOzNvpiwoP/BZPkzgRA0uX+h1oSDLuJBcG9LWH7
         XZ9UEPPxFtPzIXyte04YhjnfcaC1Okj9kiZ6pbz5ZZBRon+1/9Z6faIGh5/BPQ2P7AF6
         PAFAhPmdJBp3vliT1ZQJNRyCltSKPyJH1BMiEdtNSOfL4rSGWBlddFvkAljr+gvulgcu
         s5tQ==
X-Gm-Message-State: AHQUAub/I90tv6q6rCZqyWSAHGrnq0JUw9B2gnw57t8n8pmKC5kDMHBh
        lUgstETs6s765TuVpQb02H8t+k6in/LqT8XOw2E=
X-Google-Smtp-Source: AHgI3IbOGsGcfB1h9JBQJgcRIgx9DD/EHtCfreNpclE1lXzv1ruurofXNT1A84Q0PALDra7ygD9TtPw7t8qLzt8c8rI=
X-Received: by 2002:a0c:eac9:: with SMTP id y9mr4220813qvp.82.1550171072575;
 Thu, 14 Feb 2019 11:04:32 -0800 (PST)
MIME-Version: 1.0
References: <20190214163043.7103-1-corentin.bompard@etu.univ-lyon1.fr>
In-Reply-To: <20190214163043.7103-1-corentin.bompard@etu.univ-lyon1.fr>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 14 Feb 2019 14:04:23 -0500
Message-ID: <CAPig+cSkpUCm0=TZ-T2Lv5F0bxhGhyMMS6Nxj42JFbNupgpf0A@mail.gmail.com>
Subject: Re: [PATCH] doc: format pathnames and URLs as monospace
To:     Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
Cc:     Git List <git@vger.kernel.org>, nathan.berbezier@etu.univ-lyon1.fr,
        pablo.chabanne@etu.univ-lyon1.fr,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 14, 2019 at 11:32 AM Corentin BOMPARD
<corentin.bompard@etu.univ-lyon1.fr> wrote:
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
> @@ -107,7 +107,7 @@ Initiating the upload-pack or receive-pack processes over SSH is
>  It is basically equivalent to running this:
>
> -   $ ssh git.example.com "git-upload-pack '/project.git'"
> +   $ ssh git.example.com "git-upload-pack `/project.git`"

This is already formatted as literal text using a monospaced font.
More importantly, however, it is meant as a literal example of what a
user would type, so changing the quoting is undesirable since doing so
actually changes the meaning of the command. Therefore this should be
dropped.

Also, there are several other instances of this example command just
below this one which you didn't change. It's not clear why this one
was singled out.
