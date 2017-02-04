Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAB231FAFC
	for <e@80x24.org>; Sat,  4 Feb 2017 05:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753753AbdBDF1E (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 00:27:04 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34182 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753677AbdBDF1D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 00:27:03 -0500
Received: by mail-qk0-f193.google.com with SMTP id e1so1517976qkh.1
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 21:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=66uGzINQ3ZX/4S+I5RG0TJa4X29YwF56cmGZan2ZROs=;
        b=QQhh0KeNlsqzYuu9RVSZ0db+lNCgvoteQTAftqLHQreYJtTWSeoKP02JmA2Xi+RJGp
         WeGB97+dnh5UK1L9BvRhkq/KVEomuJvhhiTvmMoEEAXDINL9jPfADZB7BWAh/FSg7anM
         WC3wdsxGmvI+4kNEBu8n4LeUgqRhDCe5gWYISAvElV8h5sJS5drz0pzdxSLRbZYxqQXk
         kqE0cUSw22nmkL/0pMqocG1LOtsPnl7ARZQ9FbnPjtS1RHKetWh9B8tq/JfRb/RYbLzo
         AS/EnGmJThGFufdq3HZinxui+vyQ2VtEuttrOZ1YFC/HwHT0IUElF6TfJ9HfypdMSWO6
         tGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=66uGzINQ3ZX/4S+I5RG0TJa4X29YwF56cmGZan2ZROs=;
        b=LYlt/O3OoxPPXWoIPaMor22inPaVayAncan3ttW9AwJxJGyqeVEJrcb2JeUHaU7LCc
         BrimBfusmXNFi2YlYaiCh5R1825qg0I0D0ty8yY2QQbMAzL5IWCPdtbpYmzF8+hIWZWh
         DLpgfHrkKzLzQWP2FMgK2vi2AYRd/vt5k8+iXg3QoAYOTJ2y4AlYUF1pLadksPb0IaTr
         t2sOEnIXJFIFCXSvEAdS4MAXclXo1/vbF9nTvde/xKlQhkzyBNYQy7F3s2G3D3kHDSVG
         wvEHSN4YXFHSchdphstrykn1UpWsAxyaPpKwaTI+7MAedtzvZNoXX4kA+pMxER8eDyLS
         UGZA==
X-Gm-Message-State: AMke39kOxUY+IPhEJwYCKXPJFFembRFko/qBUodRShn1KKjnEcgdkigwYcZe+s045cNofccGkypkvHc3K5vqfQ==
X-Received: by 10.55.22.97 with SMTP id g94mr475226qkh.287.1486186022899; Fri,
 03 Feb 2017 21:27:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.149.120 with HTTP; Fri, 3 Feb 2017 21:27:02 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 4 Feb 2017 13:27:02 +0800
Message-ID: <CANYiYbGObPD5dX8mJe914MK_Um-gPLMHdaRFjie5Y1iThjmtEQ@mail.gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.12.0 round 1
To:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Ray Chen <oldsharp@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.12.0-rc0 has been released, and it's time to start new round of git =
l10n.
This time there are 200+ updated messages need to be translated since last
update:

    l10n: git.pot: v2.12.0 round 1 (239 new, 15 removed)

    Generate po/git.pot from v2.12.0-rc0 for git v2.12.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin
