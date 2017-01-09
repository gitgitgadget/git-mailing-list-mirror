Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF0BA20756
	for <e@80x24.org>; Mon,  9 Jan 2017 09:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934457AbdAIJrM (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 04:47:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52427 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934126AbdAIJrM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 04:47:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E58AA56477;
        Mon,  9 Jan 2017 04:47:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+vzXYd5T4bkFX4aVUXeA1X0pCxU=; b=F2gvys
        FwIDtiORCnC61EWs3srsIrLF5hzyL21w32qf45B2lEHafQiVP7ZjFCFLxkd/RTlE
        TZ4fovdial4eGP71ynnuXUgKcn4Ky2ya4evNkpZPWuRhMjSZRO6tbw+yD+yuGTzQ
        cLgD64yCBpt2Q7GlSZcRac56b3l/VjAMwWSoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jSV3n7Zyq0zq9sLWNpwTlxPY/TEOl57s
        tu8Uf7zuX4Tq4Ot0RjDXhcJn5r7b/IDkP2kuTRC+fQtacHoS8zvh9+TYcHB6gjge
        1H71YZciB7lzs5bf0VHJDzxdve3risALHdP3AZPhSvqPNAWZYkxgnR0doTLT4+sR
        LfZX/7ulVys=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC78256476;
        Mon,  9 Jan 2017 04:47:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5731756474;
        Mon,  9 Jan 2017 04:47:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Steven Penny <svnpenn@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org
Subject: Re: [PATCH] Makefile: POSIX windres
References: <20170107214110.3124-1-svnpenn@gmail.com>
        <xmqqtw99x70u.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701090903500.3469@virtualbox>
Date:   Mon, 09 Jan 2017 01:47:09 -0800
In-Reply-To: <alpine.DEB.2.20.1701090903500.3469@virtualbox> (Johannes
        Schindelin's message of "Mon, 9 Jan 2017 09:09:54 +0100 (CET)")
Message-ID: <xmqq7f64y38i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97320D56-D650-11E6-AF08-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Who other than cygwin build uses this target?  Git for Windows?
>
> Yes, Git for Windows uses this target, as did msysGit (and I suspect
> Hannes' setup).
> ...
> So: ACK

Thanks.
