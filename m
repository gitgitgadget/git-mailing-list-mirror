Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F661F404
	for <e@80x24.org>; Thu, 14 Dec 2017 18:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbdLNSpW (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 13:45:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56941 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753703AbdLNSpW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 13:45:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7092CC7A99;
        Thu, 14 Dec 2017 13:45:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hVnx3ZZduz5MKH6N6ltbWf1KOlY=; b=jfWwrK
        +KQesyGklvSydVzEV9l3kRsa618pu9iivLaLJCe7ruxzBqTa9/qVqf8IOarSEiBf
        9u0ydN3luMEDhyu9AKJjJgYeJGOSXncgtZmC84jVrQRrG/AHXn5N0JARFsyHOT4T
        hcY6Bwsh1z1+WcuibWVrLHXnmxZTLn7OQ2IIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nqazhzaT5Mzd9zCV127/nSSEDUWiNroF
        JtvyluX1Ue0M25+C86O/brUcoA2ZUGxq+5XfiRqydkRmz71l/NcHTuh2ma0nKRiR
        YVV3RmNcl7FzktjYbVy1T++Gjuh1CKvG+EsZI6Ls01ya1eVdjTWpQBl5iYrt3jyu
        Rqq6zMFKSlw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65BB6C7A98;
        Thu, 14 Dec 2017 13:45:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4E76C7A97;
        Thu, 14 Dec 2017 13:45:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] t/lib-git-svn.sh: improve svnserve tests with parallel make test
References: <20171214181949.GC3693@zaya.teonanacatl.net>
Date:   Thu, 14 Dec 2017 10:45:19 -0800
In-Reply-To: <20171214181949.GC3693@zaya.teonanacatl.net> (Todd Zullinger's
        message of "Thu, 14 Dec 2017 13:19:49 -0500")
Message-ID: <xmqqshcdtagw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFE10E52-E0FE-11E7-95FF-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> I wanted to check if this minor patch series had slipped
> under your radar.

Totally.  Queued.

As they come with Ack by the area maintainer, I'll fast-track them
down to 'master' (other topics typically cook at least for a week in
'next').

Thanks for pinging.
