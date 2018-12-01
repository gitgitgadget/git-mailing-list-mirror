Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D875C211B3
	for <e@80x24.org>; Sat,  1 Dec 2018 09:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbeLAUqh (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 15:46:37 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:43310 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbeLAUqg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 15:46:36 -0500
Received: by mail-qt1-f171.google.com with SMTP id i7so8662110qtj.10
        for <git@vger.kernel.org>; Sat, 01 Dec 2018 01:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=33y3/T0lKr0IkEfuZ4QGHIJb4pV/B85oCaGYlURq0FA=;
        b=rrcdim4AUEY0GnghIXEm+3aegmacg3dKKAcyOCK3q09adwM5IeCoEucW2rYzBTwm+g
         GyLHLfIA4eet8MFukyXQKjIUZ0b8LcYvMJpOEPx499QLNhB1I8E3TwBFkLO7eDRSlsEB
         KMYdL7Oz2LaqkDEXok/85M+xj1a6Dn59AzcHEEhykaOdvdXKZRjxmYx50AeN4jTcXxi3
         o+uG1tqI2S6WFHSqfAiCRaRfZAEL6pIAOHs6KnXIJSzwib2IkAOKmToZoSRqBXeoD+YY
         oJCTEnh0zqSifZ5LSHtwL92ZOiOmyJ2xYldQRgFf8abStBufddXT25lgrkkJCHGO0Ht4
         fWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=33y3/T0lKr0IkEfuZ4QGHIJb4pV/B85oCaGYlURq0FA=;
        b=Myy6qAkiViFtwFneDx8+9wAneMpK2DYef5CjlsiK1fa6dasB6BKmE3f8IwWJ2V1DiG
         L8wiqyUF//9RbnMMfxKgbk5ijD07JQnoS+VwV3HA4/P6aeu+tobj1ikWs2JLeUnc2Rc+
         gRoPxll3SNPqMEzYeuOn+Boi+d/G1M7X7y5dy6+tk8NRFCtkOa3vIG3GQOH/lywpFyX3
         2qy6Lkxtae2pVucFqL5l9oorMJpw7sHV90vPYIHEyODuQcF/8+Es/SMtohBlY1ZLVfrm
         aZnwrXc8iQ1Ebot3E47PPoZIrVnCAuG8Q6u3+skjxlaBy6YefpP2kaqlQIJwBI2wvBaJ
         Nsog==
X-Gm-Message-State: AA+aEWYrbWQLBnNUDgzg+HuM7HQUtUeoPuW1zzU169b4vjaLpG2eQxMz
        CEWyQwity2JPaLwGws3qz+ER4kOTe0eBU3rFvxI=
X-Google-Smtp-Source: AFSGD/X1zzorecXaWtByyvODAWISJGrZbh1PVtpldLHyLjXlTg7xD7x45kkfUKm+wP0JzaqHhSl6b6eHsZ9XlPMBe8E=
X-Received: by 2002:a0c:e751:: with SMTP id g17mr4175228qvn.160.1543656870276;
 Sat, 01 Dec 2018 01:34:30 -0800 (PST)
MIME-Version: 1.0
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 1 Dec 2018 17:34:18 +0800
Message-ID: <CANYiYbE94tiDp4-xcOyWvLNP4e23cqUytYzS4tKYe5iUV12VtA@mail.gmail.com>
Subject: [L10N] Kickoff for Git 2.20.0 round 2
To:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Two typos are fixed in upstream via commit v2.20.0-rc1-7-gd355e46a15:

    --- a/http.c
    +++ b/http.c
    -           warning(_("CURLSSLOPT_NO_REVOKE not suported with cURL
< 7.44.0"));
    +           warning(_("CURLSSLOPT_NO_REVOKE not supported with
cURL < 7.44.0"));

    --- a/midx.c
    +++ b/midx.c
    -           die(_("bad pack-int-id: %u (%u total packs"),
    +           die(_("bad pack-int-id: %u (%u total packs)"),

For l10n teams that have already submitted for l10n round 1, I made a
batch commit to fix fuzzy translations, see pull request:

    https://github.com/git-l10n/git-po/pull/331

For other l10n teams, please update your translations against the new
pot file from the usual place:

    https://github.com/git-l10n/git-po/

--
Jiang Xin
