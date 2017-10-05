Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4930620370
	for <e@80x24.org>; Thu,  5 Oct 2017 20:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbdJEUWl (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:22:41 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:48650 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbdJEUWl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:22:41 -0400
Received: by mail-wr0-f173.google.com with SMTP id u5so11549698wrc.5
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ShPQFAmIn4oB/EFBIoJ8DVghQy4a7SIuLdcDEHrUfmI=;
        b=vTfYjHFpNg7aAFHtCWa92Op+Kc6VNQ9qy5JV3VPfK7O/LJNr8OeIlGvntHW/afFUb9
         a+Las8qMPK6MBPd1aW0HDws8vS1UOE8p4mdfXtxTgOT+Z/AEHu39GJurQ/Usc61fwGE3
         bqZy8bvI05qD4sCrJDVzCEVvrSFVaE7bJknze+rVgTCCDCUroFoY0Xvtq49sLhGV/GzY
         oixnlaypFZkWPkQhiXKJpCBMOW2iko4hASz1ijjUfx1xHuSYUleJRtHIcedBfRgx5j9Z
         +3SLAfElxdfSfa0iipu2ydzs/uX7feH9uewdmSq7tf5vIkgwr05R2SMlX1tydmq4B76u
         y8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ShPQFAmIn4oB/EFBIoJ8DVghQy4a7SIuLdcDEHrUfmI=;
        b=NrBaxNWoi9PiIHP7eYrUwkhLsEp2UcgEORLYk1QhMRHwFIbbG65Lz1CysOcAvRJ09M
         kTlWhc016wEKw1caNpsPEJeMCUrjQAAy+PUTzMOUrifEo/W3VaAZONtbFCGHCY7I1up5
         nHVUFxSJjOo0Msx2+o32B8/5H1EncItgsRDXr/OSpqBtSF4TKhb/xqfqX/N1TVFLKisJ
         gHBfBpBNNf50wDz+I7OwSyLOxbU3quwNMqNuAyc6OxFqKPsPsWmHSbmknLOI/YaYwMur
         Gg/YaK07SdEIriS729zNhZQA0OacE+V1D5gTgOi4/fzpQb7rKTW1iYcYI48/KQ4lV42m
         B5/w==
X-Gm-Message-State: AMCzsaXQzw1OcNSIW47WxiaZjnHwnbBxkGxWVoADjgumDVP94kLtw7Wm
        CtP2we52bU0N3Wdp58jRXjQ=
X-Google-Smtp-Source: AOwi7QCL9Rmi/kciLdI0JREHW/U0v97zb2FVhVrQUJ/WEq0wU0edBQi0ITM0fJ83FuqaBX4vFZyluA==
X-Received: by 10.223.176.75 with SMTP id g11mr14021884wra.211.1507234959861;
        Thu, 05 Oct 2017 13:22:39 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB5A15.dip0.t-ipconnect.de. [93.219.90.21])
        by smtp.gmail.com with ESMTPSA id v5sm165807wme.5.2017.10.05.13.22.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 13:22:39 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [git-for-windows] [ANNOUNCE] Git for Windows 2.14.2(2)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171005200227.8028-1-johannes.schindelin@gmx.de>
Date:   Thu, 5 Oct 2017 22:22:37 +0200
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E2CD2BA7-130B-479B-84DF-A7AFA0EBF30F@gmail.com>
References: <20171005200227.8028-1-johannes.schindelin@gmx.de>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 05 Oct 2017, at 22:02, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>=20
> Dear Git users,
>=20
> It is my pleasure to announce that Git for Windows 2.14.2(2) is =
available from:
>=20
> 	https://git-for-windows.github.io/
>=20
> Changes since Git for Windows v2.14.2 (September 26th 2017)
>=20
> New Features
>=20
>  * Comes with BusyBox v1.28.0pre.16467.b4c390e17.
>  * Comes with Git LFS v2.3.2.

Just a heads-up:=20
Git LFS 2.3.2 contains a bug in the `git lfs clone` and `git lfs pull` =
calls:
https://github.com/git-lfs/git-lfs/issues/2649

I expect 2.3.3 to be out soonish.

- Lars=
