Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B121A2047F
	for <e@80x24.org>; Wed, 27 Sep 2017 22:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbdI0WGb (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 18:06:31 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:49479 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbdI0WGb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 18:06:31 -0400
Received: by mail-qk0-f169.google.com with SMTP id u67so14751148qkg.6
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 15:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZFIbSUQM9+4U1K4HFkEtrCLU+WUm65K32OFvVBOiJ+0=;
        b=d9bH49hZvmTGPN1GvoUiXxbGT2XsL9p0+muVLMbLsCK5YM+f/8xi/JFEiR3OlwcWwK
         6P99IGy+ahZbws+N3PMCD0VUd4EkXJJg52B8MgYir0KTUmyCzboXC3GrTo090IrXTOYx
         XVNZguF+XPWOvL2pzn0cbJSbZus/6a1QtGpWTcU6VjZEbGCSprHuyEDTv/JkFvcdCu7Q
         tWWhdVdg748W2R6E2bAppuVbjzv1aSW5DgJ/8YcWKsJGTaHJMD13Le+ujsa/v+E3w7uk
         OEUjfagGCta6PTfQgT7v75m9hfx0VTHlAWCa+inumvFiasPIvmoUJ/wqFMyifOKhRgLa
         SPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZFIbSUQM9+4U1K4HFkEtrCLU+WUm65K32OFvVBOiJ+0=;
        b=VQgGf5mx6FMSoudMvfQoqv3W2s+IrFpVKhFpYBoB+Z57L6LURYu/Q4sMm386fl76o6
         7SuBH42r0VpMLcl4Lw7tvmrIrhPzstsltDagKB2R8X48DCmQoFkea0KUaZEqEcTOHj6L
         EOxlysuuHgTTdtZJ0pNDElIaWfrlBe2fWq2VZTsYiUCWLAj5djMc1BBh97DDavAg/yEj
         +mukq/L8oDdYQZCW+15UXWBvM0Owqb/hRX78Mt+Pekh4/dc9elsHZXDtmkDFBQGMVqNO
         5XpUfV7x9ouhSnBr6Ay0Bo3ykWdNZXQJ0QL3s3dt23DE0LwXzqcZWK+wtWW2WGrpxSq2
         Fbxw==
X-Gm-Message-State: AHPjjUhL+/igPoFJ7Zjsvkca0OFvycC1yHup5S5wv1hqaiqIypwgTqPH
        AZ/d5mCUe+SPiHkM7bRQwnMBbktisyET88P87MCsSvbI
X-Google-Smtp-Source: AOwi7QAUb1JW3SsvXmDb/uaPXp4v/SSRpXZfnvGf85547kRYjTOM9qtLEwDfamGjf4hxFJfsA19UFKVDhzP/MAlHYuM=
X-Received: by 10.55.76.134 with SMTP id z128mr4427492qka.183.1506549990058;
 Wed, 27 Sep 2017 15:06:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.54.124 with HTTP; Wed, 27 Sep 2017 15:05:49 -0700 (PDT)
From:   pedro rijo <pedrorijo91@gmail.com>
Date:   Wed, 27 Sep 2017 23:05:49 +0100
Message-ID: <CAPMsMoBK+EQZQx4FUs_EqN+BE+93-mtu9kzViqQ6B=LUOFESbw@mail.gmail.com>
Subject: hacktoberfest
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

As some may have noticed, GitHub and DigitalOcean have been promoting
Open Source contributions in October for a few years now.

While the git repository itself is not hosted under GitHub, the Pro
Git book, git for Windows, and git-scm website (at least) projects
are, and could use this movement to get some more contributions, and
eventually more maintainers (at least git-scm website had some
maintainers problem some time ago).

I've been helping on the git-scm repository (mostly filtering issues
and PRs), and I know there are still some issues which need to be
addressed. If the remaining maintainers agree, we could filter and
provide more instructions to some easy (or not so easy) issues, adding
the 'hacktoberfest' label and try to use this movement to solve some
problems

Probably, other repositories could also enjoy the opportunity.

Here's the website: https://hacktoberfest.digitalocean.com/


-- 
Thanks,

Pedro
