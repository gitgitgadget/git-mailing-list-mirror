Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C0BD1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 22:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfFMW45 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 18:56:57 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:39922 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbfFMW45 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 18:56:57 -0400
Received: by mail-vs1-f43.google.com with SMTP id n2so559842vso.6
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0xyLEeLB0oHvgIOVAWm4+Lg0plKozJ525wXroXMEnM=;
        b=AL0F1O0iGu+tBRgmY4T1SqrqUFfrDmoYd6F/3pftXJQCiZx0N4SzSQAREfzaEs2q4c
         mHtRV0wk5gbFFfipad7OVjkijTO0IdmWii4ZWrZjOJ0tBne/KbhsmtOnDBK+NlV+J62c
         knlUJtp+o9zDf1TPL/QcjN4PRxTFsT4Cf/Q/mxJS99bdO4TexwNBgnkVDWiZkpgVguSy
         tNBlbD60eTvt6aJqpTUusk+Q1u85AlS513vjmHKr+kEIM44SoQZ9RyDNWgoAa3eU/7fT
         2yD8XwUpNAAqoS77YcvnNT5eqU1Bwlh0aSNthIUJPodXpSslkd34GKnV8yen+3hHxbEg
         CKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0xyLEeLB0oHvgIOVAWm4+Lg0plKozJ525wXroXMEnM=;
        b=FPWGHu58jzJySaiopVZaJ7Eyi/JvbmnfMRV6TBt/a2TrWxXkztqnFLcT0BxyqQcU8S
         2pJm6wcErim0+ydEh1ZLoBBR2/tNMowvpxcdgsOAd71dFN0Sl6kijIezUKlv8I9+/7c4
         aDVunWB5pIrFSlu7JduZ+rdWFYvB83/mPCEIO9ATSNc6q1QTccyNX9AVb5n1dW6TJu/2
         mbk2/Nqs8TrfvXNFMU52+ZrEYI4vmdGgeVkJUdnkbEYnMazORt4lUvNXnEkaxSKWsQrT
         pMkuCtNSc4oGXoj4hVsnVjgt1UdK/kIwpa/opkmbDiRa4I/HjzBSTsOVRoTCxiV9yIac
         +dRQ==
X-Gm-Message-State: APjAAAU89KBTkREp0mM3EPBbnnMGW2ItW0ZYIG67PRpnOGEul7pFHKgA
        0bO2xqPq3QkKGBvEn1yoy40XIz/xtV2ltmjAtDY=
X-Google-Smtp-Source: APXvYqwT5yYKUFizr6R+aKQK5enLm/7hfAx1cHMmOCl9P640dUfjDaLCh2VtlT28Cp3g0qbednls0moN97l/1QkAiro=
X-Received: by 2002:a67:f5d0:: with SMTP id t16mr3128972vso.175.1560466615693;
 Thu, 13 Jun 2019 15:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAEwRq=ohKw8o0R3mtcr5E0fAeEX_OMo5qCiVx3EWwp5B3BKU9Q@mail.gmail.com>
In-Reply-To: <CAEwRq=ohKw8o0R3mtcr5E0fAeEX_OMo5qCiVx3EWwp5B3BKU9Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 13 Jun 2019 15:56:43 -0700
Message-ID: <CABPp-BGQ0frtOk7ZF4vnLdfeYCXibUaC4zUV1coTz=AzOvy8Lw@mail.gmail.com>
Subject: Re: cherry-pick strangeness
To:     Vincent Legoll <vincent.legoll@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 13, 2019 at 3:42 PM Vincent Legoll <vincent.legoll@gmail.com> wrote:
>
> Hello,
>
> I stumbled upon a strange behavior of cherry-pick,
> running the attached script yields different results
> from running the same command lines manually in
> an interactive shell, one after the other.
>
> I searched the man page and found no indications
> that that should act in this way. It looks like the CLI
> args "--ff" & "--no-ff" or the absence of it are not
> doing the same in a script as in an interactive shell.
>
> I  asked in the IRC channel, and was asked to report
> it here.
>
> I tried to reproduce it in various environments, I
> ran it in Centos 7, debian 9, ubuntu bionic & cosmic,
> alpine & fedora, in docker containers, all giving the
> same results. The git versions tested range from
> 1.8.3.1 to 2.21.0.
>
> Trying to reproduce, I created the attached script,
> which reports 3 times "SAME", whereas the case
> using "--no-ff" should print "DIFF", if I'm not wrong
> in reading its manpage description.
>
> What am I missing ?

When you cherry-pick a commit, it reapplies its diff on top of a
(usually different) commit, preserving the author name/email/date, but
throwing away the committer name/email/date -- instead using your
name/email and the time of the cherry-pick for the committer.  Since
you are transplanting on the same commit, and you created both the
original commit and the cherry-pick, the only thing that can be
different is the committer timestamp.  Git records timestamps down to
1-second resolution.  If you run in a script, odds are that the
original commit and the cherry-pick both run within the same second
(though not always), and thus you end up with precisely the same
commit.  When you run interactively, you take longer than a second
between commands, and thus have a different committer date which
naturally will have a different sha1sum.
