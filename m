Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694531F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 15:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbcHOPEz convert rfc822-to-8bit (ORCPT
	<rfc822;e@80x24.org>); Mon, 15 Aug 2016 11:04:55 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:34415 "EHLO
	mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbcHOPEy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 11:04:54 -0400
Received: by mail-qt0-f170.google.com with SMTP id u25so22216879qtb.1
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 08:04:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=XJFsoD1lirZJf7lRKcOwT4VhTtrJRNmC70LrqwszupA=;
        b=WJ7bNSX/+wGpJ7HbJrDiORX1II1H9oYAvGzxawzpBFCL5CpJzmwmao0y24T7lPToaG
         I3ft+qaDpcRAzxfbp4Raps1zCEq1HYKz3ZAiu2GNoncLaOPceUBesd/EN+2A6vSOTkQh
         tDIhdla6tOty/7riZ1m/iv4Zr+7kS9+6olkmbDl8g6LfRSTCX8VFJm+j429sNPV0lsBD
         fzVVSCCo0/1y3GTnxrMc6xOes6Yu6jW2eh4qMkX41HJzwEB5aDuRHFKRLeGr+NVbyqBG
         llRny0o+f5mKzj9Sh2uIiYgB6QE/kvO/qYbvZQnvj/7kehmF+m5CxFzuiN5X8AP8ULKT
         TEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=XJFsoD1lirZJf7lRKcOwT4VhTtrJRNmC70LrqwszupA=;
        b=grzZG1iq+1RncygsVChAZZL7D+cIOIRCp6pAFSearsepfRZ0obxHjEALhTGXPpeJVQ
         ec0R/niToB/Votv2nYnyDVE4rZhOActcry5IOrcIETkyhk7uTHz8tB0F2phwNWRJ1c68
         VKTGEUyGKmOx6up2aPYBJ9s2pYEhH9iaf4pfzQgjm89tzH6wUlHZEFQN2TnmFaVA5/YA
         153Qz81sRqQklDyqtlfhvBtVp+IB03Ge777UmkPZKOuTJQ4Q0zvnW8JIoXSq5AOPlRHI
         s0e3y2aHgj6k8A5sapiv4HNndZs8TAztlBmOu5XIZx5eFeklBkI90WdjEg1Y8O2tjUf/
         Gjgw==
X-Gm-Message-State: AEkoout+m29GLxymppeYiKxTjqIKnyAiL7e1dcZh+iLWbL82JRcZ3u4K3BUQJ1ksUTryoeZZqwJkolc1/17YsA==
X-Received: by 10.200.40.235 with SMTP id j40mr31501386qtj.99.1471273488404;
 Mon, 15 Aug 2016 08:04:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.233.232.19 with HTTP; Mon, 15 Aug 2016 08:04:47 -0700 (PDT)
From:	Jiang Xin <worldhello.net@gmail.com>
Date:	Mon, 15 Aug 2016 23:04:47 +0800
Message-ID: <CANYiYbGL+GVRNuhszp1UShaN_oJgm3netsQxZfbW74pVK0gOYQ@mail.gmail.com>
Subject: [L10N] Kickoff of translation for Git 2.10.0 round 1
To:	Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Changwoo Ryu <cwryu@debian.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Nelson Martell <nelson6e65@gmail.com>,
	Brian Gesiak <modocache@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

Git v2.10.0-rc0 has been released, and it's time to start new round of git l10n.
This time there are 248 updated messages need to be translated since last
update:

    l10n: git.pot: v2.10.0 round 1 (248 new, 56 removed)

    Generate po/git.pot from v2.10.0-rc0 for git v2.10.0 l10n round 1.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in “po/README" file.

--
Jiang Xin
