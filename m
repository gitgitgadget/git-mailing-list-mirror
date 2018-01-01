Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 312361F428
	for <e@80x24.org>; Mon,  1 Jan 2018 11:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbeAAL3O (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jan 2018 06:29:14 -0500
Received: from mail-ot0-f172.google.com ([74.125.82.172]:42214 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbeAAL3N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jan 2018 06:29:13 -0500
Received: by mail-ot0-f172.google.com with SMTP id 14so13480531oth.9
        for <git@vger.kernel.org>; Mon, 01 Jan 2018 03:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=z+V/RsGv+ulh10D07lneLJNtTSa8Xz9P+LFZK7fkedU=;
        b=Flvi5d7K4IErwsZfzVNk0W/hfAgiNeUTV9bWvZ1FOBqN/S9rdl3ddoENuEQzAdWyLO
         Jme9srjXZGtMJfQt5wDok4XXR3Od5kbWTwLtPPAHSqpuzQkhtwbHKbemCXu2PHq/pkBg
         ZDtG6f5da2yiPrzJlVQSLbXpQ49hNccnIVUQvgm4wRtZoeN20ZEqItXLrjYBb8Sih6OT
         LuEAf5LUNbkZBA4rPM/MHTaEuTndpzM5j8YWNUI4byeoQrnqunJ5fhI1QoaMLXohAZgq
         vNR9J3Y73Z7JZUyx9OpVUclVkOPDg5jSSzaqeZ8MbiEDFyZC2rEzltw6V/LT080ln0ED
         aB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=z+V/RsGv+ulh10D07lneLJNtTSa8Xz9P+LFZK7fkedU=;
        b=tCGMnp7dhz2cK8idlwAEEYfUYRG9TwN1UhiKKmPCSL7Z5YZ3XwXtyzYbKbaM2sdNy7
         AVEWsZh5BXq5g7diG1O/3r8H7qFgpic+VN5KwGb7EaLsSpauP0GWaGDbF3T4u8tvpEei
         BSqx5ELBafuAimSnPHshGAgIg/jjwPH21TcUgTDkoiGC9dTe24pu2dRCDm9gc62PefsT
         AJEbg84tB4FqOxr3ulEHPUiPllWNI9RKznfV7s5Qwde6Emsod4+k8fXPQcAaOacuy57S
         n8S10mgTmHYEVy5HQ+VINI0zXRg5CFci8o+ThPIDk5Ozl+3kbgWToq074W5WEvJIBnk/
         1zxg==
X-Gm-Message-State: AKGB3mLBh4U8p+cYQ2oV+iCzuKzCMTDrEu44IRk2AqYSFGhE/Ql6r35g
        IpzoQX3pXkEtegGBTVwgmct5OA4WZwOmD27QyNE=
X-Google-Smtp-Source: ACJfBotriMc1Gc/yLCWCm/DtAP/66X3VHRz1QQd2RaqpPCXkhP6nTLMftS/Kr0vJiGEL2npUeSZ/infnxwd3RigXP7Y=
X-Received: by 10.157.64.188 with SMTP id n57mr36656554ote.331.1514806152872;
 Mon, 01 Jan 2018 03:29:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.73.21 with HTTP; Mon, 1 Jan 2018 03:28:52 -0800 (PST)
In-Reply-To: <9e4ffb63-59de-a020-fee8-6cefae3b3dda@gmail.com>
References: <9e4ffb63-59de-a020-fee8-6cefae3b3dda@gmail.com>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Mon, 1 Jan 2018 14:28:52 +0300
Message-ID: <CAJs94Eakp6kaD=+imH2cZdB-=2NCBJNu0Rt=MmRtWiM60QGBSA@mail.gmail.com>
Subject: Fwd: Unknown option for merge-recursive: -X'diff-algorithm=patience'
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am running git 2.15.1 and facing the following issue with linux kernel
tree.

# git checkout v3.8
# git branch abc-3.8
# git checkout v3.9
# git branch abc-3.9
# git checkout abc-3.8

Introduce new commit on top of abc-3.8. Here, I edit README.

# vim README
# git commit -a -v
[abc-3.8 4bf088b5d341] Hello world

Then I try to rebase abc-3.9 on top of abc-3.8 as the following:

# git rebase --preserve-merges -s recursive -Xdiff-algorithm=patience
--onto abc-3.8 v3.8 abc-3.9

And then I see:

fatal: Unknown option for merge-recursive: -X'diff-algorithm=patience'
Error redoing merge e84cf5d0fd53badf3a93c790e280cc92a69ed999

Attached here is GIT_TRACE=1 output.

-- 
With best regards,
Matwey V. Kornilov
