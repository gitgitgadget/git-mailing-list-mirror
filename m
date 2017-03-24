Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C6DC20958
	for <e@80x24.org>; Fri, 24 Mar 2017 00:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933674AbdCXAwy (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 20:52:54 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33976 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933467AbdCXAww (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 20:52:52 -0400
Received: by mail-pg0-f48.google.com with SMTP id 21so147941pgg.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 17:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FTNB1C7LubY8mgZenhSRd4y7FcSe928j7FMV1fQqZ9o=;
        b=DGCKRSpc8Jjfspc2WuwbyHHDgI+fvGlFl1kx/J1BmPeCyrakyrARk6isETiSyYs206
         Z/bjDmothf7K0XKfvF0NEuBvMVnUDAV5CoYhTHG3/jhIOtX8oPaJSCREPTs2maEaHnyE
         53OvKmMwirh1KwmYKLq7UbF8qs41kWfMwPWWUseBH2uhKHVzP5qwpj/7TF53WK1LdZS0
         BtRjCaVaITUlKwvxqX/O6ysiQmNeOnlZjLLbCS1hb7LjBV0qjsTX8ajeMqaflqQhVbIO
         GJVTQmRj4O691ebe2iYfxInfAT9EhXqbmINhH430Y4RfzAM9OSYqDZ9GfOjJJ64LvAMD
         6V4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FTNB1C7LubY8mgZenhSRd4y7FcSe928j7FMV1fQqZ9o=;
        b=jwg9QTPPqWyym19m8jfewyjAl3/lpjjdyAzvFppzHqDMw14TPrxXDAYue5Z8K0okEQ
         xDIwLZtaiE5i6wy3TffkQMG7yV1DI/yAdmlyoLW42NtBfC/CaU4cFbftAWTuvRwD71qZ
         kFW6fYTx1ygoh4rLgEKoVHREp63gB00D2/1klM0BUMIERav6EDHQR49hZIeAD/LlWJ0W
         t8ctXPanWCe102O8hNj/xN/+gstbRe30qIbt1WX8MAQ96NBAETPz4qvoouTqOtqI49Ea
         H+vMIHASA0AC+UJgUxrzlD3u1++nBmJGlrWHAfkaNUBNYtkREh3yzaWPU+Mq3Eggrrdt
         F4nw==
X-Gm-Message-State: AFeK/H08kSz0kofEa5TdqVprIy2iyWWteYKyD11nLaNkl/RPDKU1TrTv+fVSvz7Z1J0U1w==
X-Received: by 10.99.173.6 with SMTP id g6mr5673521pgf.75.1490316771392;
        Thu, 23 Mar 2017 17:52:51 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:6c40:39b9:f9ab:ec6f])
        by smtp.gmail.com with ESMTPSA id s27sm564180pfk.39.2017.03.23.17.52.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 17:52:51 -0700 (PDT)
Date:   Thu, 23 Mar 2017 17:52:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: How do I copy a branch & its config to a new name?
Message-ID: <20170324005249.GF20794@aiede.mtv.corp.google.com>
References: <CACBZZX7NDa5o1xSu4HgZ4=kG3mx3U6ja7f3E4yAkFOHDsLdMjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7NDa5o1xSu4HgZ4=kG3mx3U6ja7f3E4yAkFOHDsLdMjA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> I couldn't find any previous list discussion about this, but if not I
> think something like:
>
>     git [checkout|branch] --copy src dest
>
> Would make sense as an interface for this.

Sounds good to me. :)

Thanks,
Jonathan
