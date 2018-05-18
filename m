Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9AF0200B9
	for <e@80x24.org>; Fri, 18 May 2018 15:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbeERP6f (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 11:58:35 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:43754 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbeERP6e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 11:58:34 -0400
Received: by mail-lf0-f41.google.com with SMTP id n18-v6so14657125lfh.10
        for <git@vger.kernel.org>; Fri, 18 May 2018 08:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fBVkQNvYJLgrNRYnnHAKm/qNUvMsfkLocH4m12oXWUA=;
        b=KQHAmPHyzznFYu/sRK5kmk9U9SXKEYZyreKVaPmqlsujCIlEZoUJynhbObxs98c2Gy
         WvXXIKF3C69IUk9TUzErxoxDz+GxEKz8MeN8L2fQ/hbnF6za0gu3npjkEQjsIy2O8Nto
         XKBbE73JIyyqikuuyGUuJqgkkAbd7BNd5MYxT1bArtyvS5xXGOuZdxBh4drh5DtedjhB
         cM70CmR/AppGGKmHLIvgdUMTubVT8ERPs7TL4cJXK1Cn2uAhZpOone1204HkWivcz79T
         1huUbpjDSFotivb/+tOacCS34YmEOd2B6IfUrJ96sIyLQ7SoPI4HIWhKxBp52bFsBL3v
         efzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fBVkQNvYJLgrNRYnnHAKm/qNUvMsfkLocH4m12oXWUA=;
        b=IdmY48W8FnS9XpHoZJaORa2u6nmRUP5SDmRHjlY3Mf58PQcFgsuZ4JctUWErL24dkB
         3dokUeGcEKyZESofjnQJv/nS8zkQK8PIQVMP5DipGSb0IphD54pPyvCTd8iaUf0+wa8Y
         yoSoFhIE9WLiP/Fcat6+PP35+fHVOketKHztpGZHIa1mdjoACo3EUHtG6YNCGp2iq8K/
         Eqr1T6ZSP1/HvIg2BO9LpFXkymM8543ND0B/fKoBTJB955MBgykdebkiDOo906wEBRgB
         DA6CVliMBAydvjURl/LSfJf+IqyTWEyq/nvZ7nN1qPl1qfEsukZYb7IRjfGOzWvYRLIs
         V8+Q==
X-Gm-Message-State: ALKqPwfnepr6jvTBA/Utdp3qOGpzzhE+V9vzJLB43CBr5ItUXZgJkhya
        3BdRsk9Dr2/sqkJmUvTrj2pJGn4kC/15pm1VqaCqnQ==
X-Google-Smtp-Source: AB8JxZoSpvVduNdsGAxOxvH+ZFkDsvbTvon96EFXijg/SJAPE6+ILOdSgyCUotdVmWLJtS8IBBdMel/GMKBr2XQg3hE=
X-Received: by 2002:a2e:888b:: with SMTP id k11-v6mr6027109lji.54.1526659112907;
 Fri, 18 May 2018 08:58:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:63cf:0:0:0:0:0 with HTTP; Fri, 18 May 2018 08:58:32
 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805180016210.77@tvgsbejvaqbjf.bet>
References: <CAAdU=LtfkKOKnJJC9yvxG+dZxqUh-Pwa5=ra1DOTfxQSY3e6qg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805180016210.77@tvgsbejvaqbjf.bet>
From:   Bartosz Konikiewicz <izdwuut@gmail.com>
Date:   Fri, 18 May 2018 17:58:32 +0200
Message-ID: <CAAdU=LuzJmR-zXmDB-HvHCiA-S1_HLEWueVAOOLDOCdqLtZbBg@mail.gmail.com>
Subject: Re: Troubles with picking an editor during Git update
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, philipoakley@theiet.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git guidelines states that I should leave cc intact. I have altered
it, as I wanted to reply to both of you. I hope that my approach can
be considered acceptable.

Johannes, I see the following line in the piece of code you quoted:
  EditorAvailable[GE_NotepadPlusPlus]:=RegQueryStringValue(HKEY_LOCAL_MACHINE,'SOFTWARE\Microsoft\Windows\CurrentVersion\App
Paths\notepad++.exe','',NotepadPlusPlusPath);

It mentions the following registry key, which was missing from my registry:
  HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App
Paths\notepad++.exe

I reinstalled Notepad++ 6.6.9, which added the key and made the
installer acknowledge that Notepad++ is installed on my system.

Thanks for encouraging me to further investigate the issue. I have dig
deeper into the file that you linked for me. As far as my
comprehension goes, an EditorSelectionChanged procedure (line 1084) is
responsible for toggling the "next" button. I noticed that it gets
invoked in at least 2 situations:
  - when an user picks a text editor (an OnChange event, line 1119)
  - once the custom page for configuring the default Git editor is
initialized (the InitializeWizard procedure, line 1199)

My reasoning tells me that it would be applicable in the
NextButtonClick procedure as well. I'd add the following piece of code
to it:
  if (EditorPage<>NIL) and (CurPageID=EditorPage.ID) then begin
      EditorSelectionChanged(NIL);
  end;

I'd also remove the line 1199, as I think the change that I proposed
would render it redundant.

Philip, I feel that composing a pull request is beyond me. I came to a
conclusion that it would drain me of too much resources. Thanks for
the suggestion, as it would be my first pull request ever. I didn't
manage to achieve it, although I believe that I would be capable of
doing this, which already fills me with utter joy. I am willing to
post my report to Git for Windows issue tracker. Thanks for the
suggestion!
