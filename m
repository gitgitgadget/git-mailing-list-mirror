Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D6A81F576
	for <e@80x24.org>; Tue,  6 Feb 2018 11:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbeBFLrw (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 06:47:52 -0500
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34150 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbeBFLru (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 06:47:50 -0500
Received: by mail-oi0-f48.google.com with SMTP id k15so1113206oib.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 03:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DRehnxcOphHJIsGimYcpUx7AVppjcX38mLqBiEeQRIE=;
        b=ivkYgM9Q4BevB4834yXODCgPowLbPyA8tA+YKOeYaztcmkd6DMjLEDu8HwCgt+Pzyh
         mlZJhnLXRdPAOUWCUKItntLR8shfbjIUbef4ZaEGa4WXCX73PnspckKYZCP8qMPsjB+7
         URpw1jgmNbtcxIwl7yvIZGKkMBXgp6OwiZU12Mi7DGdr6cewr1XSJdyHy4jQNZdt9aVU
         J9ZNSfc77wwTSy1YDOgUCBgRsX+MWSAH43Fj8TVHdwUrMQ+sPTmP3mHaTIXqTPryO8Iu
         mYFALornJ85SRc15Hhi2CE24Lph+6MKQ0yWeu73BPrg284/gIM9cUTi75ubRJvFCyRa3
         jo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DRehnxcOphHJIsGimYcpUx7AVppjcX38mLqBiEeQRIE=;
        b=IhhuYSF2/Fdv926BGGLmI+vW0/76v4be30ZrZi1Mrcr+0irJpfSO40yEhCAEhB57E7
         s4qv3Z5bbFwkfUa7lvQYkZD0RqCAKvGnbjxf2AelbLrv5kOeqQDO3aP7ucDFy9f3r6oC
         2cwlHBYZ8O/yu0aCnnPeXBilTZQNDYQqFfafFH/QGV2xvSnq9okIh6ul4Y5/0vMpZsjV
         yix7kAlpluTE+PgR/4rB2aJfaBqT1em4q6+PNuzPyPl8hL0ZsQqeZBr/C/dQ4b+saHTC
         O6h2rPJxOFZ3aFD4W16QB5KnMjDsppiEfPcjXw/B6M2Z+YrPnhVdVPeWPr3wH6YQdkaA
         n/4g==
X-Gm-Message-State: APf1xPBt3cGI61a2FYlS982Bo6FoUVf8wNKMyUqSEmYU7Jp+KkUglZOv
        v7909WyGO8Gp8oPQXLJD7xSSGrJSRckuS3spdYY=
X-Google-Smtp-Source: AH8x227dufy/5Sui7KGMdv6FuY+zvPJvXSMxYwkMZ2qfm+1R8uPRJKXFyk8vofOctAcwiFWeHkCXTRBTVCXa4o/QByA=
X-Received: by 10.202.49.73 with SMTP id x70mr1230990oix.351.1517917670428;
 Tue, 06 Feb 2018 03:47:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Tue, 6 Feb 2018 03:47:19 -0800 (PST)
In-Reply-To: <C6AF93BC-048F-4944-AB87-36AC2A5C5466@schwarz-online.org>
References: <AD196D8E-04DB-4274-ADEB-D914A79628B3@schwarz-online.org>
 <20180206004313.GC7904@genre.crustytoothpaste.net> <C6AF93BC-048F-4944-AB87-36AC2A5C5466@schwarz-online.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Feb 2018 18:47:19 +0700
Message-ID: <CACsJy8DcG5bKdo=PkQnbtaZF6m_ngC+WRkmiUzMhsrxokPQmcA@mail.gmail.com>
Subject: Re: Missing git options
To:     =?UTF-8?Q?Martin_H=C3=A4cker?= <mhaecker@schwarz-online.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 6:13 PM, Martin H=C3=A4cker
<mhaecker@schwarz-online.org> wrote:
> This however still freezes the default output of git forever.

Why is that a bad thing? Default output format should not change
(much) from version to version, or from machine to machine (because of
different ~/.gitconfig) for that matter. I don't want to type "git
log" on somebody else's machine and have a big surprise. You _can_
customize output but that should be explicit.

If you want good defaults, that's what aliases are for. I personally
rarely type "git log". I have "l", "lp", "l1"  and other aliases for
my everyday use.
--=20
Duy
