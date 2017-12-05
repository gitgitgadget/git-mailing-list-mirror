Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2307420A40
	for <e@80x24.org>; Tue,  5 Dec 2017 12:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbdLEMh3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 07:37:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63500 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752453AbdLEMh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 07:37:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7ADD3BB3B7;
        Tue,  5 Dec 2017 07:37:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hIQr5ok+QAeIiJFdktFvmb7QrL8=; b=ivkYoV
        KmoyBDrHUdaGd3m0tSJqsR1Qn6oHprow2Ycai0NdS6rFTVvb7E+NVotvs9yjGpXD
        Y2ULhg2dwaXUKhi3iCqNKKftprh8OtUDJDWoaL2XuDC4euOZpyDDCM4HYOl/8tr/
        JJVPxoReZA2ZVZc2Z3r+jx40u73N6dzOgBPmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DNGVF8xAiWBacXeb8oWbFY0ytbrgUoVZ
        NoC6T84jk3aEhVQUqR6JKbC1aFKMg7jMRfMAcTqD/oFLc1dBiO+ngRA3LUScn/Ir
        BXcSX0yOXHUklWAD1W7Q75K6SOzQYSTjlGjj6cqunyUfP14TZcBxLHxW4hN9Tdje
        zReYdki/r5k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72EF3BB3B6;
        Tue,  5 Dec 2017 07:37:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE561BB3B4;
        Tue,  5 Dec 2017 07:37:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     liam Beguin <liambeguin@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 6/9] rebase -i: update functions to use a flags parameter
References: <20171127045514.25647-1-liambeguin@gmail.com>
        <20171203221721.16462-1-liambeguin@gmail.com>
        <20171203221721.16462-7-liambeguin@gmail.com>
        <alpine.DEB.2.21.1.1712041643250.98586@virtualbox>
        <22f665eb-0ed1-27d4-7184-e6063ea5b47e@gmail.com>
Date:   Tue, 05 Dec 2017 04:37:26 -0800
In-Reply-To: <22f665eb-0ed1-27d4-7184-e6063ea5b47e@gmail.com> (liam Beguin's
        message of "Mon, 4 Dec 2017 22:42:43 -0500")
Message-ID: <xmqqwp21jqpl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DA64530-D9B9-11E7-B837-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

liam Beguin <liambeguin@gmail.com> writes:

> I'll change it to TODO_LIST_SHORTED_IDs. TODO_LIST_SHORTED_INSNS would
> suggest the flag changes both parts of the todo.

I am not a native speaker, but SHORTED does not sound like a right
phrase.  When you make something shorter, that thing is "shortened",
not "shorted".

