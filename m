Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0F151F829
	for <e@80x24.org>; Wed,  3 May 2017 17:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbdECR30 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 13:29:26 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34586 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbdECR3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 13:29:25 -0400
Received: by mail-wr0-f195.google.com with SMTP id 6so23954638wrb.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=+xXBgwY/+PQsLhNUU9dS+wdd0aJCjhSqp+1xoGIYRMk=;
        b=OIz9j1CwDXCczytjv4BmyTCtdKKGvr8h28liRkq9USj9ISS8Ztx4OaZjOU36jEoIGA
         QHo7Zu976YWEk2FsPOjY2ZZubQntCIZ7PQqDIirLLdysIPOsNt/4EnpRxfgoYfWSu+mF
         3hpJigjK2Xik+PLvAlyhhk9HQM64hMtyTNhSLx1TP/lJmWyZgAM7TeBVox70jJyfHoHp
         B0hD9dchHPTmEhv5hJPqwwjkJ+tKNuNtnCBYTL/VZlRtTD198NMO1Wy6b/+M5KzFyjtd
         KgzRey/bJiIa82So5o9oWd+DrBjsCAkYDVCzeF7k3f/K4e5jOwqfKU2KMSOnnk8Dt/c5
         tkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=+xXBgwY/+PQsLhNUU9dS+wdd0aJCjhSqp+1xoGIYRMk=;
        b=fs1aOtdEJ79lazlwSS+RybXmBiJ/o2vXqw06NnBq06SEuu0Y3vQqhOu9Eq7dLc+gc8
         pcc6Hi/aCQAZD7NRk5rwwVe+4o+DrHT57wGLHTanu03gM9z9J5SRc+FVKrEQyS+vJ9pN
         ngLHc15yGV83zGqe6lONwU/0Wg2O6yM2RfQ1BmfeODtlpuqDltHITvb9UKIcxHma6YI6
         BkDWW61BKA1WZ2bRHRyd72OVlRFHFDLlrlogR55EgVNToNm58iY076zlpjntxUhGa8VJ
         U5Z3cj/z07ZEQvEPusMB/0jUdon0D4qZYoWNnU0KuJ0Jv3vNqr3AS9Lw/KajVdhcoWGO
         osVg==
X-Gm-Message-State: AN3rC/4Fae8mNGG3xqrBaBkosnwDHqLjtvyhi83pnTZCwzi/syYzbO83
        x6E7mSHx+EaA+Q==
X-Received: by 10.223.177.155 with SMTP id q27mr25223713wra.173.1493832563741;
        Wed, 03 May 2017 10:29:23 -0700 (PDT)
Received: from [192.168.0.136] (ip5f5be416.dynamic.kabel-deutschland.de. [95.91.228.22])
        by smtp.googlemail.com with ESMTPSA id q108sm25092270wrb.3.2017.05.03.10.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 10:29:23 -0700 (PDT)
Subject: Re: [PATCH v4] l10n: de.po: update German translation
To:     Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
References: <20170502163612.3381-1-ralf.thielow@gmail.com>
 <20170503164009.5366-1-ralf.thielow@gmail.com>
Cc:     Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Jan_Kr=c3=bcger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?Q?Magnus_G=c3=b6rlitz?= <magnus.goerlitz@googlemail.com>,
        Simon Ruderich <simon@ruderich.org>,
        Christian Brabandt <cb@256bit.org>
From:   =?UTF-8?Q?Matthias_R=c3=bcster?= <matthias.ruester@gmail.com>
Message-ID: <aa5f6d4b-8e8f-19c1-cd7f-25978368d359@gmail.com>
Date:   Wed, 3 May 2017 19:29:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170503164009.5366-1-ralf.thielow@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ralf,

thanks again for your work!


>  
>  #: ref-filter.c:565
> -#, fuzzy, c-format
> +#, c-format
>  msgid "format: %%(then) atom used after %%(else)"
> -msgstr "Format: %%(end) Atom fehlt"
> +msgstr "format: %%(then) nach %%(else) verwendet"
>  

Is there a "Atom" missing?
"format: %%(then) Atom nach %%(else) verwendet"


>  
>  #: submodule.c:1332
> -#, fuzzy, c-format
> +#, c-format
>  msgid "could not start 'git status' in submodule '%s'"
>  msgstr "Konnte 'git status' in Submodul '%s' nicht starten."
>  
>  #: submodule.c:1345
> -#, fuzzy, c-format
> +#, c-format
>  msgid "could not run 'git status' in submodule '%s'"
>  msgstr "konnte 'git status' in Submodul '%s' nicht ausführen"
>  

Maybe "Konnte 'git status' nicht in Submodul starten/ausführen" would
sound better?

In general: sometimes there is a sentence (starts with a uppercase
letter and ends with a dot) and sometimes not.

So for example also here:

 #: fetch-pack.c:1150
 #, c-format
 msgid "Server does not allow request for unadvertised object %s"
-msgstr ""
+msgstr "Der Server lehnt Anfrage nach nicht angebotenem Objekt %s ab."

I have not looked up the exact circumstances when this would show up,
though.


>  #: submodule.c:1421
> -#, fuzzy, c-format
> +#, c-format
>  msgid "submodule '%s' has dirty index"
> -msgstr "Submodul '%s' kann Alternative nicht hinzufügen: %s"
> +msgstr "Submodul '%s' hat geänderten Index"
>  

I would suggest:
"Submodul '%s' hat einen geänderten Index"


>  
>  #: builtin/tag.c:493
> -#, fuzzy
>  msgid "--contains option is only allowed in list mode"
> -msgstr "--contains Option ist nur erlaubt mit -l."
> +msgstr "--contains Option ist nur im Listenmodus erlaubt"
>  
>  #: builtin/tag.c:495
> -#, fuzzy
>  msgid "--no-contains option is only allowed in list mode"
> -msgstr "--contains Option ist nur erlaubt mit -l."
> +msgstr "Option --no-contains ist nur im Listenmodus erlaubt"
>  

Is "Option --contains ist nur im Listenmodus erlaubt" possible there? So
it would be like the second one...



Kind regards,
Matthias
