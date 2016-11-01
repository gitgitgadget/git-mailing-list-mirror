Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF30B20229
	for <e@80x24.org>; Tue,  1 Nov 2016 14:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966367AbcKAOTd (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 10:19:33 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33045 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966312AbcKAOTb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 10:19:31 -0400
Received: by mail-qk0-f180.google.com with SMTP id v138so109428972qka.0
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 07:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=GAhajKpbbj/jMv4IRC9euZPPkoYvtacCiIZClpSnrYk=;
        b=vSP/DUb4T/QHHlHJMIFir8xenb7LVW4uH6htnrskSRGCwW8x2JTRWtPLB3NEnKhebW
         955Xg6+uy/K9ZCdkkjBgPbzgSPccJRj5j4XiA+3It+aMZ8MxJbtjmWRrFAhdSDzKDkqu
         WqO4djEYlaKyCyH9JGgFOR1jzgLd7LcAeaVn32+D6orej1PpjJykPj5K+VbA+DIAIfu2
         /spw7VHEWcJ69gHDfPEsE3Oa3op21Ltk1yTBnaqA0EpfGdosIswEhzoyj+Id6lER7RMN
         LrkYmvp07guInzjGEmaAup7QEh7wy0yD+n1a65voglOtKbNEG2IRJ52mAMyOuYHT/QnK
         +v0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=GAhajKpbbj/jMv4IRC9euZPPkoYvtacCiIZClpSnrYk=;
        b=Q/nJmB2Is3UvVFJkst7sGor5y4suF6G2paM3KGJNw5+yzkfpLtkPbM8WyRN78NkCb0
         7GSL+5puKK7gksQzulMezPDNNSaRCNVvg8IUkgKXBgpzZTTQaRcU7Qu6gfSq60etg9tM
         4voA288r2YFBUagHWajNzqsqxV4oWmkVBYckd2dhFpqaJk9p9MpqAccQ2Uwoxg2kzTR/
         5BV0ahP/tP0VFX6gtTq09BexjnAckDNLK8XqMEFOa0AZXliiLulQuOnClsDiil+lsrSG
         jis4S+cEBMUdsH1eTihmXjp4hhwiDpCrjOPtcRBWJt3J7kzXM0Jq0kT7qoe1j25H7lme
         VU8Q==
X-Gm-Message-State: ABUngveai5kEkGKuKN2OyWe7sf2MgEWtSUAHdvqA6lctXxn9nhgcztBfi0tfM94kFwHa7cc+7tmaQVOyQfzmTA==
X-Received: by 10.55.107.198 with SMTP id g189mr28723152qkc.287.1478009970497;
 Tue, 01 Nov 2016 07:19:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.149.151 with HTTP; Tue, 1 Nov 2016 07:19:29 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 1 Nov 2016 22:19:29 +0800
Message-ID: <CANYiYbHqmUYKZ4JuzWe=ByMAMCg_YjOLNpyvxUxA-DicT8evjg@mail.gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.11.0 round 1
To:     Alexander Shopov <ash@kambanaria.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Ray Chen <oldsharp@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.11.0-rc0 has been released, and it's time to start new round of git =
l10n.
This time there are 209 updated messages need to be translated since last
update:

    l10n: git.pot: v2.11.0 round 1 (209 new, 53 removed)

    Generate po/git.pot from v2.11.0-rc0 for git v2.11.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
