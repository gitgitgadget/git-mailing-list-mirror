Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A7820705
	for <e@80x24.org>; Thu,  8 Sep 2016 16:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932589AbcIHQsZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 12:48:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63902 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754147AbcIHQsX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 12:48:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CA683AF61;
        Thu,  8 Sep 2016 12:48:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dseCMWJl+MMnZ2p9Sga7TesLRSU=; b=pSKTWz
        Wojq3q4rQKS2nACHAtk5L3G2y0AN2EQEVC+iQ4SX//X+hh29aYGV2l0FWNBn5E8R
        9IJPMjPZeIYDxEhO1KHZ9BXiYCD/nZDiOSfJNEL94zv+/8W1vSKQgInU1k6sMlcg
        a0I6M10qEAJrSufCAaUopclHTFwzCVUdgZYs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p+uCbXboNc1qYlmv1eXoFf478FAh3bQ/
        eDpp61ErgDLTvbzxvXiLxQzrdE7k4XzWDt8UfnjjsTylZpA4HYQAltozF5ymgp+s
        czgtHiFlOi8KXosttk+VJCdlVJWtw89ccS6mDyJrmXm+66TWzt4lKVO2LdfCwOBR
        3PQbu1cWTas=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 443D43AF60;
        Thu,  8 Sep 2016 12:48:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF5803AF5F;
        Thu,  8 Sep 2016 12:48:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Satoshi Yasushima <s.yasushima@gmail.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: git-gui, was Re: [PATCH v2 6/6] git-gui: Update Japanese information
References: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
        <1473177741-9576-1-git-send-email-s.yasushima@gmail.com>
        <1473177741-9576-6-git-send-email-s.yasushima@gmail.com>
        <048AF5D4DC044BDC9F3A75A3BABD00F1@Yasushima>
        <xmqqk2enobol.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609080857460.129229@virtualbox>
Date:   Thu, 08 Sep 2016 09:48:19 -0700
In-Reply-To: <alpine.DEB.2.20.1609080857460.129229@virtualbox> (Johannes
        Schindelin's message of "Thu, 8 Sep 2016 08:59:01 +0200 (CEST)")
Message-ID: <xmqqeg4ujq24.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D53DE4C-75E4-11E6-882C-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 7 Sep 2016, Junio C Hamano wrote:
>
>> Pat, we haven't heard from you for a long time.
>
> Indeed. There are a couple of git-gui patches in Git for Windows that have
> been contributed a long time ago and not been picked up.
>
> Maybe it is time to just accept git-gui patches directly into Git, after
> some other Tcl/Tk savvy people ACKed them?

Yes, that was my thinking, though I'd prefer to see somebodyto be
acting as a central point of contact so that I do not have to pay
any attention to the part of the system other than responding to a
pull request.  The subsystem maintainer does not have to forever be
Pat, of course, and can be handed over to somebody else, but if that
is what is going to happen, I'd prefer to see a volunteer or two to
step up and Pat to bless them.


