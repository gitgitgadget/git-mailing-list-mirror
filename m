Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E8D3200E0
	for <e@80x24.org>; Thu, 29 Dec 2016 08:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbcL2Izw (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 03:55:52 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:44918 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752424AbcL2Izv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 03:55:51 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 04C34200E0;
        Thu, 29 Dec 2016 08:47:00 +0000 (UTC)
Date:   Thu, 29 Dec 2016 08:47:01 +0000
From:   Eric Wong <e@80x24.org>
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] am: add am.signoff add config variable
Message-ID: <20161229084701.GA3643@starla>
References: <1482946838-28779-1-git-send-email-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1482946838-28779-1-git-send-email-ehabkost@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eduardo Habkost <ehabkost@redhat.com> wrote:
> git-am has options to enable --message-id and --3way by default,
> but no option to enable --signoff by default. Add a "am.signoff"
> config option.

I'm not sure this is a good idea.  IANAL, but a sign-off
has some sort of legal meaning for this project (DCO)
and that would be better decided on a patch-by-patch basis
rather than a blanket statement.

I don't add my SoB to patches (either my own or received) until
I'm comfortable with it; and I'd rather err on the side of
forgetting and being prodded to resubmit rather than putting
an SoB on the wrong patch.


(I'm barely online today, no rush needed in responding)
