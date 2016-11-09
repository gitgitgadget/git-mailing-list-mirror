Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7CC72021E
	for <e@80x24.org>; Wed,  9 Nov 2016 12:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbcKIMjj (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 07:39:39 -0500
Received: from ud03.udmedia.de ([194.117.254.43]:44978 "EHLO
        mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751969AbcKIMjh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 07:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=jump-ing.de; h=subject:to
        :references:cc:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=k1; bh=y7A4YojPtyqdNq
        zcL61Ejg4QDoRyOJQtYFU5K5HJu4E=; b=VEaM8IQhTmL0v7zTVYsmb65KdH3mQ6
        BDbthglwCq5b0Y9LdPSnEcR04L4jkCOZTJzjpDumsoVWRdUO+seIPzSHCnsNeoKG
        8RhoKX0mVLtat07iDgCkYwUlioUyQxjxCd7HlZROpzMdXxObCyiYefd6fmmpmZoP
        RdPOAdHxsQ2UM=
Received: (qmail 30924 invoked from network); 9 Nov 2016 13:39:34 +0100
Received: from hsi-kbw-37-209-119-31.hsi15.kabel-badenwuerttemberg.de (HELO ?10.0.0.102?) (ud03?291p1@37.209.119.31)
  by mail.ud03.udmedia.de with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256 encrypted, authenticated); 9 Nov 2016 13:39:34 +0100
Subject: Re: [PATCH 0/3] gitk: memory consumption improvements
To:     Junio C Hamano <gitster@pobox.com>
References: <de7cd593-0c10-4e93-1681-7e123504f5d5@jump-ing.de>
 <xmqqtwbhbql9.fsf@gitster.mtv.corp.google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
From:   Markus Hitter <mah@jump-ing.de>
Message-ID: <8eac2a5b-071f-6d17-4d81-0744db16910d@jump-ing.de>
Date:   Wed, 9 Nov 2016 13:39:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqtwbhbql9.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.11.2016 um 22:37 schrieb Junio C Hamano:
> Are all semi-modern Tcl/Tk in service have this -undo thing so that
> we can pass unconditionally to the text widget like the patch does?

Good point. As far as my research goes, this flag was introduced in Nov. 2001:

http://core.tcl.tk/tk/info/5265df93d207cec0


To defend Gitk developers, the Tk guys apparently change their mind on the default value from time to time. Official documentation says nothing about a default, the proposal from 2001 talks about -undo 0 as default and there are recent commits changing this default:

http://core.tcl.tk/tk/info/549d2f56757408f3


Markus

-- 
- - - - - - - - - - - - - - - - - - -
Dipl. Ing. (FH) Markus Hitter
http://www.jump-ing.de/
