Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 527531F731
	for <e@80x24.org>; Fri,  9 Aug 2019 11:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfHILQx (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 07:16:53 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:36755 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfHILQw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 07:16:52 -0400
Received: by mail-qk1-f169.google.com with SMTP id g18so21958qkl.3
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VoS1nQfxZq3SDgeWQ4dBJW731WF/HpdeIgHWnltCoaI=;
        b=Q5gmgVCoOxbX/zgm98SvJ53YzhSt4qgnORIdT6E2ZRw5n5XNH4shGMd8AgZ5pwLkFy
         ihNVl0P9ho4KB+tWOcpEV4nayLosGTV0T94PEoCWWZ9m7Pv78nK4qhxu+lVyYK+d34Td
         y9c8PtHOmIjpKKC8Xf8kS9Cwb2+aNOi6A8PaYUftUrV7Y3MvjIWJHJvjMoSPU9wnzeAN
         MW8nAEFz7zeZspnrJ9PZP/CF/8KjeB6QdUPh6FGa+JBWOi9Tzyg1DyYw8DbduaAaWuB+
         KCFdYOGa7Y0Mt9PluMmUNi7532aSMteE3Onsw+tUxvToU0qHeq9cPNwcDbFs3E4WXnKA
         GWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VoS1nQfxZq3SDgeWQ4dBJW731WF/HpdeIgHWnltCoaI=;
        b=TqHMsziJ/3haSBRSIqM0fmiBiIMEcNht849EnRGPmSEYpOzWKhCbzKaqeMRttzyYKf
         TKP97Gfg+nATuRydp0eH6gzYxYXAax2YRtWTbrC9tjFXlKCFUc2R6ZSJNxNnRqORgsEK
         AZuVsAR+phIWx+/aNre6PmUHolxEcXqfz6fxoS/JtjYwZar6kYCtU82pDQbk7n1/jqPE
         fl1VhtCknNZGW4CIGSYP1nvKtsJFz5iDIA7UF5NTrpiucbkVJanVLNyQutOICa6v3laR
         uj7sxG88+Q7oZyoTPgk9zrxQ+zeB/dY5FcetJX9LQ5U/dFT7mmoh5vzlxbg4Tb5abLdl
         Vc2Q==
X-Gm-Message-State: APjAAAW+BfYxiKabx82Tubah5a/SvD2vVlGjq4VuwuQLuelXn+F+lvCO
        yPXp02XlunFLn3nHQ+P6OrAF485eoqk=
X-Google-Smtp-Source: APXvYqymEMV8ggyqdusSNG9r5wVtbemnvLr0B23eOemLUVWIb2Q9jVxx4UXYHwQ7AcNC7ArAIvKbfg==
X-Received: by 2002:a37:7005:: with SMTP id l5mr17649560qkc.80.1565349411612;
        Fri, 09 Aug 2019 04:16:51 -0700 (PDT)
Received: from localhost ([50.49.245.163])
        by smtp.gmail.com with ESMTPSA id c15sm3326677qkm.32.2019.08.09.04.16.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 04:16:51 -0700 (PDT)
Date:   Fri, 9 Aug 2019 07:16:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jadian Radiator <gazbonicacid@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git For Windows' installer can't see my Atom installation.
Message-ID: <20190809111649.GB93559@syl.local>
References: <CAMCV-8avBaFCuYoX8asmoHX_p_dvj_o_WrQrSj_GtNJK0AROuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMCV-8avBaFCuYoX8asmoHX_p_dvj_o_WrQrSj_GtNJK0AROuQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jadian,

On Fri, Aug 09, 2019 at 12:31:12AM -0500, Jadian Radiator wrote:
> Git For Windows' installer can't see my Atom installation.
> I got Atom directly from Atom's official site.

This is the Git mailing list, which does not answers questions about Git
for Windows, or Atom, both of which are separate projects. You can find
out about the support of each at:

  - https://github.com/git-for-windows/git/issues, and
  - https://github.com/atom/atom/issues

> I think git can't see it because of this unfortunate fact.
> It doesn't let you choose where to install,
> and it installs to your appdata folder.
> Any idea what I need to do?

I would recommend opening an issue on one or both of the above and
getting the recommendations of those project maintainers. Thanks.

Taylor
