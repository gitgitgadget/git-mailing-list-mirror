Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2C4F211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 12:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfANMTY (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 07:19:24 -0500
Received: from mail-yb1-f173.google.com ([209.85.219.173]:46814 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfANMTY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 07:19:24 -0500
Received: by mail-yb1-f173.google.com with SMTP id y7so4581208ybg.13
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 04:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2QIkpto9S+RVaj7zit1EcLcUi/RsinuxKWGDuUl37CA=;
        b=QvHbb808If4+Bi0kbGS2UMU0+IapHgJKDQEE5mPhgWuPbG4f/s/6NeBefSAgistb3M
         oWT6W0ssNksedl1nRxn1x20YK6ChuKn0/QZcN+fMfcR/RWBwaD6yxRamzvz+eBxLrV6T
         whU6lz6S3Gk5HhX/EBdkS2tGuVZIw7C1XudrsH+kTNwgV44/+6xoRF5WeoC6dD2cUa2l
         J2tJwkeSkC0CdMYOkO4Eryk0x/AWQAFlPzUkfctcFi5PL5NMvnz+waYJTHyJ/VIK8bwW
         bzZaTVZzptE4GIT3+PsIYLN984yDqnf+Ub3XrCSgurHNezKK+snrI/6Fyt1B8lwpW2DW
         n0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2QIkpto9S+RVaj7zit1EcLcUi/RsinuxKWGDuUl37CA=;
        b=johIrawdFOUyDVTB5epzO5GvJiOPBcnzRzSmvnMDAI9vJ5HG1eCEmb0n0YrMgdRZDI
         PHQrtKPRwh7CFhmx032LfE1YROK7TT6mySLT97ioSPeQGlgjj4LJEhJ+0UqHUUdeOBRh
         Hovg0TzVqpMQAtwY0lE53PPthaH1gzlzr9K7sMlzC2jcf0+yC/+E9zo1Q9emz9MHGfAW
         Cf4MRrHpQOtePdfzTUbIr3Wag2mNleMCI/1XU4NKqP2YngZ1TyXbzPt/CoT11xqn/HWw
         xblkNKNYf5uLgRS/e743N+AQjiAxlAa2AHwuIg87iyCJjac68FsdMEQKLM++dyPC2R7z
         o4xw==
X-Gm-Message-State: AJcUukdvYhbCrPtBe49c27/2UgqulnHRo5syT9kSX3Lmud+u5BaHNRWZ
        t12+lGRmrh2LoqrTzmbocTedjGCdgiF7WCjD9J5tgAls
X-Google-Smtp-Source: ALg8bN4bP73Ldajep6g45nAFU1Ch4XCRdT0Ei2DasnKPhLNF4WDq7GrrKSVVqnc7Q3BJE2P5BJeS99CNRCOOuFigI1M=
X-Received: by 2002:a25:ac2:: with SMTP id 185mr23407351ybk.349.1547468363248;
 Mon, 14 Jan 2019 04:19:23 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?zp3PhM6tzr3PhM6/z4IgzqPPhM6xz43Pgc6/z4I=?= 
        <stdedos@gmail.com>
Date:   Mon, 14 Jan 2019 14:18:47 +0200
Message-ID: <CAHMHMxXyB=1KW6Hx7cs11Ltf3X_wuaQNfaYPmcnr946y4phXsA@mail.gmail.com>
Subject: ls -files missing from git-completion-list
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have install the latest git version from the PPA:
$ git --version
git version 2.20.1
$ lsb_release -rd
Description: Ubuntu 16.04.5 LTS
Release: 16.04

Running `https://github.com/git/git/blob/master/contrib/completion/git-comp=
letion.bash#L2898`
does not give ls-files

$ git --list-cmds=3Dlist-mainporcelain,others,nohelpers,alias,list-complete=
,config
| grep ls
$

=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82 =CE=A3=CF=84=CE=B1=CF=8D=CF=81=
=CE=BF=CF=82
