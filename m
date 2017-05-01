Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55FC01F78F
	for <e@80x24.org>; Mon,  1 May 2017 12:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967872AbdEAMTe (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 08:19:34 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:48433 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967135AbdEAMTd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 08:19:33 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Mon, 01 May 2017 14:20:02 +0200
  id 000000000000009A.00000000590727F2.00003F0A
Date:   Mon, 1 May 2017 14:19:31 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        Matthias =?iso-8859-1?Q?R=FCster?= <matthias.ruester@gmail.com>,
        Magnus =?iso-8859-1?Q?G=F6rlitz?= 
        <magnus.goerlitz@googlemail.com>
Subject: Re: [PATCH v2] l10n: de.po: update German translation
Message-ID: <20170501121930.jsbooranvc2il7s2@ruderich.org>
References: <20170430184702.17351-1-ralf.thielow@gmail.com>
 <20170430191149.19290-1-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20170430191149.19290-1-ralf.thielow@gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 30, 2017 at 09:11:49PM +0200, Ralf Thielow wrote:
>  #: config.c:1952
>  #, c-format
>  msgid "unknown core.untrackedCache value '%s'; using 'keep' default value"
> -msgstr ""
> +msgstr "Unbekannter Wert '%s' in core.untrackedCache; benutze Stardardwert 'keep'"
                                                                 ^^^^^^^^^^^^
Standardwert

>  #: entry.c:280
> -#, fuzzy, c-format
> +#, c-format
>  msgid "could not stat file '%s'"
> -msgstr "konnte Datei '%s' nicht erstellen"
> +msgstr "konnte Datei '%s' nicht lesen"

Read is not quite stat (there are situations where you can stat
but not read a file), but I can't think of a better translation.

>  #: builtin/describe.c:551
> -#, fuzzy
>  msgid "--broken is incompatible with commit-ishes"
> -msgstr "Die Option --dirty kann nicht mit Commits verwendet werden."
> +msgstr "Die Option --broken kann nicht nit Commits verwendet werden."
                                          ^^^
mit

>  #: builtin/tag.c:312
>  msgid "tag: tagging "
> -msgstr ""
> +msgstr "Tag: tagge "

Lowercase Tag because it's used as command prefix? In other
places in this patch the lowercase version was used for commands.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
