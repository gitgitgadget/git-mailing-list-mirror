Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46BB81F404
	for <e@80x24.org>; Tue, 16 Jan 2018 18:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbeAPSTc (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 13:19:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50435 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeAPSTc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 13:19:32 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A69DCC4D4;
        Tue, 16 Jan 2018 13:19:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9aJfX52C9cgLAe14UKuHqmj5H5E=; b=scKm7m
        cArpTpHwaDkM8wEs3IOwLeDBGydYOK+dmTyGVU93jaBe/qHuIvdckpD8AqJ4C9uP
        pp7m46vmUAmMeMW5LT9NsT5I5+GrS64AVTdTz+J5SJsAGKEVgSMuE8LRL0KeMoJg
        F41+FT0BQNzNAD2gVNRHgV/nOD0pNxvsDkpUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lT7j9qe+gMmRX1J5ChXUirXzmzmnEVWJ
        IWq/ShWOC8CIkftQEVVnXaeG+keAcjj6+juddF3cSpRmhF+0Gy2zAdvsX/DFeKdi
        5ElnPS0in/IdVZEnahNsdFEA7sA+0QNcHYFf3n8gn8XFO6PUC2S2bQdZtsa1RGXQ
        UpiuS6/VdQY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42118CC4D3;
        Tue, 16 Jan 2018 13:19:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA49DCC4D2;
        Tue, 16 Jan 2018 13:19:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tanay Abhra <tanayabh@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: [ANNOUNCE] Git v2.16.0-rc2 - breakages in t1308 and 1404
References: <004b01d38bdd$7a11da60$6e358f20$@nexbridge.com>
        <xmqqd12ewx1v.fsf@gitster.mtv.corp.google.com>
        <008f01d38bfa$7eba9bc0$7c2fd340$@nexbridge.com>
        <xmqqy3l2ves2.fsf@gitster.mtv.corp.google.com>
        <CAEc54XAP0jFuD4J_XUZOuHEBZ+6PceEQbpm7HJEtRt4NS7Lf2A@mail.gmail.com>
Date:   Tue, 16 Jan 2018 10:19:29 -0800
In-Reply-To: <CAEc54XAP0jFuD4J_XUZOuHEBZ+6PceEQbpm7HJEtRt4NS7Lf2A@mail.gmail.com>
        (Tanay Abhra's message of "Fri, 12 Jan 2018 20:51:51 -0600")
Message-ID: <xmqqpo69vf7y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB8866B8-FAE9-11E7-89F6-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tanay Abhra <tanayabh@gmail.com> writes:

> I was the original author of the test, I am sorry about the typo.
> ...
> 'configset_get_value' will be changed to 'configset_get_value_multi'
> since the test expects a list of values instead of a single value.

Thanks for a quick reaction!!

