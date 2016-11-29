Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC87C1FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 18:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754941AbcK2S7P (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 13:59:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64812 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754322AbcK2S7O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 13:59:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5EA553E35;
        Tue, 29 Nov 2016 13:59:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dczYQdZhgM79wkFvuNMjOPDZsog=; b=rEvVnV
        wBA5lmwGsuhXijG48c0tS9OZtaq4Q8XIFkvbtvtEPNZFeNZgIkmTz0LQxdKcgjoZ
        UQPo6IrksL1joejxlDyBQvu1CKRMfuN0UGp2smXqaco4TLELrHhGmWFkOfgwd4pD
        NFfvK0QgVuQTqS1kAOlCPLXSyr+9nu/HsdHWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=elS90fIbkaYAL0IYoDeVnYowYaoi+1N8
        SrdFhdl6FwhidEL5ML3jrsMhFAZG5/WuSOsMRim5g6LqAbSXWnvS+jS824g60xRT
        xO8XPgCiUXic4PhOrWSoz3V4sC/jx5w3ztS/SQ+PIVz90+CDi33C6/REyWzabEte
        92wFprV1bKY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8128A53E30;
        Tue, 29 Nov 2016 13:59:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C749D53E2D;
        Tue, 29 Nov 2016 13:59:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] allow git-p4 to create shelved changelists
References: <1480325598-12344-1-git-send-email-viniciusalexandre@gmail.com>
        <xmqqeg1vjug2.fsf@gitster.mtv.corp.google.com>
        <CAE5ih78+br88ST3Hkiw744V62AZ9iYWZ4nD5EYjewfmQRWvsiw@mail.gmail.com>
Date:   Tue, 29 Nov 2016 10:59:10 -0800
In-Reply-To: <CAE5ih78+br88ST3Hkiw744V62AZ9iYWZ4nD5EYjewfmQRWvsiw@mail.gmail.com>
        (Luke Diamand's message of "Tue, 29 Nov 2016 12:47:04 +0000")
Message-ID: <xmqqy402f6yp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA2FFB5E-B665-11E6-8E60-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> On 28 November 2016 at 19:06, Junio C Hamano <gitster@pobox.com> wrote:
>> Vinicius Kursancew <viniciusalexandre@gmail.com> writes:
>>
>>> This patch adds a "--shelve" option to the submit subcommand, it will
>>> save the changes to a perforce shelve instead of commiting them.
>
> Looks good to me, thanks!
>
> Works a treat.

Thanks.
