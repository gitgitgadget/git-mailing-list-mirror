Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 554851F453
	for <e@80x24.org>; Fri, 26 Oct 2018 13:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbeJZWGJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 18:06:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46674 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJZWGI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 18:06:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id v18-v6so1274114edq.13
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 06:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=86ulgkgVIxGOFbS3mms5/kLuzMueTZMLCbuwLa4gMVo=;
        b=CURfA8CjGjIfDnznjHL58pYhjmeNyVJCf15eAaZkG1dOlynWXJtiH87Sx02axDKk6t
         zKtuMRDq7TUz8witViv/s24AmqH1jrPE76nonlhGL9SlZoDQwJmUNdRGwu4dr9xJmyWX
         eDjkpFHwnvUyXq4cUGxbfO8Nt29j2G7TA6zKJ53DqVNT9cDRdxlee7GPBzYnU54NI6kQ
         XtfOtU/AHgs6FXpErs0fvagCNyKFtAdk9GB8axJ+StwTQKKIy+771ELvcbUadNLP233i
         1ZPX+MZaViiz6/wuIZYWaW3V5EdACX/LmrJGVFv+MxOsCMxN8CiB/J3cUuZgw+4okhdi
         FIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=86ulgkgVIxGOFbS3mms5/kLuzMueTZMLCbuwLa4gMVo=;
        b=m+24Te/0GERDwDMWtq/D//liYWapSIj1VrztAh9Xji78Z8WzKKK/GVr8YLKeqPaYue
         IFBsca3HavE5JsfooBS13VHPbWHSYzfyl6faNlW4IxoYYqQtXppuID4aEaatsRumh7Cw
         jnaWc8BElEtfczQb5AUSdv7USaWU4Moy67qMZwLPk9edVDpgfhzEwZMjF+41V5H1jab0
         lgErcKmLe893trTKWKs74Amq9QSq58G6X8oHzYpVreLIhPssXzxFjPg+kaOKuNzniV6B
         dtomXJOtbTdaJEOEnK4Xeoe7N/JO8GcYBrHmyxG5m75mjbOvqhLIyrc6Vtm9uS9H67DZ
         tMLA==
X-Gm-Message-State: AGRZ1gIIRDYsF69bYzjhgMVUxEDd2KMMso3jvGY6wZbhTZb5Z4eaW/j9
        nYGSfbtkdmGouvIAJozrxJ4fbxUaqKp/Z1snUDY=
X-Google-Smtp-Source: AJdET5c0f7rHAfNDWpdNRI7WlKCQjYqb++WK7RC6SYkfkCNqR/CXwQAnLt/uKovhuP2totAbKRLdU1GZ/a2EtnUjL5Q=
X-Received: by 2002:a50:9923:: with SMTP id k32-v6mr3074516edb.3.1540560541988;
 Fri, 26 Oct 2018 06:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <201810251039388653199@163.com> <xmqqh8hak2mh.fsf@gitster-ct.c.googlers.com>
 <c166b421-a228-8349-0815-2ebb9dcab998@lakedaemon.net> <20181026093644.GA20876@sigill.intra.peff.net>
 <87tvl8lw5d.fsf@evledraar.gmail.com>
In-Reply-To: <87tvl8lw5d.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>
Date:   Fri, 26 Oct 2018 14:28:25 +0100
Message-ID: <CACUQV5-t5NHwQMC0=TYZVmPT1NSQn_J+Nz+vj4jj9-b=pn9oTw@mail.gmail.com>
Subject: Re: the opposite of .gitignore, whitelist
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, jason@lakedaemon.net,
        Junio C Hamano <gitster@pobox.com>, lhf635@163.com,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One other option is to just use a pattern that matches everything, i.e:
    echo '*' > .gitignore

And take advantage that ignore rules do not apply to tracked files.
So instead of using an explicit .gitonly, you add files using:
   git add -f <file_to_be_included>

All files should be ignored except the ones that were forcibly added.

If needed, git ls-files can be used to list either category.

Cheers,
Rafael Ascens=C3=A3o
