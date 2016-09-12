Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1C93207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 22:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756044AbcILWYH (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 18:24:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56546 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755550AbcILWYG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 18:24:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 826C23E797;
        Mon, 12 Sep 2016 18:24:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y1gMwzgW/sGrE6iuzXXQu5pL8zE=; b=ZEZhe2
        ESHiYTSGs9evA8mrEufSsGfd4PF36zMHjEvZRYo4GNtpun34hY9uoLYlrN8hgkTY
        pD8Cn2BcTS3/8HDu0Eu2iFWlL71VVfL4LAvbuqXEe8elbJQcnxd3GdSLngRV1vl2
        zm6UOdCPjjPF+u9uofaxj+2LxE7w0BPLzBpis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t0/KJNkVWBlmuw1OwC/Lcoas4A04dHRH
        xnpVHEzvV93dhS4nsnNJdPnpy1+mzzhSPSDmI7JB1TE4oM06TY0jpjhYLxDsbHqg
        b5H/amjYjulNs5sEjLZnusQaeYRzdJdJX/6dSI9aAMu5Hdil4k8n2Bdp4wRiLRLW
        go4pmQIE2Qc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A0933E796;
        Mon, 12 Sep 2016 18:24:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EAF3B3E793;
        Mon, 12 Sep 2016 18:24:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Ray <tvvocold@163.com>, Ray Chen <oldsharp@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Git List <git@vger.kernel.org>
Subject: Re: [GIT PULL] l10n updates for 2.10.0 maint branch
References: <CANYiYbFa42-q7=dbJHir5hfipK_L=x37NKQFX8WdBeeFU4V1Gg@mail.gmail.com>
Date:   Mon, 12 Sep 2016 15:24:03 -0700
In-Reply-To: <CANYiYbFa42-q7=dbJHir5hfipK_L=x37NKQFX8WdBeeFU4V1Gg@mail.gmail.com>
        (Jiang Xin's message of "Sun, 11 Sep 2016 22:25:16 +0800")
Message-ID: <xmqqtwdkycxo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D497C18-7937-11E6-B308-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> There are some l10n updates for Git 2.10.0, please merge them to the
> maint branch.

Thanks.
