Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC4C220372
	for <e@80x24.org>; Tue, 10 Oct 2017 01:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755863AbdJJB03 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 21:26:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54642 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755560AbdJJB02 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 21:26:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F2436B38B8;
        Mon,  9 Oct 2017 21:26:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rW0ZoraM6x6a
        WdVRJvmSllyEpfc=; b=bc4DYjQ9/CNGXIZPMj/x2Q2RmkY9oCiQ/jUORPJszsJP
        fkEnawj/uM5O1DnihYv9AIxXYFQfuQElkAlf5aq/mna1A7tL354ezLMGVrN0tMxx
        hs8DgA5Wn31r+d/xlS4tDKlP4gvg+JVWjTZe9JRgyDrlfA3zOvFkYt4SkJn+/Pc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PvH8xs
        j4AkPFh8/MbD01XDkv/9vkNf87D2NWjz0vrhyuKJ0DrMwV/AG7AVRI9CIXqqDpRo
        J/dmnHxOYTTWmsBRr3bhu1Xr6s2xC9OdYNHaf07WIFM35+Rd+KNyV9sZJRnEYz5T
        B7GHjPqF8xEv+UQP2ocnO+g7EQQCQpKsQww3s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8B5DB38B7;
        Mon,  9 Oct 2017 21:26:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 496BBB38B3;
        Mon,  9 Oct 2017 21:26:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     Stefan Beller <sbeller@google.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBR?= =?utf-8?B?dcOibg==?= 
        <vnwildman@gmail.com>, Jacques Viviers <jacques.viviers@gmail.com>,
        m4sk1n <m4sk1n@o2.pl>
Subject: Re: [PATCH] submodule: avoid sentence-lego in translated string
References: <CANYiYbGHBDGMEjbrvX_ayXkXkciT3GgL4seM_X1NmWtud2upcg@mail.gmail.com>
        <CAN0heSqFSiev8BeZVu3KBA5vswsbQrrOH=tYYOSs_h_eq=8-3Q@mail.gmail.com>
        <CAGZ79ka7xo96MHaAUbkDuFjWMQaaD4j2UrRndcinAg6uzaP6Kw@mail.gmail.com>
        <7894534.MaGmRTisnX@cayenne>
Date:   Tue, 10 Oct 2017 10:26:25 +0900
In-Reply-To: <7894534.MaGmRTisnX@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Mon, 09 Oct 2017 23:11:42 +0200")
Message-ID: <xmqq7ew3rdxa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 095D3D5C-AD5A-11E7-B67C-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> On Monday, 9 October 2017, 09:47:26 CEST Stefan Beller wrote:
>
>> I always assumed that translators are aware of these issues and sort o=
f
>> work around this somehow, maybe like this:
>>=20
>>   "submodule entry '%s' (%s) is not a commit. It is of type %s"
>
> Translators can be aware of the issue if the coder commented the=20
> internationalization string with some possible candidates for the place=
holders=20
> when it is not clear unless you check in the source code. Much effort w=
as=20
> poured into translating the technical terms in other parts of Git; it s=
eems=20
> awkward to just step back in this occurence.

I do not see this particular case as "stepping back", though.

Our users do not spell "git cat-file -t commit v2.0^{commit}" with
'commit' translated to their language, right?  Shouldn't an error
message output use the same phrase the input side requests users to
use?
