Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBF5C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 16:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8176F204EC
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 16:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w11dmQ3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgHJQ3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:29:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61308 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHJQ3y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 12:29:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 511EB85988;
        Mon, 10 Aug 2020 12:29:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2+G/cQZ7yIYyE7y9aZfhts84iiE=; b=w11dmQ
        3wGXmCcdumYQQnaK7Lo/1jFZ9P5Kc9k71Lq6ANfVmNC/IND6B+lAPWgzvm3tmrz5
        Ff6unVvKOAni54bnOdtjNJuq909sDXD+TFUVj7vS/k7Rj8xsHUCSdXDHJIVcTyBq
        D0kColSt6iQCQh0st0RS9/SDw2RVx0FcKJHBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nig08cVPuqc2RU/aKzxG3c35LCQzzNqu
        wMIPgflOJ68SbmgTYZ1uUA8nx/kGkdaLtRaixjtvch7oQwqkA5oiktWtkRi+jR41
        0cImfbz62O6utWmwwAQJoCcmGATpfNtFWHO21Pa0ZdzlHWaPngugQ0+PQd0+Brz7
        3LLCzxk4rWE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4841185987;
        Mon, 10 Aug 2020 12:29:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF7AF85986;
        Mon, 10 Aug 2020 12:29:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Adrian via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Adrian <adrian@planetcoding.net>
Subject: Re: [PATCH] ci: fix inconsistent indentation
References: <pull.823.git.git.1597048659983.gitgitgadget@gmail.com>
Date:   Mon, 10 Aug 2020 09:29:50 -0700
In-Reply-To: <pull.823.git.git.1597048659983.gitgitgadget@gmail.com> (Adrian
        via GitGitGadget's message of "Mon, 10 Aug 2020 08:37:39 +0000")
Message-ID: <xmqq5z9qcvlt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6A9BEA2-DB26-11EA-B57A-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Adrian via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Adrian Moennich <adrian@planetcoding.net>
>

Here is a good place to explain what you consider consistent and
inconsistent ...

> Signed-off-by: Adrian Moennich <adrian@planetcoding.net>
> ---

... because ...

>  jobs:
>    ci-config:
> -      runs-on: ubuntu-latest
> -      outputs:
> -        enabled: ${{ steps.check-ref.outputs.enabled }}
> -      steps:
> -        - name: try to clone ci-config branch

... the above is being very consistent.  All the direct children of
jobs.ci-config like runs-on, outputs and steps are (1) indented more
than its parent (i.e. jobs.ci-config) and (2) indented by the same
amount relative to their parent (i.e. 4 spaces).

Apparently, that is enough "consistency" CI system wants to see.  If
you want to impose extra "consistency", that is fine, but you'd need
to be more explicit about it.  Perhaps like

    All other parts of this file indent children from their parent
    by exactly two spaces, but direct children of "jobs.ci-config"
    hierarchy were indented by four spaces.  While it is not an
    error, let's be more consistent.

or something?

> -          continue-on-error: true
> -          run: |
> -            git -c protocol.version=2 clone \
> -              --no-tags \
> -              --single-branch \
> -              -b ci-config \
> -              --depth 1 \
> -              --no-checkout \
> -              --filter=blob:none \
> -              https://github.com/${{ github.repository }} \
> -              config-repo &&
> -              cd config-repo &&
> -              git checkout HEAD -- ci/config
> -        - id: check-ref
> -          name: check whether CI is enabled for ref
> -          run: |
> -            enabled=yes
> -            if test -x config-repo/ci/config/allow-ref &&
> -               ! config-repo/ci/config/allow-ref '${{ github.ref }}'
> -            then
> -              enabled=no
> -            fi
> -            echo "::set-output name=enabled::$enabled"
> +    runs-on: ubuntu-latest
> +    outputs:
> +      enabled: ${{ steps.check-ref.outputs.enabled }}
> +    steps:
> +      - name: try to clone ci-config branch
> +        continue-on-error: true
> +        run: |
> +          git -c protocol.version=2 clone \
> +            --no-tags \
> +            --single-branch \
> +            -b ci-config \
> +            --depth 1 \
> +            --no-checkout \
> +            --filter=blob:none \
> +            https://github.com/${{ github.repository }} \
> +            config-repo &&
> +            cd config-repo &&
> +            git checkout HEAD -- ci/config
> +      - id: check-ref
> +        name: check whether CI is enabled for ref
> +        run: |
> +          enabled=yes
> +          if test -x config-repo/ci/config/allow-ref &&
> +             ! config-repo/ci/config/allow-ref '${{ github.ref }}'
> +          then
> +            enabled=no
> +          fi
> +          echo "::set-output name=enabled::$enabled"
>  
>    windows-build:
>      needs: ci-config
>
> base-commit: dc04167d378fb29d30e1647ff6ff51dd182bc9a3
