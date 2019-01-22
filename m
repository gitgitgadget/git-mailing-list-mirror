Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AEF71F453
	for <e@80x24.org>; Tue, 22 Jan 2019 18:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfAVSWK (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 13:22:10 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:33469 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfAVSWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 13:22:09 -0500
Received: by mail-ed1-f45.google.com with SMTP id p6so20174114eds.0
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 10:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w0Fu+vIF+Jb8aS1TbjKFhVvXWWJC1ot6HPbsf7TGDvk=;
        b=fggAHAX6HPKc8jLiZ9mJYVOdklwPTK8u/LYmVEi9yP/we7Bsl3FpyrgeG3iaZ6vMLh
         DdFsxycP862L9DO/r1nJaiKSjSiuOm5J++Jy5YzmaYFWVASs4QvkJ5p11hZHRV2JR1lx
         qZfZ38s+qVatSRDvqhIdvG/tVsOOWJr822l0nGmY8D+XV9GsLcIkeuDAMlVsmWd1nTYZ
         b7GkqVC1ihNNbeDKSynjYsHGDQqOGlsn1Y+1Afxw0eUQ0ji6Ui3HMoSKzCalPfr93jcb
         sflqglMob+VvhLY8CWUMSghu36/4lrcQcco6WRc7uTtXCRWQhvR6EJBQadBO1BcCZnLm
         8U7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0Fu+vIF+Jb8aS1TbjKFhVvXWWJC1ot6HPbsf7TGDvk=;
        b=P9dt2/dnOHGOz/e8PFlIV2K5uo4a+/3/KGNW3u4/EqsLKjbNN0QbDeObQLlYSbF7F7
         o7lK+gB5u4h0vk0adxG5X5VCXqGX9658wi+AFUnWZ0fKeZUXNpu2IRLrDgdLfSjWCnCR
         EhU4Bz8+pRKVwfmOoLnwtv1Q0KwANum+uBICaD1jZZDaCu7D9ritykndO4/ohJk8yQ0w
         BhK5E6CUTtaa9eb6buVaicM0c50P4MtTDnJitngnrGMjauLhEyaUYevNZNJTlsI/tc09
         LgwfK7lqdImB0/A8J+LPUT+nXkKrqHl9D5Abf66b1WtGZYce6E07ICxRYGMtoslP5mXM
         ma8A==
X-Gm-Message-State: AJcUukdk380a9kjb4gKPtzbfZ5sLRuFPXLtdsWQklaPd8IkbKYAoHPdm
        9fskgMRE052A0Non/B52tfeR/2J/pukuOgQ7db6gYA==
X-Google-Smtp-Source: ALg8bN76KdoxHPLhebAYi1fZgVpOFJpVE5JyxC6PgW6SKRI1ODENTzFL6WF3kYprbHVP5mfT24ZoTf5Uv4Z0Sh5w++A=
X-Received: by 2002:a50:ade7:: with SMTP id b36mr30827315edd.215.1548181327576;
 Tue, 22 Jan 2019 10:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20190122075027.GA29441@sigill.intra.peff.net> <20190122082647.GA31608@sigill.intra.peff.net>
In-Reply-To: <20190122082647.GA31608@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 Jan 2019 10:21:56 -0800
Message-ID: <CAGZ79kZs4azxZiVDi4hOOfr=+z12_DXhPYbM==h3EWAFxqtx4g@mail.gmail.com>
Subject: Re: Contributor Summit Topics and Logistics
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 22, 2019 at 12:26 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Jan 22, 2019 at 02:50:27AM -0500, Jeff King wrote:
>
> > There's no set agenda; we'll decide what to discuss that day. But if
> > anybody would like to mention topics they are interested in (whether you
> > want to present on them, or just have an open discussion), please do so
> > here. A little advance notice can help people prepare more for the
> > discussions.
>
> One topic worth discussing (here or there): the GSoC org deadline is Feb
> 6th. Last year's org admins were Christian and Stefan (cc'd). Are you
> both interested and able to continue?

I am treading lightly this year; if no one else is around I could be an
admin (definitely not a mentor), but I'd prefer not to.
