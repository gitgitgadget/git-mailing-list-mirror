Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD3E820A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 19:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeLMTsx (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 14:48:53 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:50486 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeLMTsx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 14:48:53 -0500
Received: by mail-yb1-f202.google.com with SMTP id o13-v6so1645340ybq.17
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 11:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Vm9IXVM6gmJmC/fBiJBXYc1NZLYWPzSsuRF9mZHaTNk=;
        b=s0hHt38kTUL4QqAAvUXFQApj/WkYo/1910r+wt/CoyYPXIyTY3buuKVTku2BCW0hGl
         O+mqSLGGOE3xUrZ/M+2Nr1IWBiZRBUDRBwDGXT6bcuDcs2KiPwbybjDepy51qJYaGtTR
         iczGGTf/FMF3GD/x+xNZIngSxpgonUcoGsevSMLOtpuNp3wwcmF8pNg78SK0RHthmbJ6
         aZrTJDT1uNUFQcjF6nojD3f4n0rJ+xTHe3QxSvO4tc1XpywLSmTulNudjULObXYz6m0B
         XjX5XpRTEZveWTJN5nYqZqR5+gwRPdjaCssrEJd+f/U2yDXUvus/LUBkewkIvM9YkYLU
         TX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Vm9IXVM6gmJmC/fBiJBXYc1NZLYWPzSsuRF9mZHaTNk=;
        b=CSvFjd/7Xh7cweG6sb5sZvX/1YwjBROpuClV44/TTgNxa+qaeJ7AROXIJDBTkB6HTz
         /hmaWxo4AqTHbr62sxfDMXnCrBUEIpMjypAxgMHjU6y4IJ7wdJwJ4ob4GNPUa5wkwt6R
         /RN0uQQL9Hx6MNQVRdmvp7uANMVCncuqrW1Ll6EBytna8mIm+UcQciM3wp4gx+nsMPiv
         D+2Gj/5K8m6pGXuWZTbv/ZnPl/F7j1Pd1EpU+NftlMYn6qZWMulZrCXKpNY1C8FSK1Oc
         z7H4OWsqsPUt6WbI7c8YEmmYCm0OdgeDDFaBf84W5AY0i8j+ZjU1QdgoWz3of/xtvPO2
         tVAw==
X-Gm-Message-State: AA+aEWYKnfRZPt4SFmnkpNsef8jyWnmRPU1TBY0XIXebVO43g+ZNVjfD
        3hyfgIDyqjdh1C6WxYKuQoDx5AGcLGDVNvg2cvGU
X-Google-Smtp-Source: AFSGD/UZ0PcXXnErwAVMNikzNmeYZgYy6cfSTRto6uD4xteCmKQV9hedaYAdrrdsXP3/b+sHRyxNtwkfINjppoRAJHT4
X-Received: by 2002:a25:700b:: with SMTP id l11-v6mr72679ybc.92.1544730532724;
 Thu, 13 Dec 2018 11:48:52 -0800 (PST)
Date:   Thu, 13 Dec 2018 11:48:48 -0800
In-Reply-To: <20181213155817.27666-6-avarab@gmail.com>
Message-Id: <20181213194848.248308-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181213155817.27666-6-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v2 5/8] tests: add a special setup where for protocol.version
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        bwilliamseng@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Regarding the subject, I think you mean "add a special setup var", not
"add a special setup where".

> +GIT_TEST_PROTOCOL_VERSION=<'protocol.version' config value>, when set,
> +runs the test suite with the given protocol.version. E.g. "0", "1" or
> +"2". Can be set to the empty string within tests themselves (e.g. "env
> +GIT_TEST_PROTOCOL_VERSION= <cmd>") to unset the value in the
> +environment as a workaround for "env --unset" not being portable.

Optional: I prefer the "overrides" language used in
GIT_TEST_COMMIT_GRAPH to make it clear that any existing setting is
ignored. E.g.:

  GIT_TEST_PROTOCOL_VERSION=<'protocol.version' config value>, when set
  to a non-empty string, overrides the 'protocol.version' value. E.g.
  "0", ...

Other than that, this patch and the other patches (1-4, 6, 8) look good
to me. My patch 7 looks good too, but it's probably better if someone
else looks at it too :-)
