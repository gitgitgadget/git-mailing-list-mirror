Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6455C1F829
	for <e@80x24.org>; Wed,  3 May 2017 13:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbdECNMd (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 09:12:33 -0400
Received: from 256bit.org ([144.76.87.176]:35470 "EHLO 256bit.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751176AbdECNMb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 09:12:31 -0400
X-Greylist: delayed 2029 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 May 2017 09:12:31 EDT
Received: from chrisbra by 256bit.org with local (Exim 4.86_2)
        (envelope-from <cb@256bit.org>)
        id 1d5tY2-0005NJ-Aq; Wed, 03 May 2017 14:38:26 +0200
Date:   Wed, 3 May 2017 14:38:26 +0200
From:   Christian Brabandt <cb@256bit.org>
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Magnus =?utf-8?Q?G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH v3] l10n: de.po: update German translation
Message-ID: <20170503123826.GE30941@256bit.org>
Mail-Followup-To: Ralf Thielow <ralf.thielow@gmail.com>,
        git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Magnus =?utf-8?Q?G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
        Simon Ruderich <simon@ruderich.org>
References: <20170430191149.19290-1-ralf.thielow@gmail.com>
 <20170502163612.3381-1-ralf.thielow@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170502163612.3381-1-ralf.thielow@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: cb@256bit.org
X-SA-Exim-Scanned: No (on 256bit.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hallo Ralf!

Ralf Thielow schrieb am Dienstag, den 02. Mai 2017:

> @@ -1260,6 +1260,8 @@ msgstr "Speicher verbraucht"
>  #: config.c:191
>  msgid "relative config include conditionals must come from files"
>  msgstr ""
> +"Bedingungen für das Einbinden von Konfigurationen aus relativen Pfaden muss\n"
> +"aus Dateien kommen."

Bedingungen [...] müssen aus Dateien kommen

>  #: fetch-pack.c:1150
>  #, c-format
>  msgid "Server does not allow request for unadvertised object %s"
> -msgstr ""
> +msgstr "Der Server erlaubt keine Anfrage für nicht angebotenes Objekt %s."

Double negation does not sound good. Perhaps:
"Der Server lehnt Anfrage nach nicht angebotenem Objekt %s ab."
or possibly (still double negation)
"Der Server erlaubt keine Anfrage für nicht öffentliches Objekt %s."
>  #: builtin/for-each-ref.c:46
> -#, fuzzy
>  msgid "print only refs which don't contain the commit"
> -msgstr "nur Referenzen ausgeben, die diesen Commit enthalten"
> +msgstr "nur Referenzen ausgeben, die diesen nicht Commit enthalten"

"nur Referenzen ausgeben, die diesen Commit nicht enthalten"

refs are here translated as Referenzen

>  #: builtin/grep.c:1189
> -#, fuzzy
>  msgid "--no-index or --untracked cannot be used with revs"
> -msgstr ""
> -"Die Optionen --no-index und --untracked können nicht mit Commits verwendet "
> -"werden."
> +msgstr "--no-index oder --untracked können nicht mit Commits verwendet werden"

refs are here translated as Commits?

>  #: builtin/grep.c:1195
> -#, fuzzy, c-format
> +#, c-format
>  msgid "unable to resolve revision: %s"
> -msgstr "Konnte %s nicht nach %s verschieben"
> +msgstr "Konnte Commit nicht auflösen: %s"

same here

>  #: builtin/tag.c:421 builtin/tag.c:423
> -#, fuzzy
>  msgid "print only tags that don't contain the commit"
> -msgstr "nur Tags ausgeben, die diesen Commit beinhalten"
> +msgstr "nur Tags ausgeben, die diesen nicht Commit enthalten"

"nur Tags ausgeben, die diesen Commit nicht enthalten"

Best,
Christian
-- 
Wie man sein Kind nicht nennen sollte: 
  Anna Naß 
