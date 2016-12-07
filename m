Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AC2C1FBB0
	for <e@80x24.org>; Wed,  7 Dec 2016 11:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752906AbcLGLRa (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 06:17:30 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:36197 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbcLGLR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 06:17:29 -0500
Received: by mail-io0-f171.google.com with SMTP id l140so90286276iol.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 03:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LB9wk8oNSXMv8HL0a7cTkVrXL8o7ffpQ/cQj6np+RHk=;
        b=qjC/cIbr8wktSxE/pbfFSlUhTuInYwpPIhR99R0zQpE4YgYkgDr8WB2kqH9Gpc+0ZL
         isu2hlkCe83swDilAmAcS5adFBsBs1f9IU+tNn62SuTxmuILi5ISLJB2j7nkrr7NKTTZ
         q6rLWjE/CReMaWwtywHL+d2FsaMcn+B+4HQkqJ2b/1v2rSqb5R4XAbbrnq8F7hG21jSj
         HjW2xymNCODBy2EwienGUuCgyA169XcZJ2wwPlPZl8E5HeAmkr/WrbUbMf6MyChk8n6T
         NHZw08V7i2x/IoUdMzK1k4DhMwj7iboDnp5CcyN/1yR2W7I44pqX45IG9NzRswUlJeS2
         sSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LB9wk8oNSXMv8HL0a7cTkVrXL8o7ffpQ/cQj6np+RHk=;
        b=QBW8VoK/r2IyVDkWUtFZvjaFoaaHxZIzv/gNiHpo8xBYpfIx+swFaiHyq1OEn8zlBU
         +U1Cukd7I4Z46ZxNzw25Zgr6klwp70Vw1FPYQLlRnT/2zdIlYrQe4vXx7bqSpfV6LPo9
         SO0F64jFzP4aCbEydpj6gQPUikBSLmqIOLUJr46+Rm4UVX+IWuWJJUSofP7fc0qlJoi2
         PQlrvOHTFi8g3QJg7vj/7D+E0L2XqnT6xP67ra7/k6CkEoPMJBrqouY/NMk0NFWdaTCX
         ooLQIY+cGLySzWuVGIp8JWMGJCA2PsYmlMf625Pt7rO6xVevjLkZPCUmN0kmJ0FOGRZq
         0V3A==
X-Gm-Message-State: AKaTC02hlFUgdndC9K1Yz9GTQxUwQLPxOokqlo67APz0f3v2SYNwkuwweNeFbsTi1B6Ez8bp3GziQA1PBxshNw==
X-Received: by 10.107.44.137 with SMTP id s131mr55113603ios.212.1481109439352;
 Wed, 07 Dec 2016 03:17:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Wed, 7 Dec 2016 03:16:48 -0800 (PST)
In-Reply-To: <5cfee62d-0b47-897d-0882-387de68d01fa@gmail.com>
References: <5cfee62d-0b47-897d-0882-387de68d01fa@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Dec 2016 18:16:48 +0700
Message-ID: <CACsJy8BzXcnD=gWDwdXb5=t8sG5gFXfOFi2aJSFgKGHxtNQUBg@mail.gmail.com>
Subject: Re: 1 files changed
To:     joris <joriswu@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 4:46 PM, joris <joriswu@gmail.com> wrote:
> When committing a change that touches a single file, git reports :
>
> 1 files changed, 1069 insertions(+), 1063 deletions(-)
>
> Note the plural for the single file.

What version? This should be fixed since v1.7.10, unless some new bug
pops up somewhere.
-- 
Duy
