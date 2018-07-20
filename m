Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ACB81F597
	for <e@80x24.org>; Fri, 20 Jul 2018 01:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbeGTCW6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 22:22:58 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:40249 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbeGTCW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 22:22:58 -0400
Received: by mail-oi0-f46.google.com with SMTP id w126-v6so18497675oie.7
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 18:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=64XQiZ++7yLET1mwDKyQ/IhfkyTO7SgbZI5jPojE/B0=;
        b=m06S8AbEgdLFJIHsPHVTJO7KjFI8gWnyOgwumUhrSOR1lH06bNA0xiePb5Z6Xqarln
         FO+nbWoOhAqeTOYYWvBhj5381KDhlum5pkv4aRmG14gMIvIjBX6cr3MsTRf3UU/lL29P
         VSQZ9EkHUthFPJKo9GRMIZuY/0cbTHBq5KUa+xXdESiYXTOijcRMk3wAVS0Izkm2+xL+
         StBLwNzHbodX4yYoOqJ9tI0dOQBYUT5aS8uboTRiJn/8nzTTgBLyrnoLo4V3pj6z4ETt
         Q6wT9o+Qr3FCRrjuruuNnppEX3iMPGwHkvW4sWeZHnJWOeAcb6myz2w/Z3na9infABC+
         gkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=64XQiZ++7yLET1mwDKyQ/IhfkyTO7SgbZI5jPojE/B0=;
        b=rsIDIwPltt7+cLpdjqU5TBX6nhV4fygBhBAt+ZG9DYy9lq70Ts3TBDpRmg2Xzp2AI9
         8GCV+IaiRDlZVSXqCy/ggS+jB4PGMgYeCT/QVJSgWrUVDYXxtivFM60ycsA3pkyvCVa8
         aYiiXiqomXX5uNFWxXwm64QBbuNal1xsUrWOJMQsuIUPh/uZk56n/5ecMKtJeSBFj/Yw
         IWNqX1OiJgBHbij9k7bswoi2g8vo2YC0332W86A8PjHtuysxqwkvIQHCbjQt0MZawHTI
         xPaT1zbNxvfd4Or/gknXq5Iw1q8jr4g8rg6sf/4bpGt/SqGdDIF1mgmwOTFl9pVSMRBu
         apsA==
X-Gm-Message-State: AOUpUlG9v5EoDTTI5VAubgsA/ReuPNxWf6hjkuLSHmXdJIWRo40v4KJ6
        4MKfarCzB3F6IXgJMXUXsq2gYmbTSsayFazgIcvQ3DhS
X-Google-Smtp-Source: AAOMgpcli05J4yigTdprBPwOMEt5dVvw9/kcEz1FhD+a+xDEII9NscIhlw/duppQAWkk/t5NUJfGX47m1vCzvyT2SLY=
X-Received: by 2002:aca:cc46:: with SMTP id c67-v6mr42447oig.197.1532050629512;
 Thu, 19 Jul 2018 18:37:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c689:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 18:37:08
 -0700 (PDT)
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 19 Jul 2018 21:37:08 -0400
Message-ID: <CAH8yC8=oruFBtkndQ0p9N4s23SMvjjrAC_E7zzKRSVbjEwL0FQ@mail.gmail.com>
Subject: No rule to make target `git-daemon'
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I'm working from the 2.18 tarball on Solaris 11.3 x86_64. I'm catching
the following when building from sources. This appears to be a new
issue. It was not present in 2.17.1.

    gmake: *** No rule to make target `git-daemon'.  Stop.
    gmake: *** Waiting for unfinished jobs....
    Failed to build Git

There does not appear to be an option to control building the daemon:

    $ ./configure --help | grep -i daemon
    $

Any ideas on how to side-step it?

Thanks in advance
