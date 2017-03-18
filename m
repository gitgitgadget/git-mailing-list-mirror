Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97F242095B
	for <e@80x24.org>; Sat, 18 Mar 2017 19:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbdCRTHr (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 15:07:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51664 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751685AbdCRTHq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 15:07:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC6ED880ED;
        Sat, 18 Mar 2017 15:07:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qeSDYhJ3FDWw
        7q/qEe77HkQaCnM=; b=fw1F/9LZTf8qI6QBDPs+KAUqKPb3tzYizYI7lapGQ6U7
        XD6MHlkG+2uQBUBiz6KvUBIBJbBYzDQVGYASj+fGn6ATAs7UodufnQPVjYqNQmpn
        p4v4V8fR9c2oJf9z9oC5JOH8mr/cStBXkiRMaMolsBg+zzhpQ9Dq1v+xPMiVK3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iQUa68
        NQ7E6kAzLC5+xes09n8FaUxcZMHRhlu+Emwkwo/RprDmj8+RkZW48t/zNWCPcWzf
        GMcu0OsDaUup328pi94PlTD1T50DIEI+tYruBIN1XqFWpdp+vc1FgN1WPxs8rbgW
        INljIGGGNa4QuzECNzkgiwx/IC73vbselX8AU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3B34880EC;
        Sat, 18 Mar 2017 15:07:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1EFA7880EB;
        Sat, 18 Mar 2017 15:07:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] doc/SubmittingPatches: show how to get a CLI commit summary
References: <20170318184203.16890-1-avarab@gmail.com>
        <xmqqvar6310x.fsf@gitster.mtv.corp.google.com>
        <20170318184203.16890-3-avarab@gmail.com>
Date:   Sat, 18 Mar 2017 12:07:42 -0700
In-Reply-To: <20170318184203.16890-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 18 Mar 2017 18:42:03 +0000")
Message-ID: <xmqq37ea2ykh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2A927278-0C0E-11E7-A80D-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  The "Copy commit summary" command of gitk can be used to obtain this
> -format.
> +format, or this invocation of "git show":
> =20
> +    git show -s --date=3Dformat:%Y-%m-%d --pretty=3D'commit %h ("%s", =
%ad)' <commit>

I've seen (I think I stole it from Peff) this one recommended often
on the list, which is shorter:

    $ git show --date=3Dshort -s --pretty=3D'format:%h ("%s", %ad)' <comm=
it>



