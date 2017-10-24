Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BA56202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 02:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbdJXCsY (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 22:48:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55708 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751271AbdJXCsX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 22:48:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 689CE96BAA;
        Mon, 23 Oct 2017 22:48:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HsCsETpYZ4U/qrJ8GK/y+4/pNLI=; b=wgqxEn
        VBeRTYzdwIy4r9nxtsdzCTj+1NI5ThamoO0RE+oY5VMNLgheXG65lM+qo9J352Mh
        +Ryy52MWthk8IrsqDtk1P1+rav5bo2B0wFOrEETd3eEB3DVH7caYVqKuTDbDjxYn
        M2/K2z+MScKWfvfsQgW/FI5jvonDlQEEEQFUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dHFkrt7ddUpkFrYapJM6J/3yjxTZ7vfq
        yKaFeUZKrz8QOwfrqFg5s841C7D0jluWjMAxrtLTw8AV8IliBEvdY0Pip2RdKVED
        BXaA5ZhQfyxJx/dUM2WEE1ULQiuu49MBaa9rl2igi/vPlYLzPuhowsUjyAgXpTeL
        7kbb2WI24sA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DC6996BA9;
        Mon, 23 Oct 2017 22:48:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9108496BA8;
        Mon, 23 Oct 2017 22:48:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Andre Hinrichs <andre.hinrichs@gmx.de>,
        Changwoo Ryu <cwryu@debian.org>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Christopher =?utf-8?Q?D=C3=ADaz?= Riveros <chrisadr@gentoo.org>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
        Jean-Noel Avila <jean-noel.avila@scantech.fr>,
        Jean-Noel Avila <jn.avila@free.fr>,
        Jordi Mas <jmas@softcatala.org>,
        Marco Paolone <marcopaolone@gmail.com>,
        Nicolas Cornu <nicolac76@yahoo.fr>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Ray Chen <oldsharp@gmail.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Git List <git@vger.kernel.org>
Subject: Re: [GIT PULL] l10n updates for 2.15.0 round 2
References: <CANYiYbFZLUzh0VK+Yp6y8jyc5TZ1seua1D9MpcPe2s5QxDN5Wg@mail.gmail.com>
Date:   Tue, 24 Oct 2017 11:48:20 +0900
In-Reply-To: <CANYiYbFZLUzh0VK+Yp6y8jyc5TZ1seua1D9MpcPe2s5QxDN5Wg@mail.gmail.com>
        (Jiang Xin's message of "Tue, 24 Oct 2017 10:36:52 +0800")
Message-ID: <xmqqshe98dmz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC4A7DDC-B865-11E7-8B47-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> Please pull l10n updates for Git 2.15.0.
>
> The following changes since commit 111ef79afe185f8731920569450f6a65320f5d5f:
>
>   Git 2.15-rc1 (2017-10-11 14:54:04 +0900)
>
> are available in the Git repository at:
>
>   git://github.com/git-l10n/git-po tags/l10n-2.15.0-rnd2
>
> for you to fetch changes up to 1165e3c317b51a3f47afe1a5762b92cac695fe5c:
>
>   Merge branch 'jx/zh_CN-proposed' of github.com:jiangxin/git
> (2017-10-24 10:11:48 +0800)

Thanks, will pull.  Nice to see a new language added to the
repertoire.

