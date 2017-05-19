Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85FC32023D
	for <e@80x24.org>; Fri, 19 May 2017 21:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755535AbdESVuo (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 17:50:44 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38106 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752345AbdESVun (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 17:50:43 -0400
Received: by mail-wm0-f44.google.com with SMTP id v15so97225615wmv.1
        for <git@vger.kernel.org>; Fri, 19 May 2017 14:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yOTS4WEcvcNIAhL7gwJmDyTMu9TlIHsjdXGFC1Idre4=;
        b=rB10VoMkG34jz22o7LpD9bSvC7UZ4pW/rnm2+fu3CJ7Inb0kJmgCTxW82TlZVwwyt4
         DEHf6eEgaYzCCQ7eCh/k9gfiQ4TmZ+GQOWD2xnNifSzDo6gWRKdDJHhMtFC6xJs8Wz3/
         6pb0g9AkD1ssBQIKg8DoYE/SVu7ZkYCX5h2mP9bNA1oHsEdUe95LLk2a7GsHtkZNwswj
         m7k294/0Bkzd7hqC/wKlrS+JEhJeXYuE18nzT7jn9VLjNOqD04QVDWiDJXrs2PsOXikQ
         iQp4t1xvgKhWj0m5SoDZxvc1abbatxUuJer3VQFTQtNZBwI6gxj0C3IJ1uPHTQ5eeN2M
         z6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOTS4WEcvcNIAhL7gwJmDyTMu9TlIHsjdXGFC1Idre4=;
        b=Cb7Fvk1wTKm6ECWUMpeq9DjS0DVrA/TGX4rtb+xh23nLdYuAj0qPi8JThl5XVUfPwz
         lFCmjUIciBWd33tUxsScNmqUb/nq/B8u78joDxFC3TVsHK6ebyKVHhtrd9ECWrwcu6+0
         2haV8Rkr9JF5cO78rhN/ZtnslBioKidV0eK3W02+nE8/eUZ35dlkHXfiUQ7Z83gGHPU6
         zOLiuXpZ8a5WJdp94lwI0cQ+8Efm1rtU+FswTuWHT71qoU333bgjD2GZvAu34dLNGr0P
         sObmJWuPFNilGhFely4PnCRyQChQy/krd7H6Ev4zX55JuTBQnlm7ZpVjzQlgji/h55a4
         0QGw==
X-Gm-Message-State: AODbwcDvEMdqlWn8M2ilpToJrNY0S5Pfnm5iT6/id8KfrVfLf77Ex0FX
        NVFFUBR0KAHq+3tF
X-Received: by 10.80.183.195 with SMTP id i3mr8618589ede.159.1495230187718;
        Fri, 19 May 2017 14:43:07 -0700 (PDT)
Received: from [192.168.1.80] ([145.129.9.233])
        by smtp.gmail.com with ESMTPSA id l4sm9587836edd.69.2017.05.19.14.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 May 2017 14:43:07 -0700 (PDT)
Message-ID: <1495230186.19473.7.camel@kaarsemaker.net>
Subject: Re: persistent-https, url insteadof, and `git submodule`
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Elliott Cable <me@ell.io>, Git Mailing List <git@vger.kernel.org>
Date:   Fri, 19 May 2017 23:43:06 +0200
In-Reply-To: <CAPZ477MCsBsfbqKzp69MT_brwz-0aes6twJofQrhizUBV7ZoeA@mail.gmail.com>
References: <CAPZ477MCsBsfbqKzp69MT_brwz-0aes6twJofQrhizUBV7ZoeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-05-19 at 14:57 -0500, Elliott Cable wrote:
> Set up `persistent-https` as described in the [README][]; including the
> ‘rewrite https urls’ feature in `.gitconfig`:
> 
>     [url "persistent-https"]
>         insteadof = https
>     [url "persistent-http"]
>         insteadof = http
> 
> Unfortunately, this breaks `git submodule add`:
> 
>     > git submodule add https://github.com/nodenv/nodenv.git \
>         ./Vendor/nodenv
>     Cloning into '/Users/ec/Library/System Repo/Vendor/nodenv'...
>     fatal: transport 'persistent-https' not allowed
>     fatal: clone of 'https://github.com/nodenv/nodenv.git' into
> submodule path '/Users/ec/Library/System Repo/Vendor/nodenv' failed
> 
> Presumably this isn't intended behaviour?

It actually is. git-submodule sets GIT_PROTOCOL_FROM_USER to 0, which
makes git not trust any urls except http(s), git, ssh and file urls
unless you explicitely configure git to allow it. See the
GIT_ALLOW_PROTOCOL section in man git and the git-config section it
links to.

D.
