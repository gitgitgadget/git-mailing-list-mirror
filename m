Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605A3207B3
	for <e@80x24.org>; Fri,  5 May 2017 16:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750792AbdEEQSy (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 12:18:54 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:34694 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdEEQSx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 12:18:53 -0400
Received: by mail-wr0-f173.google.com with SMTP id l9so6654602wre.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 09:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=jtjcb5HAKbisizo37/9dtZJeCqgAmbFeRytxsE/PRqA=;
        b=tx8rV+ntiNidP5XJpntGSAsndOuueuA36XQZWz/iMp6imocw7c58V8FGLwwcsuz0Yx
         d3sR+ny96Kc2PDU7tYjFDJgeNJc2fzw+/dD8IJjfLsAk3IT2Kv45/B3rsDebaXnrx1ui
         HJ3GUFb10YhiNxdA0p6M2PN6OukhdDZk8X6nLH7QwYpliWsUK9j/jNbWfEU96rQ2x2QJ
         3i/M5RH6HZw4PIrfsV+yDXDxqZ5865Dw558WdPhrTD4j8AZ2hYKbx+lW3l0Po1/vJhJS
         L3Snl7Ksr71iVf/t987JDZb9pRLVK3NIoOHBi76QzFyfzNZ+0tExIAm+wxIrsEs/Lmup
         6COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=jtjcb5HAKbisizo37/9dtZJeCqgAmbFeRytxsE/PRqA=;
        b=AMYD8E++/gIXk24f63BXD6zO9zNoATXYG3VZetMkWbTZJn1M/6lNHu7tqDuOh8emxv
         hAJDNh4QmQXNFhjAtxpbdVntEn5XjSpFOmIu7sAfY+MQtBPVYgCaRNIt9IcX6u4awt2v
         gcJooCmpF5yZvTZ211oszehySjKERJJLAq+XF5obU1AbnXKc9D9hi7qsVxILbXHJ2hF7
         /1GBQkFV8/3yxhmZYcFVsnjifN+mjMEzyHffULLqJSokPz6SI82I+GpjqMcq/nVZpjvh
         V7EQfl6OLXJHpkjkC2xY0z88+MsJBBoQ1sX2XBnbtztHY40JGORzsy1RcPe9zOAXowYB
         C+xw==
X-Gm-Message-State: AN3rC/5TsiHOKMzlTSNJyRL2hlQYVRCRqKceaPhb3FO6Eh+WXPpPbfF4
        jR/wn+Jw2m0Xcw==
X-Received: by 10.223.164.65 with SMTP id e1mr30518170wra.21.1494001132051;
        Fri, 05 May 2017 09:18:52 -0700 (PDT)
Received: from [192.168.0.136] (ip5f5be416.dynamic.kabel-deutschland.de. [95.91.228.22])
        by smtp.googlemail.com with ESMTPSA id h80sm2442860wmd.7.2017.05.05.09.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 May 2017 09:18:51 -0700 (PDT)
Subject: Re: [PATCH] l10n: de.po: translate 4 new messages
To:     Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
References: <20170505161704.4666-1-ralf.thielow@gmail.com>
Cc:     Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Jan_Kr=c3=bcger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?Q?Magnus_G=c3=b6rlitz?= <magnus.goerlitz@googlemail.com>
From:   =?UTF-8?Q?Matthias_R=c3=bcster?= <matthias.ruester@gmail.com>
Message-ID: <4f6fb471-d253-68a3-bb4e-f9b9369f8ea7@gmail.com>
Date:   Fri, 5 May 2017 18:18:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170505161704.4666-1-ralf.thielow@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Acked-by: Matthias Rüster <matthias.ruester@gmail.com>


Am 05.05.2017 um 18:17 schrieb Ralf Thielow:
> Translate 4 new messages came from git.pot update in 28e1aaa48 (l10n:
> git.pot: v2.13.0 round 2 (4 new, 7 removed)).
> 
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  po/de.po | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/po/de.po b/po/de.po
> index 12c3d36a0..679f8f472 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -2493,7 +2493,7 @@ msgstr ""
>  "Verwende Version %i"
>  
>  #: read-cache.c:2375 sequencer.c:1350 sequencer.c:2048
> -#, fuzzy, c-format
> +#, c-format
>  msgid "could not stat '%s'"
>  msgstr "Konnte '%s' nicht lesen."
>  
> @@ -2514,7 +2514,7 @@ msgstr "Konnte '%s' nicht zum Schreiben öffnen."
>  
>  #: refs.c:1667
>  msgid "ref updates forbidden inside quarantine environment"
> -msgstr ""
> +msgstr "Aktualisierungen von Referenzen ist innerhalb der Quarantäne-Umgebung verboten."
>  
>  #: refs/files-backend.c:1631
>  #, c-format
> @@ -14135,9 +14135,8 @@ msgid "populate the new working tree"
>  msgstr "das neue Arbeitsverzeichnis auschecken"
>  
>  #: builtin/worktree.c:335
> -#, fuzzy
>  msgid "keep the new working tree locked"
> -msgstr "das neue Arbeitsverzeichnis auschecken"
> +msgstr "das neue Arbeitsverzeichnis gesperrt lassen"
>  
>  #: builtin/worktree.c:343
>  msgid "-b, -B, and --detach are mutually exclusive"
> @@ -14243,7 +14242,7 @@ msgstr ""
>  #: http.c:336
>  #, c-format
>  msgid "negative value for http.postbuffer; defaulting to %d"
> -msgstr ""
> +msgstr "negativer Wert für http.postbuffer; benutze Standardwert %d"
>  
>  #: http.c:357
>  msgid "Delegation control is not supported with cURL < 7.22.0"
> 
