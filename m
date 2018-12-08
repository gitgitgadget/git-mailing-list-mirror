Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A4FD20A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 08:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbeLHIZd (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 03:25:33 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44445 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeLHIZc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 03:25:32 -0500
Received: by mail-io1-f66.google.com with SMTP id r200so5130560iod.11
        for <git@vger.kernel.org>; Sat, 08 Dec 2018 00:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mky4tZfjLBthpVHxPZ9n7uPmvPuhdTiGe6YFtV3taXU=;
        b=JmRhvv7pS3js6KmyGxNr8g9tsUeF14/slEJCONhiAcFuRtwseDM39/+oDNTZA44nHx
         An2eFM+0BKt/JnI5yEuqPGwJnrLdliSQqbpEwD7SKqBydC4ww58ooHxPeImPm9xfu/4t
         nQ66vx0xYeTeOVgKnQKq0RuYVMdql5bq4W3n2rrrIkPTZytAmwYOF23l3OX2GC6Ojku8
         9uck8OL+iM59vIUmlBr96X0N44PljTMXdbmWdY54Ja+D9uNv8M+l1cxb6pmkTauauJLW
         G8T5TubXaL8zp6vOQGd5NRj2QCOyQUqdq+vv0K5MKKed1cVcy9s1mvNcztTaoQib5tjz
         fG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mky4tZfjLBthpVHxPZ9n7uPmvPuhdTiGe6YFtV3taXU=;
        b=UBETNcxf8Q5iXjq28Qx4en3JwSqXC2oRsFCZ1DedGjAvhjGxy3U1+1tef/JyiKTXAP
         WZpuwF7B25hR5yj6/6HimsMit/QmJlxc2tHBxOws7EEuHccOXhgQOGR1sP1XjxWtUOwZ
         dS40WE26d7iVzmx+XI3Wd9hgX+n+vsA75BvPoFGSkpxBu4TXmPBathnzboVlVtcUCJ2/
         L+xciFNeVamdUBH8bn6WXOet5btdA661bL4Yh0cV0LB21FMmZPz6pk3Z7HmCVLvziPcz
         6EgVxKFLPCAcK/l6O0CGENiTBuuiq044j5QrzumXbXjXVqAL60Ncaizhv+N6wPB7lLMl
         edfA==
X-Gm-Message-State: AA+aEWZ4MlqNt5Amvy/JhaQhiYfC4JeQmrcAXhWKm6ouMu3KZDYy80PO
        0m60w4dXqFSNmtiGDJ+7UJ48GtaJT9ZnlWh/fHE=
X-Google-Smtp-Source: AFSGD/Vo3Z2SqBBLLn7Q6R996RDiTvqlf9uQYl+Zi1T0eMamiqAtB4uRwDByPd7xopvLCC5bTvI3pI6nQJJmk+Wd5Wk=
X-Received: by 2002:a6b:242:: with SMTP id 63mr4207017ioc.118.1544257531181;
 Sat, 08 Dec 2018 00:25:31 -0800 (PST)
MIME-Version: 1.0
References: <20181207205621.49961-1-bwilliams.eng@gmail.com>
 <20181207214013.GA73340@google.com> <CAGZ79kYrgpZDqAhg8c11V_qJTCzzw4-qrVN2z_Y_OAeCbWU6dQ@mail.gmail.com>
 <xmqq5zw48s9q.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zw48s9q.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 8 Dec 2018 09:25:04 +0100
Message-ID: <CACsJy8D82Geu_qyeJy6Bt18GtQweV-_7oAr9HJVY81BEAxwWNA@mail.gmail.com>
Subject: Re: [PATCH] mailmap: update brandon williams's email address
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>, bwilliamseng@gmail.com,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 8, 2018 at 7:09 AM Junio C Hamano <gitster@pobox.com> wrote:
> If this were "Jonathan asked Brandon if we want to record an address
> we can reach him in our .mailmap file and sent a patch to add one",

Not sure about Jonathan, but I did.

> then the story is different, and I tend to agree with you that such
> a patch is more or less pointless.  That's not the purpose of the
> mailmap file.

Not directly, but when multiple commands use mailmap to show the
canonical mail addresses, then it kinda is. When I look back at an old
commit message, I may look up the author name and address, which is
mapped.

> Not until git-send-email learns to use that file to rewrite
> To/cc/etc to the "canonical" addresses, anyway ;-)

git-send-email does not have to when I copy/paste the address from
git-log anyway.

> I am not sure if there are people whose "canonical" address to be
> used as the author is not necessarily the best address they want to
> get their e-mails at, though.  If we can be reasonably sure that the
> set of such people is empty, then people can take the above mention
> about send-email as a hint about a low-hanging fruit ;-)
>
> Thanks.
>
>


-- 
Duy
