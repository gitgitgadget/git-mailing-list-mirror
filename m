Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6632520A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 22:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbeLGWLb (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 17:11:31 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42558 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGWLb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 17:11:31 -0500
Received: by mail-ed1-f67.google.com with SMTP id j6so4876169edp.9
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 14:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utPs60TQN49RyFBXma5gz1kIkL1+g4zRfASmsvHS/1U=;
        b=pe0XDKP4HnQtR/WOU5HN7kmQ/AbAhcEk6KgWto61Yb0zJwxxYvis4/yX+J18EszZYB
         a3pKOGcV05DL9ogcpoRNduyP/x7kDbHjQ14IxJzx5G0PQ31HW2X2aZ6IKOGQb84T/xE1
         Bv387mKXb1mCxKuwQmNfKYq+fqKND3G7px5IHUlowpRwLn+KFmFz7ayY3u9+0tM3Szdu
         vBlZ4wiRzkMHN6ERUAysjFxUDiAEFDBhIWvpwjuxVUiJw1CnGdb29toep9Y3/sOVkwlg
         BWc6+IGqoxy5D1k817k0nWkqlYS6a06tp69kUd8P0Faq/r7c8Am638mhBvqxh80kNf5M
         KpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utPs60TQN49RyFBXma5gz1kIkL1+g4zRfASmsvHS/1U=;
        b=bg/rtMWLilamTwH9YvPlb81frpLKNvFAPVQM+P7VczAbg2gSZ310MMxVKNpRV5jIMq
         nvknsVa+H6sF0gMZki8CkHr/x+cUDlVoGcdUTz5zOA8maz33LanvnuTcXL71WDamgrS6
         1W3ekQXJckNeVJA5S69/7Y08f/yUBA4VWpICdMafnMgQikpAdTNXk9tn3cAkjVwWWHzX
         z72SkFYpZHjeOsWg76n3h1GWcjqDyMVmiIbpOeHPT8sT9gAaVsIvM5+jaCo939WKmA+R
         9ZpItDavKzjWrfWYfl+oE6S/9GZQxnW2J4iSg30e7bm3FxSgRmU2xGMF2a60lV4r5tG1
         sYQA==
X-Gm-Message-State: AA+aEWZo6P6jl/zhCE6e1kSkHX7Q5rm0QPrXdmY3nINbkhP9bdUoqJoJ
        fExcgKoAS8mJInCNUic2L6DeJCgpAvsKlDSh4cR28A==
X-Google-Smtp-Source: AFSGD/V2uawrZJSgi1c4A+rWogbD+XUP3WZdlOC3DjEK95oKT2sXQzxSt6KZdVtC+c4hcZLSDqBm7RrJy+sjUgMCuAA=
X-Received: by 2002:a50:8343:: with SMTP id 61mr3638704edh.154.1544220689639;
 Fri, 07 Dec 2018 14:11:29 -0800 (PST)
MIME-Version: 1.0
References: <20181207205621.49961-1-bwilliams.eng@gmail.com> <20181207214013.GA73340@google.com>
In-Reply-To: <20181207214013.GA73340@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Dec 2018 14:11:18 -0800
Message-ID: <CAGZ79kYrgpZDqAhg8c11V_qJTCzzw4-qrVN2z_Y_OAeCbWU6dQ@mail.gmail.com>
Subject: Re: [PATCH] mailmap: update brandon williams's email address
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     bwilliamseng@gmail.com, git <git@vger.kernel.org>,
        bwilliams.eng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 7, 2018 at 1:40 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Brandon Williams wrote:
>
> > Signed-off-by: Brandon Williams <bwilliams.eng@gmail.com>
> > ---
> >  .mailmap | 1 +
> >  1 file changed, 1 insertion(+)
>
> I can confirm that this is indeed the same person.

What would be more of interest is why we'd be interested in this patch
as there is no commit/patch sent by Brandon with this email in gits history.

Is that so you get cc'd on your private address and can follow
things you worked on without being subscribed to the mailing list?
(I'd be interested to see the use case in the commit message;)

Thanks,
Stefan
