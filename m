Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B787020444
	for <e@80x24.org>; Wed, 11 Oct 2017 18:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757441AbdJKStK (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 14:49:10 -0400
Received: from ikke.info ([178.21.113.177]:45478 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757383AbdJKStJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 14:49:09 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id F200D44039C; Wed, 11 Oct 2017 20:49:07 +0200 (CEST)
Date:   Wed, 11 Oct 2017 20:49:07 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Ayush Goel <ayushgoel111@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Unable to use --patch with git add
Message-ID: <20171011184907.GD16800@alpha.vpn.ikke.info>
References: <CAEBs8jLnU44n2fhE8tGommqfEpFPdd0FLUtmeZXZ+qhB1RV6XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEBs8jLnU44n2fhE8tGommqfEpFPdd0FLUtmeZXZ+qhB1RV6XQ@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2017 at 11:16:39PM +0530, Ayush Goel wrote:
> $ git --version
> git version 2.14.2
> 
> What more details can I provide to help debug this?
> 

Hello Ayush,

Run:

  git config --global color.ui auto
  git config --unset --local color.ui #in case it's set locally

This is a known 'breakage' because people have set color.ui to always
(which should not be used anyway).

Kind regards, Kevin
