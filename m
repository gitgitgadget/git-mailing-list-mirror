Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BEB51F6BA
	for <e@80x24.org>; Thu, 23 Mar 2017 03:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753637AbdCWDBn (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 23:01:43 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45322 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751453AbdCWDBm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 23:01:42 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 4162E1F6BA;
        Thu, 23 Mar 2017 03:01:41 +0000 (UTC)
Date:   Thu, 23 Mar 2017 03:01:41 +0000
From:   Eric Wong <e@80x24.org>
To:     Craig McQueen <craig.mcqueen@innerrange.com>
Cc:     git@vger.kernel.org
Subject: Re: git svn propset and multi-line svn:externals property
Message-ID: <20170323030141.GB14619@starla>
References: <5500469A22567C4BAF673A6E86AFA3A40295E65B42D3@IR-CENTRAL.corp.innerrange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5500469A22567C4BAF673A6E86AFA3A40295E65B42D3@IR-CENTRAL.corp.innerrange.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Craig McQueen <craig.mcqueen@innerrange.com> wrote:
> Is it possible to set multi-line SVN properties somehow? Or
> could this be a future enhancement?

I'm not sure.  I don't use this feature, but it seems tied
to gitattributes(5), and I'm not sure if gitattributes supports
multi-line values, either...
