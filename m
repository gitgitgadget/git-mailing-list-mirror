Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82B651FF72
	for <e@80x24.org>; Thu, 19 Oct 2017 04:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750902AbdJSE6t (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 00:58:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54147 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750777AbdJSE6s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 00:58:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9975594568;
        Thu, 19 Oct 2017 00:58:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3syF88rg4VoEZPiXgzN459dGmG4=; b=UhrVUH
        p+P/QQwLHcgIMZm36kXBBzXudL57x0HDaTX4QPh7ggNT3W38NL1oXwPH1YnEmREm
        XraHx2abIWMRos6jIrXSP/6/a3xM5YnAv4pwDSnLVla9DcrZgSFSvIFBAxFNb7vJ
        UtscHMwxiE/DfJgXd/Ytu/qN/8Ud3G9cnUyC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LsYC7ZEnlBb7KHM8IO2WJl8bfLAAYYdB
        UfiTaRct1t05iqKxGqPcAaVinpqampSf+dzH8DsjlwwtyAeLrrw10pt551BzTNKc
        AOlXYWUc3q3hih0qajuaR4NfFGV9zq11DlyHrCeskddeLTpad1n0JcPfplGcaLeU
        LFTzuHt/o20=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9164794567;
        Thu, 19 Oct 2017 00:58:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 05F0E94566;
        Thu, 19 Oct 2017 00:58:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     PAYRE NATHAN p1508475 <second.payre@gmail.com>,
        git@vger.kernel.org,
        PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>,
        MOY Matthieu <matthieu.moy@univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3] Documentation/git-config.txt: reword missleading sentence
References: <xmqqvajjuudo.fsf@gitster.mtv.corp.google.com>
        <20171018202716.13313-1-nathan.payre@etu.univ-lyon1.fr>
        <20171018220530.h6dgneq2dvhmwfeu@aiede.mtv.corp.google.com>
Date:   Thu, 19 Oct 2017 13:58:43 +0900
In-Reply-To: <20171018220530.h6dgneq2dvhmwfeu@aiede.mtv.corp.google.com>
        (Jonathan Nieder's message of "Wed, 18 Oct 2017 15:12:48 -0700")
Message-ID: <xmqqa80nka2k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F5A7AA6-B48A-11E7-AAE0-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Or, to capture the other changes being made at the same time:
>
> 	config doc: clarify "git config --path" example
>
> Thanks for working on this.

Yup.  I'll queue with the above subject; all the suggestions in your
message were sensible, so I'll take them when I do so.

> By the way, should the initial `git config` be 'git config' (in
> italics instead of monospace)?  I don't see `git config` anywhere else
> in the file and there are a lot of instances of 'git config'.

We want to use monospace for something we expect users to type
verbatim while following the description along, and highlight
important terms that are being explained by typesetting in italics.
This one can go either way, so I'll keep it as posted.

Thanks.


