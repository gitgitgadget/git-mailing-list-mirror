Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61ED520248
	for <e@80x24.org>; Sun, 31 Mar 2019 06:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbfCaGlw (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 02:41:52 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41664 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbfCaGlu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:50 -0400
Received: by mail-ot1-f43.google.com with SMTP id 64so5705586otb.8
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 23:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tTmMcT0qvshc5/EZGJEvSZnqIQSB+LClpvwmqMzYO0E=;
        b=Bs6XtKiPXFZxSQfknzXagglS8KVAXKwMcEkHIU84PLyLOQPJQdCvol4s+/QVHo+g6s
         i6AmnJ/xmByEbjbHbnRwMfPOgLh5jfBXFGpVo64gtfdDc2IYWSFj1S9E0RVzFj6AnHNX
         68sY9U2IR3Wrd6qg35Lo8O2zWz11apYCgURWLSrlcIh/HMA76T7a+4JfVZeKd0Zr00LO
         McpteyCMJEjVC8a3WI8ohak40saRyWy2P+cEHDyCtzXWz+hB8fzrqjXsk007kvj7cXLt
         GfhY23tYkvkeOKN4DBCZ1wkETXnKNWxxckrOwNoWfjiz5NEUKE9Ukug6wp5tfEQaApVw
         J8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tTmMcT0qvshc5/EZGJEvSZnqIQSB+LClpvwmqMzYO0E=;
        b=og+6rItnC1zbWizikrMqsKJbsLghVWOjxC0vDAG5caXrC/TaGoXyZ6jfKKWcxbGVNH
         cgcgBAb/z0i2NfyVSgzDeY11HJBtfdxGfCdgxIumHY+qP2yksgdrJiUFDZ8scdI84SzB
         cbZ39bbmSqEFizKp6oAnSIbGcTUSqaMkiNap/msuwPSeBY684aJRoKqL8QrTrdF2tbER
         SHDzPM2PzPR0o3sn2P+mbpk+E5NrNpW7ozC02nKHcPvWVhwAbfDBz/WA6j03Qyc5Gacp
         1CMeALZUv2uVEfid0FhdrvxzjGVoMkMUU9nZHtnRkUNCykTY8QXTIGk3MDu7BLycMCMa
         OS9w==
X-Gm-Message-State: APjAAAXWSMhySby2DUQaEyCBhDkuYfRlMWIeeSzf0gA6dlsKSPFMcYGN
        PzAuO2BLpUH13bDD0uDM/5yodUI3VITJ4Zg6ETo=
X-Google-Smtp-Source: APXvYqy5W71/vqwdzP5j8u+f2vUEYZ2ySCEx9/QoB3+78fjVT1hg1t2KcNK/oO2W+kWvc+Iyqle15nv+wuFNrVmwrVw=
X-Received: by 2002:a9d:5c89:: with SMTP id a9mr32732604oti.12.1554014510161;
 Sat, 30 Mar 2019 23:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <8bb78ce0-9b32-7c49-e4aa-ce9f31662627@thingbag.net> <572677cc-eef3-345b-e970-cd6cc80e8e96@iee.org>
In-Reply-To: <572677cc-eef3-345b-e970-cd6cc80e8e96@iee.org>
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Sun, 31 Mar 2019 12:11:38 +0530
Message-ID: <CAMknYEP2m7fJ9o5dybEibmMwJJ9-wMStThwU0YN6f_QZzK=z=w@mail.gmail.com>
Subject: Re: Google "Season of Docs"
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 30, 2019 at 10:48 PM Philip Oakley <philipoakley@iee.org> wrote:
>
> * Developers rarely want to write documentation (it's too obvious to them)
> -- Our code base has become larger than the average brain-full, maybe
> that (developer education) also could also benefit from some further
> structural documentation.

by developer documentation you mean, a doc explaining what each function does ?
agreed, such developer education will help a lot.
i am currently trying to do that for `pretty.c`

> -- if stack-overflow is the go-to source for 'real' users, why not mine
> that source.

this point is unclear, please elaborate.
I mean stack overflow is searchable already, what kind of mining are
we talking about ?
