Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFC521FF40
	for <e@80x24.org>; Sat, 25 Jun 2016 07:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbcFYHHe (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 03:07:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35563 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbcFYHHd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 03:07:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id a66so10618619wme.2
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 00:07:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=QiUVDbYyM0rRXeq3+zTyjGowlL6y6jZPCRRwaa19wPQ=;
        b=VxkOiaUvUO5CqcDvial63YCnPJqNLXqgFVnnrVIqfq+kcK8qtmBYlb14L4QBRM85wE
         pJixopVI+A85Swc/UdE7eRKEKqfhwH9EVaFFX9cBj5yLN/mDF09+i5SR2Y5aOEQOB7r5
         l3E9nYdZKFe+pYrpx43eR25aq2N1S4ju0BU1Zi0fdM6DnyuHYdZxt3N1Sde9J9VH+zsX
         YxrObA1ImYR8My9MGXH6Nutx7mTV5vaHHtApDSUFW7yG8tGjbQlD4/QZ3A9yO5kiZ259
         IAPYxuY9j2xMnoyV+V5jQ75yVf+qXk3Ri6jpch2FrH0IPBqi/iNkP3CLwcgsm81KMQXY
         vFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=QiUVDbYyM0rRXeq3+zTyjGowlL6y6jZPCRRwaa19wPQ=;
        b=YIkmVMuQZBYKWNtl3WSHYsK6PXryp3M+WSel/wIfZA/xFuIX7xBsY+IwYr55YmJrNt
         S7IyiEAH2BjWMEV2MTILZq1sqaDw147M5TfVDkYqyVzVDf/sZnZI4vYtxkKbojj5TY2L
         Fsd6a31uZlIaihwBBDhzK+S/w8ofXEtO09BKupwvDcmFFdqulUOqFpK5zxzbWl9aWc6t
         bwgDoFQWGADgOVvrmt9TgpoHrVEAzttI4lhafGI8REnyS6uIAyPEzm0TapbQIEpTCOWI
         EWH1ds3dFjvi5KMIEH69YNeXfs4ZHC67X85iXr01qAehQltkKLIXFNkly0M7VT0+2KfH
         KxnQ==
X-Gm-Message-State: ALyK8tJvRDP+LKOUGB8ui1rbqw9g9VBealqBDxLz0aSGHtfYJM9N5mhMHzy+62YKnFAVzQ==
X-Received: by 10.28.138.85 with SMTP id m82mr1712630wmd.88.1466838452458;
        Sat, 25 Jun 2016 00:07:32 -0700 (PDT)
Received: from [192.168.0.136] (ip5f5be4e1.dynamic.kabel-deutschland.de. [95.91.228.225])
        by smtp.googlemail.com with ESMTPSA id u71sm205375wmu.13.2016.06.25.00.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Jun 2016 00:07:31 -0700 (PDT)
Subject: Re: [PATCH] l10n: de.po: fix translation of autostash
To:	Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
References: <20160624180700.11685-1-ralf.thielow@gmail.com>
Cc:	tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, magnus.goerlitz@googlemail.com
From:	=?UTF-8?Q?Matthias_R=c3=bcster?= <matthias.ruester@gmail.com>
Message-ID: <8557839d-d3ed-44ac-a680-edb012e92cdc@gmail.com>
Date:	Sat, 25 Jun 2016 09:07:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160624180700.11685-1-ralf.thielow@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Acked-by: Matthias Rüster <matthias.ruester@gmail.com>

Am 24.06.2016 um 20:07 schrieb Ralf Thielow:
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  po/de.po | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/po/de.po b/po/de.po
> index d50cb1b..fdf4d92 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -12408,7 +12408,7 @@ msgstr ""
>  
>  #: git-rebase.sh:168
>  msgid "Applied autostash."
> -msgstr "\"autostash\" angewendet."
> +msgstr "Automatischen Stash angewendet."
>  
>  #: git-rebase.sh:171
>  #, sh-format
> @@ -12421,7 +12421,7 @@ msgid ""
>  "Your changes are safe in the stash.\n"
>  "You can run \"git stash pop\" or \"git stash drop\" at any time.\n"
>  msgstr ""
> -"Anwendung von \"autostash\" resultierte in Konflikten.\n"
> +"Anwendung des automatischen Stash resultierte in Konflikten.\n"
>  "Ihre Änderungen sind im Stash sicher.\n"
>  "Sie können jederzeit \"git stash pop\" oder \"git stash drop\" ausführen.\n"
>  
> @@ -12508,12 +12508,12 @@ msgstr "fatal: Branch $branch_name nicht gefunden"
>  
>  #: git-rebase.sh:558
>  msgid "Cannot autostash"
> -msgstr "Kann \"autostash\" nicht ausführen."
> +msgstr "Kann automatischen Stash nicht anwenden."
>  
>  #: git-rebase.sh:563
>  #, sh-format
>  msgid "Created autostash: $stash_abbrev"
> -msgstr "\"autostash\" erzeugt: $stash_abbrev"
> +msgstr "Automatischen Stash erzeugt: $stash_abbrev"
>  
>  #: git-rebase.sh:567
>  msgid "Please commit or stash them."
> 
