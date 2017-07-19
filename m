Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 491E820387
	for <e@80x24.org>; Wed, 19 Jul 2017 05:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbdGSFpE (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 01:45:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34752 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752708AbdGSFpC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 01:45:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id p204so1887783wmg.1
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 22:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5XYBjKuHjWmnJ9SIwF0M7MkbAzYv+j7yGt7CgN5dPiY=;
        b=h0rW5o2J11gHus3NMaLGaBXVV4/W8VK4GmjNmmIlainj88NFSDA/obcbAfqan1Iu5C
         dF3ecIN5prkj2zpoZrDc+k0Aq+pNWODnoGefS9Xo6xoL495EnmCDgOP4Z6ADrfNsAfOY
         qmYOq/Jn8C0pDF5WW7UXrQHPb4NbizO8fUt3EHrVkVY+UK97NHGl6QfiGEv3pHuPG1Ms
         UxXbh5XJWXDZz3d9QwCjb5pczpg00Hf4762KKtcbJ5KuW//4I9aHAsVYrmLHFDY/kzur
         VmOmtqD6sCODeyQtmt5LZRzmhFS0fetJYmJrUnFHA/RX4G8nAFoHAOY6UIRGha5uLTMg
         yoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5XYBjKuHjWmnJ9SIwF0M7MkbAzYv+j7yGt7CgN5dPiY=;
        b=ikNaexnLhUKyREulRgUFvMmv7BHyACqQI59C0Wschp2An9QDPyniNIc/s9SLCRLGj8
         ef/h2x4wS4DsVmXLLA7bIr4tuUcn1C4T9UCkZ420NbjjTQ1yEy1H4Y8496xZpg6XOh+O
         9K1yrugnawjK2hm7cjLazek4uiaYf0TCgsof7zKEfKBSnc2au47A0CID9DyucubwJYGi
         zmugKgC6s8FktD9g99uJarJfJ6fHKl+onCkT1y/NMQC7cPB88oqTyFSBT4ifx47spvl/
         DDGy7CGoffplfncKHoyLsr4S1drYVbPY4ZBKiwlziKSULTpH6eobXbSQc3unkzyC8myz
         MolQ==
X-Gm-Message-State: AIVw112wT6OabzsnPq1YcPfaglZsUTl3kyrlQLHPdW74LMJ0l9JANRZR
        osGAt4fOEZwB618e
X-Received: by 10.28.145.12 with SMTP id t12mr3830249wmd.11.1500443101433;
        Tue, 18 Jul 2017 22:45:01 -0700 (PDT)
Received: from [192.168.1.33] (169.red-79-156-134.staticip.rima-tde.net. [79.156.134.169])
        by smtp.gmail.com with ESMTPSA id y12sm7405402wrb.39.2017.07.18.22.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jul 2017 22:44:59 -0700 (PDT)
Subject: Re: [L10N] Kickoff of translation for Git 2.14.0 round 1
To:     Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Nelson Martell <nelson6e65@gmail.com>,
        Brian Gesiak <modocache@gmail.com>, m4sk1n <m4sk1n@o2.pl>,
        Vitaly <vitaly.gorodetsky@gmail.com>,
        "Ying Ruei Liang (KK)" <thumbd03803@gmail.com>,
        babycaseny <babycaseny@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <CANYiYbET27mNrZZTNmn_dKBHLLEb4wJiznZ2O1X=WQ_GtamN7w@mail.gmail.com>
From:   Jordi Mas <jmas@softcatala.org>
Message-ID: <9f2b1205-01fa-ef7b-81ec-7717103936c7@softcatala.org>
Date:   Wed, 19 Jul 2017 07:44:54 +0200
MIME-Version: 1.0
In-Reply-To: <CANYiYbET27mNrZZTNmn_dKBHLLEb4wJiznZ2O1X=WQ_GtamN7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ca
Content-Transfer-Encoding: 8bit
X-Antivirus: AVG (VPS 170718-2, 18/07/2017), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El 15/07/2017 a les 07:06, Jiang Xin ha escrit:
> Hi,
> 
> Git v2.14.0-rc0 has been released, and it's time to start new round of git l10n.
> This time there are 30+ updated messages need to be translated since last
> update:
> 
>      l10n: git.pot: v2.14.0 round 1 (34 new, 23 removed)
> 
>      Generate po/git.pot from v2.14.0-rc0 for git v2.14.0 l10n round 1.
> 
>      Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> 
> You can get it from the usual place:
> 
>      https://github.com/git-l10n/git-po/
> 
> As how to update your XX.po and help to translate Git, please see
> "Updating a XX.po file" and other sections in “po/README" file.

Hello Jiang,

Sometimes I do several commits to complete the translation. However, 
github from the UI does not offer me the option to Merge and Squash.

Can you check that you have "Allow squash merging" activated for the 
https://github.com/git-l10n/git-po repository?

Allowing this from the Github UI will make life more easy.

Thanks,

Jordi,
-- 
Jordi Mas i Hernàndez -Bloc: http://gent.softcatala.org/jmas/bloc/
Planet Softcatalà -> http://planeta.softcatala.org

---
This email has been checked for viruses by AVG.
http://www.avg.com

