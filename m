Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40DAC2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 22:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8B52465B
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 22:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgA1WDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:03:40 -0500
Received: from ikke.info ([178.21.113.177]:38234 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgA1WDk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 17:03:40 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 3EA474400FB; Tue, 28 Jan 2020 23:03:38 +0100 (CET)
Date:   Tue, 28 Jan 2020 23:03:38 +0100
From:   Kevin Daudt <me@ikke.info>
To:     gopi basker <gopibasker91@live.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git clone issue
Message-ID: <20200128220338.GA1057155@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>,
        gopi basker <gopibasker91@live.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <MN2PR16MB2894BF58BA9107EC1EE26362B60A0@MN2PR16MB2894.namprd16.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR16MB2894BF58BA9107EC1EE26362B60A0@MN2PR16MB2894.namprd16.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 01:11:40PM +0000, gopi basker wrote:
> Hi team,
> 
> I am facing issue when I try to clone using git clone command 
> 
> Getting following exception 
> 
> fatal: ambiguous argument ‘svn’ : un known revision or path not in the working  tree 
> 
> Could you please help to understand the issue 
> 
> Sent from my iPhone

It would help if you gave the actual command you are trying. It seems
that you are trying to clone an svn repository?

In that case you would need to use `git svn clone <url>`.

Kind regards, Kevin
