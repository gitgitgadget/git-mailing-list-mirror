Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EA0C1FF40
	for <e@80x24.org>; Tue, 13 Dec 2016 06:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752761AbcLMGm0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 01:42:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60624 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752553AbcLMGmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 01:42:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E6FC55E91;
        Tue, 13 Dec 2016 01:42:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7GtYp/CTFaSB
        aLVe2MWxkj3PPBA=; b=bk4AMdRVBK9eCqSnIP5hNWoh/oMdtfWMmGSobtvRgxOU
        yR4pOFcm4jmFqtIfoTWaDw8GCgpUmsDtCYXnmJoGHlLWzqsbA3M3YbMi4CZiPtPq
        cHu5eZVxza7J8V2myqID6OkpqngNhKZwRnJMT+TBWQ8m8fQk3gWBAVrSARJd1dE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FUsidD
        4OTGdf2CUO9vA7zoV7lbAXJiiJ7fsfUojyr+doWw7hcq4LgYAFZ+NMjf3pJQ0aHh
        MYwiLk+v/qM7fEP7BV7q/Q+6UDb691JKt2v1vpDAF+d/WjKji3ODxkCw4VaL0/C5
        6tijxkWYO7XG/77WZk0l2tdvMEs3pES9ptP6U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25F5055E90;
        Tue, 13 Dec 2016 01:42:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC9C255E8E;
        Tue, 13 Dec 2016 01:42:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] update_unicode.sh: update the uniset repo if it exists
References: <1481499265-18361-1-git-send-email-dev+git@drbeat.li>
        <64bc846c-0304-dd7b-73bf-a6c3a4135381@web.de>
        <c96d013c38df7737cfd551a0fce87314@drbeat.li>
        <ca10a51a-0fab-e4a4-8d7d-035673af4c06@web.de>
        <xmqqr35dm203.fsf@gitster.mtv.corp.google.com>
        <954eed6b-c899-4f4c-eb3d-2b6d2ff4385d@drbeat.li>
        <d91b5e69-9b90-e21e-0dcb-8eace00ddd74@web.de>
Date:   Mon, 12 Dec 2016 22:42:22 -0800
In-Reply-To: <d91b5e69-9b90-e21e-0dcb-8eace00ddd74@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 13 Dec 2016 07:16:26
 +0100")
Message-ID: <xmqq37hs72k1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4DE1B356-C0FF-11E6-8391-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The typical instructions I have seen are a sequence of shell commands
> to be executed, which hopefully simply work by doing "copy-and-paste".
> I find this error-prone, as you you may loose the last character while
> moving the mouse, or don't check the error message or return codes.
> Having a pre-baked shell script, which does use "&&" is in that way
> more attractive,
> and the README can be as simple as run "update-unicode.sh" and that's i=
t.

That's OK as well.

> "contrib/uniwidth/" may be different to find, how about contrib/update-=
unicode ?

This, too.  And as long as .gitignore pattern is set up correctly
there, I do not think we terribly mind "git clone ..from..there.."
into it, either.
