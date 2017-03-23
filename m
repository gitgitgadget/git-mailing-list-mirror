Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6029220958
	for <e@80x24.org>; Thu, 23 Mar 2017 18:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932117AbdCWS3B (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 14:29:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56382 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751929AbdCWS3B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 14:29:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C8668BA32;
        Thu, 23 Mar 2017 14:28:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=41Wj0tx6pH3d
        QN1iOeBS4IXScyc=; b=XPkAP1lbZalLiCK2nKa2ibv26Xrxk5rS9RWqOtpkg4vv
        zF6xWh81vKvJN6gkKt2jiojE6X6VJgzcaizU9MNdiOvlhHINMR/40NmVE9fxB+P1
        YF9T1DuSzmkp2lm9/VGM3/Vx/2bAlePiXdzlY3Z6MMEloPtTC5qOWuXd/GjJjTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=H7xakT
        xGtPzBAvKWbta18d+UpXcfLZjrj8nbGyV71hEkrDDD4s0xHrJP8rRzSctas7E0yl
        Y10dckgPuXdKUgayeDx2EgVEIPja//ZwiIdMU2NPuGQz/kZGoAz/TAPfUrydJ/DP
        aysTY2ff4GyqaLd+V+U1VbpjcROfprphHrkTg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 722398BA31;
        Thu, 23 Mar 2017 14:28:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD2068BA30;
        Thu, 23 Mar 2017 14:28:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCHv2 00/14] completion: speed up refs completion
References: <20170323152924.23944-1-szeder.dev@gmail.com>
Date:   Thu, 23 Mar 2017 11:28:52 -0700
In-Reply-To: <20170323152924.23944-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 23 Mar 2017 16:29:10 +0100")
Message-ID: <xmqqshm3dezf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 91B7485C-0FF6-11E7-931F-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> This series is the updated version of 'sg/completion-refs-speedup'.
> It speeds up refs completion for large number of refs, partly by
> giving up disambiguating ambiguous refs and partly by eliminating most
> of the shell processing between 'git for-each-ref' and 'ls-remote' and
> Bash's completion facility.  The rest is a bit of preparatory
> reorganization, cleanup and bugfixes.
>
> Changes since v1:
> ...
> [1] - http://public-inbox.org/git/20170206181545.12869-1-szeder.dev@gma=
il.com/

It seems Jacob Keller was the only person who was excited about
these changes when v1 was posted?  It would be nice to see a bit
more enthusiasm from other folks who are invested in the completion
script, but you are the de-facto go-to person on the completion
already, so ... ;-)

Will replace.  Let's advance this to 'next' soonish (say, by early
next week).

Thanks.


