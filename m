Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40E691F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 10:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbeCZKAE (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 06:00:04 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:55668 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751035AbeCZKAD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 06:00:03 -0400
Received: by mail-it0-f53.google.com with SMTP id e195-v6so9937289ita.5
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=YABQaxC3T7D5ywCiqJP63y9SJtWle1M+8bIzYgP6Ntk=;
        b=hu8LDy8eao1FSP+6ryKfb4kUfR2WRsSSCAOh9V2ntlo5QNCVDTDubTR5e3HRUiNQR8
         bt4rF/qjkbWptGfo3ZQZrzv9S+kHKik1QP+jGS5TzhH/8BVqpjD+cXKl+AYk6YuVNCFK
         gAp+d0SqLzIH+uuzq9lspU73PtbeVE1H7i90805VTWUAUyECf0JBJ4NH4lGQ5pRqWs4l
         CyiTs34Dmrv2jW9Y7VzPNeGMhQ8cdgweZOeCX5bdnvQVToAfZvLmD1QqJatonz30GFbs
         /bggYVkB9eoqAzZOMxV+2W+mEWwAtmcyK8WkoRm3uemRYc4enyLgJZL46gp7jNqgi3jY
         ewOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YABQaxC3T7D5ywCiqJP63y9SJtWle1M+8bIzYgP6Ntk=;
        b=DRci8eNiFbrkPlhtYFH0S5tp77SK/LTyYvQwsGTc/bqZi1FyXRxtA3/M/knMOkS5Wc
         xzQXzxDanXKwN56lvEpfldzRCj/g5OMPeMUoIdew2bvx9xd24AmCsFuHZejXz/vEDaAE
         akh8pqnQ6qn1aF/47h398K+miK65+5t3WcE4kwSj+TclCHJJYnlmJ3042wH5OXkEgwSF
         tDaaFi0ysGuDn4E+x59FE4kR0GXnzS6AJuopzJpNgNYzpUSvCowbaJpTrkRFGShjnYME
         qM8ViomSPmJ3Kw/gZXUcx432xKSksPGyLtJTMizJhIx5i9oPe2zOcvQJkfhJRWm8NY90
         fOhw==
X-Gm-Message-State: AElRT7Hcxjl7M1sODgS7h78JHUZ2T0Y5Fajn9L0m4MbDrjKQjQZOxpKE
        VKIUfPx3iBeItiFXzDQDpz3yRGP/+AuyctmVKdixzA==
X-Google-Smtp-Source: AG47ELvsTZtc2gsn/JXFTjIfF5LHT2KqzyFk/wrZB3niwukbCGCWLEewtYpfaf2JxMf2dnf7vzGdVG+/oEaC9MfdEHI=
X-Received: by 2002:a24:790c:: with SMTP id z12-v6mr9088079itc.13.1522058402477;
 Mon, 26 Mar 2018 03:00:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.164.37 with HTTP; Mon, 26 Mar 2018 03:00:01 -0700 (PDT)
From:   Brendan Maginnis <brendan.maginnis@gmail.com>
Date:   Mon, 26 Mar 2018 11:00:01 +0100
Message-ID: <CAEFNKCXYdJpWkLUqMryPjepWtGMkA2BkxcxDnY0aXGE0fd1PGw@mail.gmail.com>
Subject: git shortlog --author=Me
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I have a .mailmap file containing
  Me <brendan.maginnis@gmail.com> brendanator <brendan.maginnis@gmail.com>

And I run
  git log --author=Me
I see all my commits

However if I run
  git shortlog --author=Me
my commits are not shown
