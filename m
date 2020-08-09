Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA71DC433E0
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 22:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8906D206D8
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 22:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgHIWjD convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 9 Aug 2020 18:39:03 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35766 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgHIWjD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Aug 2020 18:39:03 -0400
Received: by mail-io1-f67.google.com with SMTP id s189so7113256iod.2
        for <git@vger.kernel.org>; Sun, 09 Aug 2020 15:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zWe/sahL/E3tERdXFNSfE5sYC94SN+X8wnVp1JqHnic=;
        b=taAjFvRJADUhM4JHS5W7T3vRZq/GPLOkUysOu6I6jwKn20omt984y++THbnddqbd+D
         hSYDjrx+InWlN6xDsLXr77ZFjliW3qayAF7CqUjLQI5Os034lOnvSVmkNs2m2YpiW7Rs
         lDKMJAPVGmIhXGTljMNhV6lOLOE5CR2qoDxjDSstvZCPpTY8b9YdgPQtjzvGmtI3ADRj
         Psc4NZtYABdy+dQomRIDaTRssOr4a7s9gzyc4XkajeftB3KCvdW7dRzO+h7+8WYOjPzT
         6eNqUr/q8+e7Aja1ZPo07EHnnMQut7nGIb8RxzFRryn3juxz0nSoDaE9cNBWSH3HFFz0
         q7rw==
X-Gm-Message-State: AOAM530K9f5TsX3bPJllxQxjOzDcPYw8jsF46Dq7pHxC2+ptLTE+TjsA
        8G9wxfMjAHpgFfhhoyqaaHkTtmvz2ewPL4WYY70=
X-Google-Smtp-Source: ABdhPJxTDNtBbd50beI2WJcDghhtxP6/NcEFAtZ3NPywBjSfvduIvpMiM8fIDlMNABDkL5VRqh3Cz9P/7AXE5mzX/D4=
X-Received: by 2002:a6b:6c13:: with SMTP id a19mr15201317ioh.31.1597012742927;
 Sun, 09 Aug 2020 15:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy2muqddg.fsf@gitster.c.googlers.com> <20200805065408.1242617-1-martin.agren@gmail.com>
In-Reply-To: <20200805065408.1242617-1-martin.agren@gmail.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Sun, 9 Aug 2020 18:38:50 -0400
Message-ID: <CAPyFy2BzVD3omAHJx+etucVkGt3KnmURrJVXvhmmW9_JkPXTuQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] Update .mailmap
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 5 Aug 2020 at 02:55, Martin Ågren <martin.agren@gmail.com> wrote:
>
> Similar to a35b13fce0 ("Update .mailmap", 2018-11-09), make the output
> of `git shortlog -nse v2.10.0..master` duplicate-free by taking/guessing
> the current and preferred addresses for authors that appear with more
> than one address.
>
...
>  * Ed Maste
...
>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>

Acked-by: Ed Maste <emaste@FreeBSD.org>
