Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3E732035F
	for <e@80x24.org>; Tue, 25 Oct 2016 16:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759250AbcJYQQ4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 12:16:56 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37552 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759229AbcJYQQx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 12:16:53 -0400
Received: by mail-wm0-f52.google.com with SMTP id c78so33047460wme.0
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 09:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sLucA2vqmL83yyTdmfFsG7Oadqq+4dsleGlCOjBjGGQ=;
        b=Om+NnxJWzYTr6P5wTEgDNCeTjPr8ukmnGuULyiQ9N+A3FflpsgDMH7AXTti9RSM0UQ
         i9eKpYX4LDuSlSm+FHMPMebU2sTaQJtEn1w06UCAqoes8I9gaKRAVHsJ6/SmPloZMG3N
         a31XN3KcGzbdefN/z0Akkol259nEJ/cVVrPRwx2kQYxKpl3WlUBeL+sd99IsS5xA/DI/
         H2s66T6sGw4E0yuW9r9PF0ZxqgM1H25gNLe3/yH6nhMEKsVEv83O0OeScVwUnK5C7CGR
         kaw6kcCwzrzullM2npjnEj8YoSfiEJNroA+ImL82QxbtBvDDymdDDwlvvsRLDsxOnPj4
         lw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sLucA2vqmL83yyTdmfFsG7Oadqq+4dsleGlCOjBjGGQ=;
        b=IXmnKWNbTTdISEXta7VTr3xQQvAn3sq9X66dCQWoy3vHbdF7kK/MWYiYNYldl8riw7
         k3bz7xGZ+GFHwGXS5Ur2H2tPoCAeVk5T4GIWdey7s0e8FYDl6MwmI+pNRUSGEVcZntUT
         27R5+HsqbajeSbYQD0WNBzJpEIv+IsxMDxw1EdfGEqNbHH4N3PONhTkuKDo+Y8Rcwvjv
         DNw1aXNyOSe1elVAZ/vXEMv+CLxpkUN3aPc/kzEvZrxg6Lw04FkFkiL5HNFs2jmZEdJJ
         zPpgTjm5JWAWIIbL8gYBdtqFzzlJVsMJfbLQtiSORn/y7Lr7aAPKYz2TOpoNl3HbBBKX
         4tpQ==
X-Gm-Message-State: ABUngveBKHUvnKm4pS71W1dQbhS2wKJUyrXvHO1s5D1k4yMAk8iaW16ZJYWAdp7xqgDSEQ==
X-Received: by 10.28.43.199 with SMTP id r190mr3801972wmr.58.1477412211964;
        Tue, 25 Oct 2016 09:16:51 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id p9sm25959900wjs.11.2016.10.25.09.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Oct 2016 09:16:50 -0700 (PDT)
Message-ID: <1477412208.3550.1.camel@kaarsemaker.net>
Subject: Re: password forgot
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Luciano Schillagi <luko.web@gmail.com>, git@vger.kernel.org
Date:   Tue, 25 Oct 2016 18:16:48 +0200
In-Reply-To: <14FB7E4A-7134-4343-AFF7-9E17AC94ACE3@gmail.com>
References: <14FB7E4A-7134-4343-AFF7-9E17AC94ACE3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2016-10-25 at 12:52 -0300, Luciano Schillagi wrote:
> Hi,
> 
> I forgot my password in git, such as resetting?

Hi Luciano,

Git itself doesn't do any authentication, so I assume you lost the
password for an account on a hosted git solution such as gitlab or
github.

You should contact the support team of whatever hoster you use, the git
developers cannot help you here.

D.
