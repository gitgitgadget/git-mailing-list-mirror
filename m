Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A65941F991
	for <e@80x24.org>; Thu,  3 Aug 2017 16:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbdHCQ11 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 12:27:27 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:35000 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbdHCQ10 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 12:27:26 -0400
Received: by mail-yw0-f172.google.com with SMTP id l82so11653728ywc.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 09:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=05dkzwiOWrg41QVAHqceIm3C9yzk0piTJEhJ4o4MJVA=;
        b=Y09y41VY/g5bxhjOK/WLYBiNXxggDrUvV/8WD7He99OWxmny0o4nmYijvgT1NIvjD3
         sK10KvA+ZvSzz1hlyqtzNMTxDJYkKc24l7r8MX92DrZAbeZC+lXn8UAUzA0ubVQN3GuV
         CJvy7OQL+eLnYuKxcTYE1G7aIUgUmef+3oikPU+y1kkqPohiJf5Eq3y/n+5/z6lKHhim
         MAMC1dh1fdBNvbAF4Me/IsWxLZMx/0jAFP4PjgEFTFjWrXEuliqg8qEYmkzZz1SZ9l1L
         qwsNQGIPz3hEq2WEqFWah0Gm8K35CxsiDW3eXJvP0bFYWerZDX3NoW633h2at69oLkeL
         S6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=05dkzwiOWrg41QVAHqceIm3C9yzk0piTJEhJ4o4MJVA=;
        b=ZjLvp55+0z76fP17JjYB08CQrlEF6MCwgNmNSGgMRCAjt6Lkj/UWEDh61XrFf/Z70Y
         /zzxyv+kk0J1JOgLudtevxyL4cI/Gxaru1ZNMJiR5oiYHWXcsIu3SpHvs4yYx3wfCH5W
         nK/+man4+OIrBva/cy7MIuRpXMbLSBag3uz2kCK8db4Vf+zcx4zMKyjnwC4pIJ8cTlqu
         r21y2lRRRbCEgZaMT2/xfz+QzlF9MMbyGGI3JywgnKoYkqUmn4TfYWZ4AgQlrigwRKBj
         QNTGCf/9jTlCxXwT+bEAd6j0pJfZYxLFWLefowrmgCdz72H6OqXveci/YKdgGXnDxEUz
         PPkg==
X-Gm-Message-State: AIVw1134b0EsSj9dU2zcWu5as8pywHcxVfU2DLbs0TQPhB30db1TVCwL
        AAKWblckiPMSrTD4Le5e5D3Wt0laHF5AQA0=
X-Received: by 10.129.159.82 with SMTP id w79mr1711778ywg.393.1501777645445;
 Thu, 03 Aug 2017 09:27:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.215.84 with HTTP; Thu, 3 Aug 2017 09:27:05 -0700 (PDT)
From:   Alejandro Aguila <aguilasainz@gmail.com>
Date:   Thu, 3 Aug 2017 11:27:05 -0500
Message-ID: <CA+kp=uoHiP8t_40yZvT7r9ziB4uSxgcc=NRY0+XzQJDkuJpx4A@mail.gmail.com>
Subject: Cloning an specific commit from the hash
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there!

I've been working with Oscomo's project OpenBSC
https://github.com/osmocom/openbsc and my old hardware won't work with
the latest version, which is 0.15. So I asked for help to osmocom guys
and there's someone who told me that his version is working with the
same hardware I have, so have gave me the OpenBSC hash for it (
7f100c9712de5c684462e809bf31a58c0c326337 ).

To be honest I don't use git more apart of cloning repos, so I would
like to know how can I pull the files for that hash. And since OpenBSC
has some dependencies that are in osmocom's github repo, I don't know
if I can get the version that worked for the one committed in the
hash.

Sorry for the noob question, but I've been googling and trying some
stuff and my brain is now blocked. Help will be very appreciated :)

Cheers!

--=20
Alejandro Aguila S=C3=A1inz
