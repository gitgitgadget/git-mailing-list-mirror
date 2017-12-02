Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B6DD20A40
	for <e@80x24.org>; Sat,  2 Dec 2017 20:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbdLBUCD (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 15:02:03 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:46796 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbdLBUCC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 15:02:02 -0500
Received: by mail-wm0-f66.google.com with SMTP id r78so8735017wme.5
        for <git@vger.kernel.org>; Sat, 02 Dec 2017 12:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BiLzbvUsQd1djKUtujqwnhrsMIKovXrRBvW1EBtxMqU=;
        b=L7xSN9O+39vrj4qKGXCWgv2tYeThNG7VLLUzVzE6BmY3ei6DsRPvsrlKPI1ZN+oe2q
         BhbIUxF6ArD6J+e39hcoIurqpRmazu/D47zYjQDuEFet5XAPI5xEZThYsLssVmeQuBsX
         nYD3gKZVDA36AarlijqZGrr0mcsztYQnLV6vnZtBR5XnSS99HXRprWAaLEG//qpKUIxV
         OTqaVbaGZcn9BOp/x+rxNjgBzgSoXvtt7zRKbcr/ooMTLY4r9fAWnrcmv+KrkXRYJj5/
         IhuNueLDl+OwPGLGzjquZqyY0scmH6VlpiRE5E9Rt3x6crmF3qLxshQRdqmOK8KLvetc
         7ZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BiLzbvUsQd1djKUtujqwnhrsMIKovXrRBvW1EBtxMqU=;
        b=jOiQIKPBkwtQWc2uMHLhuqs5xfrVyi0lpvpL6na1k2uIKsOr0ox4H5IxN7D97RsrRY
         FLSBqie+m7RWpofBMQsKg5AshxzOSaM/OsUKlxkLf46vy9KVMY+N+1nHofkNWLIl7aqx
         ncKKCW21k6wYajW3jLf4ZxashOFv7wED+wsCptdvCkx/ditC2U+yvvwdceSQbxd11orD
         /DbvYGwTr1igJHBaqaCLFM2BwR7Nsa7i3LErbc8/mxgxtEY3cGuY17LebgXLwdz7I7sK
         9WTclrivN8Tvm/eQsTDEc1Ow2QxZE0rgEuxi/iSSK9V/maKmieovNEdOHhmWqgpextAa
         4FTw==
X-Gm-Message-State: AJaThX7tbetC2x9hPEpnNhSlxufyiofMEx9iy5D4ammq4Bffmp0cj10I
        9bZYvgFpJTuV0vajb7+GjArAOQ==
X-Google-Smtp-Source: AGs4zMYDipyCqion9BhYDZb5lMKlL54TUxoth0XCBieokzQqrTB1DqotF3eNskdrOeqleuwgTEoTeA==
X-Received: by 10.80.140.237 with SMTP id r42mr23214310edr.299.1512244921555;
        Sat, 02 Dec 2017 12:02:01 -0800 (PST)
Received: from localhost (cable-82-119-27-96.cust.telecolumbus.net. [82.119.27.96])
        by smtp.gmail.com with ESMTPSA id b7sm6245119eda.60.2017.12.02.12.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Dec 2017 12:02:00 -0800 (PST)
Date:   Sat, 2 Dec 2017 21:02:00 +0100
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     Robert Abel <rabel@robertabel.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] l10n: update de_DE translation
Message-ID: <20171202200200.GA30510@gmail.com>
References: <20171201222055.4723-1-rabel@robertabel.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171201222055.4723-1-rabel@robertabel.eu>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Abel <rabel@robertabel.eu> wrote:
> Der-, die- and dasselbe and their declensions are spelt as one word in German.
> 

Thanks!

> Signed-off-by: Robert Abel <rabel@robertabel.eu>
> ---
>  po/de.po | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/po/de.po b/po/de.po
> index a05aca5f3..400262625 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -2925,7 +2925,7 @@ msgstr "  (benutzen Sie \"git branch --unset-upstream\" zum Beheben)\n"
>  #: remote.c:2083
>  #, c-format
>  msgid "Your branch is up to date with '%s'.\n"
> -msgstr "Ihr Branch ist auf dem selben Stand wie '%s'.\n"
> +msgstr "Ihr Branch ist auf demselben Stand wie '%s'.\n"
>  
>  #: remote.c:2087
>  #, c-format
> @@ -10874,7 +10874,7 @@ msgstr "Kann nicht überschreiben"
>  
>  #: builtin/mv.c:239
>  msgid "multiple sources for the same target"
> -msgstr "mehrere Quellen für das selbe Ziel"
> +msgstr "mehrere Quellen für dasselbe Ziel"
>  
>  #: builtin/mv.c:241
>  msgid "destination directory does not exist"
> @@ -11827,7 +11827,7 @@ msgstr ""
>  "\n"
>  "    git push %s HEAD:%s\n"
>  "\n"
> -"Um auf den Branch mit dem selben Namen im Remote-Repository zu versenden,\n"
> +"Um auf den Branch mit demselben Namen im Remote-Repository zu versenden,\n"
>  "benutzen Sie:\n"
>  "\n"
>  "    git push %s %s\n"
> -- 
> 2.15.1
> 
