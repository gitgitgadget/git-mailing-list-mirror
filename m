Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9701D2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 04:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbdKVETE (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 23:19:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62369 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751429AbdKVETD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 23:19:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54B56BBCD2;
        Tue, 21 Nov 2017 23:18:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yDvCPOdylqp8
        pyjsTAawrJw/Qho=; b=Bvtp2PjqgkjgnINPI6lJOoEM+CSL8nYLEnCi46l268U/
        SMPFAwjaTmj9eOG4rrrN7mfwFArdE4jHsaEZXy6nrFCJH10S2j36+deymiA7cFep
        vKvxghrbhdnWyGYZJyfSmoyFZ6k+YtC1mu+MWsGIkgWmBLJnxpGoJPItafjTa5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=k91wYO
        1qTFLSM5tOTP7uiaIUSauo063PR4364gmMYi6gNKKQQANZYGSPA+4BzSQp6wb3KZ
        vUfaStErCAXpD4lWCZAATpsEkGYkk/kMOTK6qUfKNYvMSncIcNbNIKTP576lpZXh
        NCPnRFSG5xfp4Ajp25HxnDj6+10uqrJW0L3rM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4BD5ABBCD1;
        Tue, 21 Nov 2017 23:18:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1301BBCCE;
        Tue, 21 Nov 2017 23:18:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     git@vger.kernel.org, me@ikke.info, hjemli@gmail.com,
        mhagger@alum.mit.edu, pclouds@gmail.com,
        ilari.liusvaara@elisanet.fi
Subject: Re: [PATCH v2] log: add option to choose which refs to decorate
References: <20171104004144.5975-1-rafa.almas@gmail.com>
        <20171121213341.13939-1-rafa.almas@gmail.com>
Date:   Wed, 22 Nov 2017 13:18:56 +0900
In-Reply-To: <20171121213341.13939-1-rafa.almas@gmail.com> ("Rafael
        =?utf-8?Q?Ascens=C3=A3o=22's?= message of "Tue, 21 Nov 2017 21:33:41
 +0000")
Message-ID: <xmqqpo8buerz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4275AD14-CF3C-11E7-B567-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Ascens=C3=A3o <rafa.almas@gmail.com> writes:

> When `log --decorate` is used, git will decorate commits with all
> available refs. While in most cases this the desired effect, under some

Missing verb.  s/this the/this may give the/; perhaps.

> conditions it can lead to excessively verbose output.

Other than that, I didn't find anything questionable in the
implementation, tests or doc updates.  Nicely done.

Will queue.

Thanks.
