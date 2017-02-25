Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5D962022D
	for <e@80x24.org>; Sat, 25 Feb 2017 07:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751614AbdBYHlK (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 02:41:10 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:54729 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751554AbdBYHlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 02:41:09 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id v1P7eveq000515;
        Sat, 25 Feb 2017 08:40:57 +0100
Date:   Sat, 25 Feb 2017 08:40:57 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.12.0
Message-ID: <20170225074057.GA460@1wt.eu>
References: <xmqqd1e72xs5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd1e72xs5.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, Feb 24, 2017 at 11:28:58AM -0800, Junio C Hamano wrote:
>  * Use of an empty string that is used for 'everything matches' is
>    still warned and Git asks users to use a more explicit '.' for that
>    instead.  The hope is that existing users will not mind this
>    change, and eventually the warning can be turned into a hard error,
>    upgrading the deprecation into removal of this (mis)feature.  That
>    is not scheduled to happen in the upcoming release (yet).

FWIW '.' is not equivalent to '' when it comes to grep or such commands,
you should suggest '^' or '$' instead, otherwise you'll miss empty lines
and users will continue to use '' for that purpose. BTW I do use grep ''
a lot, but only on file systems, not within git (eg: to display contents
of /sys).

Cheers,
Willy
