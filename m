Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E32D20248
	for <e@80x24.org>; Tue, 12 Mar 2019 17:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfCLRNx (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 13:13:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35323 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfCLRNw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id t18so3588092wrx.2
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 10:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=G2s9MOQZy3nMl/g2LVn72PxvP+l4nFjd+VtIyEF+Qes=;
        b=aaw9x25WXlRty2xSpkM6InnVrRM4wAwUrywWv9Nzt9IfWRP7Pp4yTS8quaLJ3nKDNt
         cvHRpErwZDFZYfWxWxq0gNS152pAcUtYIxHCvmEQx/EmZlOxyugSFAKAyvCBvFOD5Ch+
         mbx8dxQIkcXfGc1JGmMYNy/xdJ0VVEJH+cZQCrhKRyqrwA95BCKy4X4enya2/0V1uoPE
         7Myl4UFzIPrn5nrVxm8KwMz1l72Am+UVNbuJOxPNkVGrOETOQe3Yt77+YRQyEegCSVl8
         azXzIoF3MTfsRHyoUeFDRwpMrlOCuWXQKZWdLN2OArHSrUn20yJNHeC4rC5i8b0EhN/f
         9zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=G2s9MOQZy3nMl/g2LVn72PxvP+l4nFjd+VtIyEF+Qes=;
        b=q/j4pP10+sjp6WA3uPGx5NLPR7VbHkz5QP5pl+3dblXOUfDk/Gjugi+wjSPssOIIjq
         uws7yvrLWgqwtHvaLD3VVaG23eWfkdQ9rgImsltMymd/uM3lei32Ps8BTrcXH1wXLx10
         rtFI+QO5bwSXvCDHKZHVtVIQ5h7IUHrOiqrD8S/Rh1LalMvX9gkmawLVApTzDkakL8ct
         b9YxDlI1FdlOgTHpAJGZmSYdh9bpMip7lmprE/N92DIJWlmQYjWAxCYYnxWIGKW9XfJk
         7VRRh3+KNtMf3DBrf6q8tpuBjFYzQe+5/L/rdnJnjR8SLpBTptmCnLGDjWw8PFbinllK
         AF6A==
X-Gm-Message-State: APjAAAVZDowGMmvkTGuUCPx1hvPoUMzhJnD+8hCwUKXEogQgYqs79kBG
        olq7TwyBVQhIQYU7tkGOZ+E=
X-Google-Smtp-Source: APXvYqwKP2+lCKykJELKIvSgx4hgVafZZznTDkOs3lxQnsgg8EbsSYDek1agqNvgxZu7ioWTwXjvHA==
X-Received: by 2002:a05:6000:1110:: with SMTP id z16mr25036451wrw.28.1552410830407;
        Tue, 12 Mar 2019 10:13:50 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id b195sm5738553wmg.36.2019.03.12.10.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 10:13:49 -0700 (PDT)
Subject: Re: [PATCH 2/2 v3] doc: format pathnames and URLs as monospace.
To:     Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Git List <git@vger.kernel.org>,
        nathan.berbezier@etu.univ-lyon1.fr,
        pablo.chabanne@etu.univ-lyon1.fr
References: <20190306130446.2193-1-corentin.bompard@etu.univ-lyon1.fr>
 <20190306130446.2193-2-corentin.bompard@etu.univ-lyon1.fr>
 <86va0o9qsp.fsf@matthieu-moy.fr>
 <CAPig+cQEYDay9kTUpBepw6kN_PgpG4dRXeNf82Kty+E7piXeWg@mail.gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <8a8944a6-9559-74be-afee-e6af262412ab@gmail.com>
Date:   Tue, 12 Mar 2019 18:13:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CAPig+cQEYDay9kTUpBepw6kN_PgpG4dRXeNf82Kty+E7piXeWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-03-12 16:48, Eric Sunshine wrote:
> Thanks. A few comments:
>
> In patch 1/2:
>
> * drop the full stop from the first line of the commit message
>
> * s/futur/future/ in the commit message
>
> * s/There are false/& positives/ in the commit message
>
> * s/both, It/both, it/

Also,

* s/inconsistant/inconsistent/ in the first paragraph of the commit message.
