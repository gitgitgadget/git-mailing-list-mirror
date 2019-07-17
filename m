Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2771F461
	for <e@80x24.org>; Wed, 17 Jul 2019 17:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387960AbfGQRP2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 13:15:28 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:54906 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfGQRP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 13:15:28 -0400
Date:   Wed, 17 Jul 2019 17:15:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1563383725;
        bh=HhuC1tDPziF3lWSAFThPukfhKeuTZ2FLH6ZTIuH0fDk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=INoTwCqCsobA1oWfm1mqhWqbh/7iDnOTNTNYOCtDfv1pM+YbiUWi9oOX+EXU+ZLSV
         yH6Pii3/nv8EouQpSnExac+1nK31yOjNqNfkEQFZn1LJD9YuwCM4VWsHYX/7yKxDNg
         RPy2LC/vknJLl1aH0fJ8cGcAMJcnYMFTbZNra4ow=
To:     Junio C Hamano <gitster@pobox.com>
From:   Thurston Stone <tstone2077@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitgitgadget@gmail.com" <gitgitgadget@gmail.com>
Reply-To: Thurston Stone <tstone2077@protonmail.com>
Subject: Re: [gitgitgadget/git] Adding git-ignore command, tests, and documentation. (#264)
Message-ID: <-_9xfW9lD1t4z4qkcMoJ5Jb9gmzayauqKOPDIYIQO4dJQzc-RoVWTNOi9-OsXDzrdhVJPWoRYIa5d0zqIsHBoNzMSuw1_jauUcEaGwIairU=@protonmail.com>
In-Reply-To: <YmOpqT5Q4a9QdU5RJmIbisRhQMnkcZt7GFT7E0xH4cqAWr0mEiHlYzLmpI8eKSPPQDZmQRmfUzdzqxDSb-iBwYhFHtJ6edCFb8I05ld0vFM=@protonmail.com>
References: <gitgitgadget/git/pull/264@github.com>
 <gitgitgadget/git/pull/264/c512358757@github.com>
 <YmOpqT5Q4a9QdU5RJmIbisRhQMnkcZt7GFT7E0xH4cqAWr0mEiHlYzLmpI8eKSPPQDZmQRmfUzdzqxDSb-iBwYhFHtJ6edCFb8I05ld0vFM=@protonmail.com>
Feedback-ID: GoF1_tGGzdAOfV85Q8wDmQNHA892t-4YSi-EkNmyVQICfrmBYcOej3w15ghxke-rA__wGaGMu4zRpxPIzpb40w==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

my mistake, my last email should have read:

$ cd path/to/the
 ... work in that deep directory ...
 ... realize that file.txt in that directory needs ignoring ...
 ... know relative path of both desired ignore file and cwd ...
$ echo path/to/the/file.txt > ../../../.gitignore
     ... or with this script ...
--CORRECTION--
$ git ignore file.txt
