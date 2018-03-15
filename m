Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F1F31F404
	for <e@80x24.org>; Thu, 15 Mar 2018 23:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933210AbeCOXpG (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 19:45:06 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35317 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933034AbeCOXpF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 19:45:05 -0400
Received: by mail-qt0-f193.google.com with SMTP id z14so9172840qti.2
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 16:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=hHwzCNHNvGXa4bklzSpfBYojSZxRXCTgUuQ6hxSOZtI=;
        b=VDSS3hrl0IHYD2IuTPgcqsB94r3QWcSwNRE+noUM09U+i6xB+U39mWGW1e879tnQvW
         HahJVOuAMY5JwUAMTFBoh4J+Mech5BixRTTeQmeYfpl5IZyv816QPKHes7FcSsptCDV8
         c+q0vEhAiDbkYYvte7JYCmB81FdGN3nEP38Y8mIKbPfNxFLpu0FmKhgFT/AQxqhhvEQu
         SAcjiQl1QWYqqGth8RwaQQtQjOq5bEvkjvHD5pfYuoRGT3dXWO4izAEjehs4vANMZfDJ
         AbGdSHGsMSBq2Ftjt8ELbA+Ye1zi5yJR+h0KKcNUCYor6iSIa8lN8Cu0tliSsC39XWh8
         x8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=hHwzCNHNvGXa4bklzSpfBYojSZxRXCTgUuQ6hxSOZtI=;
        b=DoFpkTYBVLdWWwsaKSHE8D6M/Iv5k1iFCSeCtGbZFAnLQTrYobP8B+j7oWCmWuarFJ
         JLbupVQaSKbeSdR2rJieFEhTfdKFo4vQCNMCq4Bs7ImgztYaQ9BqYdGW8JbOBhYhPOm0
         ASatkWerQg3JTAO8nNu4ZWkVbZBhYsi4eqWE9RcmQjiKNH7yoAs8DvjBsWchbDRbPwYP
         E+CwNuVk3g8nyijqen+XXdJKB9kV+PraIa9a5vyPzD9jl8a2xYZx1LKZSgheWx9Fq253
         a+PDwZSg3EekfD2NfPuZweVL13kiXJam3dKjOZ6bR/8liJs0DLESmwy5O0IC0Cdv1Dry
         zdwA==
X-Gm-Message-State: AElRT7E1kZEjo6fNVdmXV8uwH1aJ+0sLmlIQCevv5XqryJVIqdpSQ/Mw
        2QHn9kYCcV8m9LqR8e2dbXuEGBO+8eaCiY1y4EI=
X-Google-Smtp-Source: AG47ELsHldRyLhnFS4b3fkgIs710HllJ6QCHPUQJsNBI6wBtF+HSM22z/XJ4gs5SbTdMIM4iWRnuMfXPsAYjA3Oibus=
X-Received: by 10.200.26.251 with SMTP id h56mr16017374qtk.223.1521157505236;
 Thu, 15 Mar 2018 16:45:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.175.218 with HTTP; Thu, 15 Mar 2018 16:45:04 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 16 Mar 2018 07:45:04 +0800
Message-ID: <CANYiYbFSsj10oDUoW_hEnWQSce707ubDY1BJ0wTyqKVuDP_ECw@mail.gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.17.0 round 1
To:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Ahmad Naufal Mukhtar <halo@anaufalm.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.17.0-rc0 has been released, and it's time to start new round of git =
l10n.
This time there are 130+ updated messages need to be translated since last
update:

    l10n: git.pot: v2.17.0 round 1 (132 new, 44 removed)

    Generate po/git.pot from v2.17.0-rc0 for git v2.17.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
