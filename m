Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6324E207FF
	for <e@80x24.org>; Fri,  5 May 2017 02:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbdEECDi (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 22:03:38 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33464 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752593AbdEECDh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 22:03:37 -0400
Received: by mail-qk0-f172.google.com with SMTP id n4so25573433qkc.0
        for <git@vger.kernel.org>; Thu, 04 May 2017 19:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=76ibPTPt5VvZinoDk8B5MomQYi2tmipa7UC1qJ1Zeic=;
        b=SAvgvCK9x0dkgL7BfkJb3LNqBy720zUZf4NDJceSdWeVTpuHOUq+rO2k9NI0XkVc87
         XyOTMRPpYV8AtjMrRIbdHs8phlMSg/GCDmAclwPAoEer1h08hOujveynJEg0lFDm1wPh
         lMmavjnsR/ThH6Sq+Gf9nihBlTrMIUqjHQ5PRaCviMxsx1e1ouxAuB4evxBA1oUYxtBn
         m7jvcX8hroUE6YiBhpsfa2kOuDsQrPuBRAwzTT+qDQ+xnvGsbQq9t6XPEDkK7qkMlL60
         iEo5O0Q1Z0Y+effpO3PO7ZHusOugGcSt25/fDg3h0XJuKil1ne1mOuplnnOaNb5Fl87X
         pBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=76ibPTPt5VvZinoDk8B5MomQYi2tmipa7UC1qJ1Zeic=;
        b=Nei6wdpcvlA2tyNgSaD7ZVQ6jxZjMf1vYB/KPcjXdhpfjSGEcfRTJVQaPtG6RJ1+BL
         24RFtzKtrvLPQQx8FT96cS99gOnTWL37E+Ix+8LzyoM3hlNHdGWetuf9iQp9PWTUFbBt
         yr9EnTDjAaw0A0mg1xOPS7kaak76xSgDP3SNFZcvIYQ5mGbGaYymJ5cvQMLQF1rSMPhp
         Ulk7QLGKcrkz3+YS/ySoDlw5hRJNQjyTxwoxvdOu7CMBKQmmkZz/hdihH2DzKXtMO48B
         67fvepqOYtdX56m0W6TbdLmW23Ww0yxwPizXYfqJ5AzLIcLfzxHB+Ukl1bLDu697QBgH
         fJVg==
X-Gm-Message-State: AN3rC/6Kzrht+CPrlFN34i3tPOPlNBiYoicQTSVDGX+kSPjBX1mYDnB3
        0tqrl4ekMj9ZgvdLP8iduS4bIV8IUw==
X-Received: by 10.55.39.138 with SMTP id n132mr11927714qkn.157.1493949816326;
 Thu, 04 May 2017 19:03:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.175.36 with HTTP; Thu, 4 May 2017 19:03:35 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 5 May 2017 10:03:35 +0800
Message-ID: <CANYiYbH=-AAs1s+tQ_7NiWbHCoEQWiAoavt=k=MJ1gj9aC=aSw@mail.gmail.com>
Subject: [L10N] Kickoff for Git 2.13.0 l10n round 2
To:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.13.0-rc2 introduced 4 new messages, let's start round 2 for Git
2.13.0 l10n.

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
