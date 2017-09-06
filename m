Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F39C41F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 21:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbdIFVbv (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 17:31:51 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:33779 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752643AbdIFVbu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 17:31:50 -0400
Received: by mail-yw0-f180.google.com with SMTP id s62so10115938ywg.0
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 14:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HqhM2xZSP8sQPsJ9/j9BWlWZIrW7FWAkRQu+EGg+UA0=;
        b=NyBK3RlCBcebFPHOLElUyMHmr3s8/q2A+9lUIyerJ/+fkqDC1V+H5EP3EvhdCE9WB+
         A9h7P84osDDHDtG3+v0e5jPFr5lqpxd5/HBGhKjAJSbgv8xofgrj9GGrt/AdL8BuaiOi
         SBUW8ViTL4vhjw+SvMT7D3LmuAUc/2BTyrBjUEywu0ekv1oukiIwwLKIH9fQBsMwKOHX
         VCMBfe0HLdTFkWmXSKNfpNcHglEReS0hGY0+9UYWIt/S7oIG85qgOSFuRpPouTKdpNvf
         1FxA082+nN9Cet3XsoFI80x/709H/hq6YHdlbeDG0WXbF4H6RMwEh2TJPfGkr7meTkly
         miFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HqhM2xZSP8sQPsJ9/j9BWlWZIrW7FWAkRQu+EGg+UA0=;
        b=CJkN1pqjakK33uzCNjezF/Auq/OOMeidcKg8PO2JIJa9XDnJY/nOPmW4dGGYn2p1SP
         RzaRPzBPbMQ08QX17a5WXJSXzNHfVocxQC/QQ9kQOOv/vua1tbujK+dyG4pixu8hKDEN
         7rYCRSFLgVFTr0u22pPZeQFhrZXIXfLXQI+76cuL3gfKagvvBh0bZ7wmlw0W2V3nMyYv
         edMm3pzjY1hBJjYkKkX+R6OY6ryZ6UyBTrfifDivztPqfAuCoiZPetRK1HU/krf1VLe5
         styliJQ2oZ/2KsfnP61fn5CFRuP3k4ej544Ag9Ej8DepX68HhlMr4TfxH8DiRSDhYP84
         NbeQ==
X-Gm-Message-State: AHPjjUhvIvywYxDQc9ACnI4KowUHXcXqcTmRIImnH/KAExxU0ri8AB2f
        A8HTr7UnQOrGypOC5jJmE44mV2+n1374
X-Google-Smtp-Source: ADKCNb49yPIgcHQKoykKKUAIDpMDUHkHI70hUJXBv14c0j5U485X08zPYJN6cpEe0er/swsrr41APnO7DQM5U3t0LtU=
X-Received: by 10.129.211.3 with SMTP id y3mr445395ywi.422.1504733509880; Wed,
 06 Sep 2017 14:31:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.116.7 with HTTP; Wed, 6 Sep 2017 14:31:49 -0700 (PDT)
In-Reply-To: <20170906093913.21485-1-root@shikherverma.com>
References: <20170906093913.21485-1-root@shikherverma.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 6 Sep 2017 14:31:49 -0700
Message-ID: <CAGZ79kbxDh11KxrKCk_VjmN06kzp7x4iVO6XTV=a-qBmm39K5A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Add named reference to latest push cert
To:     Shikher Verma <root@shikherverma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Santiago Torres <santiago@nyu.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 6, 2017 at 2:39 AM, Shikher Verma <root@shikherverma.com> wrote:
> Currently, git only stores push certificates if there is a receive hook
> present. This may violate the principle of least surprise (e.g., I
> pushed with --signed, and I don't see anything in upstream).
> Additionally, push certificates could be more versatile if they are not
> tightly bound to git hooks. Finally, it would be useful to verify the
> signed pushes at later points of time with ease.
>
> A named ref is added for ease of access/tooling around push
> certificates. If the last push was signed, ref/PUSH_CERT stores the
> ref of the latest push cert otherwise it is empty.
>
> Sending patches as RFC since the documentation would have to be
> updated and git gc might have to be patched to not garbage collect
> the latest push certificate.
>
> This patch applies on master (3ec7d702a)

What are performance implications for busy repositories at busy hosts?
(think kernel.org / github) They may want to disable this new feature
for performance reasons or because they don't want to clutter the
object store. So at least a config option to turn it off would be useful.

On the ref to store the push certs:
(a) Currently the ref points at the blob, I wonder if we'd rather want to
    point at a commit? (Then we can build up a history of
    push certs, instead of relying on the reflog to show all
    push certs. Also the gc issue might be easier to solve using this)
(b) When going with (a), we might want to change the name. Most
    refs are 3 directories deep:
      refs/heads/<branch name>
      refs/pr/<pull request nr> # at github IIUC
      refs/changes/<id> # Gerrit
      refs/meta/config # Gerrit to e.g. configure ACLs of the repo
    "refs" indicates it is a ref, whereas the second part can be seen
    as a "namespace". Currently Git only uses the "heads" and "tags"
    namespace, "meta" is used by more than just Gerrit, so maybe it is
    not wise to use "refs/meta/push_cert", but go with refs/gitmeta/pushcert
    instead?
