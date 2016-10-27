Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58EBA20193
	for <e@80x24.org>; Thu, 27 Oct 2016 22:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943029AbcJ0Wv1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:51:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57612 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S942888AbcJ0Wv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:51:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1573E4A4C8;
        Thu, 27 Oct 2016 18:51:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w1t5JkDBRLGyynTrA9su7iVdNh4=; b=soIGqj
        rQ2OmgoeUfHAu8TMZNjuClcYPpF+/T/i4ZZWvhldlf+C+n8PTZob2vtQQ1uXIhw4
        MGkBlEe8aCNpi0E17E/kKsNaMQmwbkHUFcl6AeZMdkDxSPMpSsaFSBn8RZ1Yiv2n
        TDqODRIUzYJG1G6lFIfWw5Mnv2r5VKH8CskbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=llNZxL4CBi0380kI3AA8gptJz/6xOU1T
        a5FnyunTo3+TZlyW27yzI/Bhv+BQRxKqzhznXOWxdkmssJg/JGuLRlczpVWcPkOg
        6YKQF7zLg3HoJkWNOf5+lnMd48gOhw5WZNRwY4O6ECAfsE0G3oHbDXXClBgPxJU6
        2CrTpP3BHxk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0CED04A4C7;
        Thu, 27 Oct 2016 18:51:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 834874A4C6;
        Thu, 27 Oct 2016 18:51:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Rood <mr.john.rood@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: feature request
References: <CALj-rGeoT_mpmuw8Put=6eRhzf-r2WUohu_Kd-wnpc=BvO5joA@mail.gmail.com>
        <CAGZ79kZAfqxB699MOs6A6RL==Ku-qF7ABiW=eA+TSrqK+8e_sA@mail.gmail.com>
        <CALj-rGeMHyN6Xhc0_KCChmWL4BDyF-ZJYdipbe1_yNvznrYPVA@mail.gmail.com>
        <CALj-rGfsy+KA=dsd+wobMiVOWHK1GU=dZRcQWtMoXwtBrMYPLg@mail.gmail.com>
        <xmqq1sz15swv.fsf@gitster.mtv.corp.google.com>
        <CALj-rGdTfYYn1Nnksh=WijkJxknBUeqci3i3uujH8yzcE1z_8g@mail.gmail.com>
Date:   Thu, 27 Oct 2016 15:51:22 -0700
In-Reply-To: <CALj-rGdTfYYn1Nnksh=WijkJxknBUeqci3i3uujH8yzcE1z_8g@mail.gmail.com>
        (John Rood's message of "Thu, 27 Oct 2016 17:48:47 -0500")
Message-ID: <xmqqshrh4d91.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E31A7A3E-9C97-11E6-9442-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Rood <mr.john.rood@gmail.com> writes:

[administrivia: do not top post]

> What I'm really seeking is not a make-shift solution for myself, but
> an intuitive solution for the novice user-base at large.

Well, there are -m and --no-edit.  Recording commits with useless
single liner is a bad habit to get into, and change to encourage
novice user-base at large to do so is not a good idea.
