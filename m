Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0D6B20989
	for <e@80x24.org>; Mon, 10 Oct 2016 20:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbcJJUUz (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 16:20:55 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34811 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbcJJUUy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 16:20:54 -0400
Received: by mail-lf0-f65.google.com with SMTP id p80so88763lfp.1
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HRhALhFTUsHDRvMy/gQ5wQ8FnyrQ0pFpDNHckUOYD3g=;
        b=n0f5qUI1x5E5qiXIq1/cXXi0scE/2jMMdaHyg14URcOeZBE0EgzVM2zQac8GZgeNRk
         JZlmXTn3kzADQoaGb0KDRNIMGU5mc+l7QEvNp0nXhblLDQG4nVRB2j1gLLdGWUUlveNu
         kmUM14HVnH+wZMYlkjJBFLiWSLitod40leSbGPM/F75+6JbVdpjDR8JIynUko3xu1Mda
         kaoHXc8sXf7qwSvmC/yjRtHhe7v5OapZ9kN34wqyEKeTWyujOIIYggRrdnYSN803jBTw
         zmfxyhBilxNfkH6AcsM1+aybNkCRSAubcJt5OuqQ0Z62++Nex3seoUoeCXj3eewIuqqo
         kyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HRhALhFTUsHDRvMy/gQ5wQ8FnyrQ0pFpDNHckUOYD3g=;
        b=cqLuGRwgcZSt7au4sqtFJbrUZwxJzaRJ84rrYsDaPxFoHa1a2m9FiOYeJI4+fJQ8We
         KsLsP/ZgzELOYGtRAltmRzQPspiSkXZYrdX5uLCGTxu+uACK8b+Ukl2fI4zo+/Ajq6HW
         bBoFcZUmiEYZiFdcEjj29CHUbXsIwaBtIFSjVRUwufBJOwd08NQ3+twWQEvcyh9J1y/3
         sHU/qkbkR9hdWah16pI6cHcJsVV8rrfrOjotMyz5st5x2itBfNLcwqhN30NgUCer0yW6
         iv5irhMx2ipzOa/OBMP8o84GrnFW4R6OA3ZkQdMTvT2jyWwhte2xaGdrehZM4Zv1iTbL
         eSsQ==
X-Gm-Message-State: AA6/9RkPswQ/KutARcljXgWrB/Y5kFIRBS3DTsj20axrli/oMA6wz3PMCZLazR7m+IAalw==
X-Received: by 10.194.111.100 with SMTP id ih4mr43947wjb.230.1476130852187;
        Mon, 10 Oct 2016 13:20:52 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id lf9sm42848768wjb.22.2016.10.10.13.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Oct 2016 13:20:51 -0700 (PDT)
Message-ID: <1476130850.7457.8.camel@kaarsemaker.net>
Subject: Re: [PATCH] contrib: add credential helper for libsecret
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Mantas =?UTF-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        git@vger.kernel.org
Date:   Mon, 10 Oct 2016 22:20:50 +0200
In-Reply-To: <20161009123417.147239-1-grawity@gmail.com>
References: <20161009123417.147239-1-grawity@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2016-10-09 at 15:34 +0300, Mantas Mikulėnas wrote:
> This is based on the existing gnome-keyring helper, but instead of
> libgnome-keyring (which was specific to GNOME and is deprecated), it
> uses libsecret which can support other implementations of XDG Secret
> Service API.
> 
> Passes t0303-credential-external.sh.

When setting credential.helper to this helper, I get the following output:

$ git clone https://private-repo-url-removed private
Cloning into 'private'...
/home/dennis/code/git/contrib/credential/libsecret/ get: 1: /home/dennis/code/git/contrib/credential/libsecret/ get: /home/dennis/code/git/contrib/credential/libsecret/: Permission denied

Looks suboptimal. Am I holding it wrong?

D.
