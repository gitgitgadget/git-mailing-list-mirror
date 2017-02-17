Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73C2A201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 21:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935147AbdBQV5L (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 16:57:11 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34225 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934998AbdBQV5J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 16:57:09 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so4684975wmi.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 13:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ZcpWNiE6Vu1p7aZ+j5M2HJSbO6Axw5sWHAIZDlZ1C30=;
        b=veAVYTD6LRS9sXr8//6sU+IYGrI/4kTqiBgxeDAeH5qzEvHnNljLoYbaQv4RQXwNf4
         QLPyHDH1s32a7OzJyND76d0yA/ZJj42Gkpx4q9YOD0bLWmWpKnLWct0axzOlM4tb690w
         wo/TFVzQNQelp/j3AVSWiKb2PBocdwb++GL1R4e9Ci3p+Dc4dXXIwIQHYN6gToX3Ug0Q
         DffUuspLz2YZhvYUK81zPFLh6XBcjHluHr0zQDlubvtYV40aBWaM9vAw4YQKR01Pb9Vc
         K77BxLpr0qbeONfrPwsFstkJ1wrrBl8Rx/IzaZtYrb5cwSB40/sIqw2zE0EpXozBt0PZ
         5TIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ZcpWNiE6Vu1p7aZ+j5M2HJSbO6Axw5sWHAIZDlZ1C30=;
        b=dm12ihNy/5dPTlWF5/BX5IyzFyIRdAKpV1FR2jDh1WMYrerx1UIB/D4PVvg3u/tEUj
         zuL+e2TL07k+bIwLvjcorKttRyrf7Mhw8/YiXuyg5x8xKwPinRQAonuLDYl1W7W7r9Qf
         UFqK1MfvO+9blK5p6Oi6+iwYxyWahDLCgk3m3VJLiXxiPLz5jbQ6f6R4AY/X/bDuz0jY
         sCMdg7te+jy455LK90MFw4f/yCIcjRDlPRxp2+KFGijs7wqZQF+c7towyeiqPXZ37AcI
         3rkFFq78yUsXSZfusu20M0oFO+TdhwaA106uU3Dp1iu0wTtHmuiufXgFT+ZolFbQ4xtg
         tAUQ==
X-Gm-Message-State: AMke39l5lkPcg2qZVAGd4Te5TjMFyhL3nfxPNJ388DusKJ3RtgZH6v9wIt0gug1K198Kyw==
X-Received: by 10.28.138.147 with SMTP id m141mr3388220wmd.57.1487368610720;
        Fri, 17 Feb 2017 13:56:50 -0800 (PST)
Received: from [192.168.178.21] (i577ABC5E.versanet.de. [87.122.188.94])
        by smtp.googlemail.com with ESMTPSA id t103sm14497151wrc.43.2017.02.17.13.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 13:56:49 -0800 (PST)
Subject: Re: [PATCH] l10n: de.po: translate 241 messages
To:     Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
References: <20170217174132.8816-1-ralf.thielow@gmail.com>
Cc:     Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Jan_Kr=c3=bcger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        =?UTF-8?Q?Matthias_R=c3=bcster?= <matthias.ruester@gmail.com>,
        =?UTF-8?Q?Magnus_G=c3=b6rlitz?= <magnus.goerlitz@googlemail.com>
From:   Phillip Sz <phillip.szelat@gmail.com>
Message-ID: <0d720395-9e92-e6e8-2f88-aff8192ae946@gmail.com>
Date:   Fri, 17 Feb 2017 22:56:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170217174132.8816-1-ralf.thielow@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

> @@ -916,17 +916,17 @@ msgstr ""
>  msgid ""
>  "The merge base %s is %s.\n"
>  "This means the first '%s' commit is between %s and [%s].\n"
>  msgstr ""
>  "Die Merge-Basis %s ist %s.\n"
>  "Das bedeutet, der erste '%s' Commit befindet sich zwischen %s und [%s]\n"

"Das bedeutet, der erste '%s' Commit befindet sich zwischen %s und [%s].\n"

Period is missing.


>  #: remote.c:2092
>  #, c-format
>  msgid "Your branch is ahead of '%s' by %d commit.\n"
>  msgid_plural "Your branch is ahead of '%s' by %d commits.\n"
> -msgstr[0] "Ihr Branch ist vor '%s' um %d Commit.\n"
> -msgstr[1] "Ihr Branch ist vor '%s' um %d Commits.\n"
> +msgstr[0] "Ihr Branch ist %2$d Commit vor '%1$s'.\n"
> +msgstr[1] "Ihr Branch ist %2$d Commits vor '%1$s'.\n"
>  

Does this "%2$d" works and why not use '%s'?

>  #: sequencer.c:840
> -#, fuzzy
>  msgid "could not read HEAD's commit message"
> -msgstr "Konnte Commit-Beschreibung nicht lesen: %s"
> +msgstr "Konnte Commit-Beschreibung von HEAD nicht lesen"
>

>  #: sequencer.c:846
> -#, fuzzy, c-format
> +#, c-format
>  msgid "cannot write '%s'"
> -msgstr "kann '%s' nicht erstellen"
> +msgstr "kann '%s' nicht schreiben"

I think we should either use "kann" or "konnte".
We have used both and maybe we should unify it? What do you think?

>  #: sequencer.c:1341
> -#, fuzzy
>  msgid "please fix this using 'git rebase --edit-todo'."
>  msgstr "Bitte beheben Sie das, indem Sie 'git rebase --edit-todo' ausführen."

Maybe: "Bitte beheben Sie dieses, indem Sie 'git rebase --edit-todo'
ausführen."

>  #: git-add--interactive.perl:1074
>  #, perl-format
>  msgid ""
>  "---\n"
>  "To remove '%s' lines, make them ' ' lines (context).\n"
>  "To remove '%s' lines, delete them.\n"
>  "Lines starting with %s will be removed.\n"
>  msgstr ""
> +"---\n"
> +"Um '%s' Zeilen zu entfernen, machen Sie aus diesen ' ' Zeilen (Kontext).\n"
> +"Um '%s' Zeilen zu entferenen, löschen Sie diese.\n"
> +"Zeilen, die mit %s beginnen, werden entfernt.\n"
>  

"Um '%s' Zeilen zu entfernen, löschen Sie diese.\n"

Anyway thanks a lot for your awesome work!

	Phillip
