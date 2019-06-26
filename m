Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 397011F461
	for <e@80x24.org>; Wed, 26 Jun 2019 19:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfFZT6J (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 15:58:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58872 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZT6J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 15:58:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 995B662E62;
        Wed, 26 Jun 2019 15:58:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=e2P6gYse91q0
        AA1HlF0aNMFwCTM=; b=q2qgs32whuXVUmUCnibj1VRwrdbZSECu1d7PdGBMuYTI
        CeW2lGemyWhXuH+Od4yMfNYFYOcpY5Eq18tF5UzKl2vR4jbPYPoOCS2yUzWqzfAP
        ZGpa1WWj+l99T6UoKUygKhNvjDsJLVbC2KAB2dQIeqX9kUPsGP2AS6M5qTvRCW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=To7YXE
        6cyKZO67jbxdFbKlPXGc3uajhA37zHpSSsHJV3QmCOGkzA5U4iTDFmkLXW7IZK0p
        wqjgrJ1chuk9VRqGkzNM3Ne4hAJl274zyKq7Lmwep0YhFuRZbRt0zZ9/vxFSlQNa
        BASKvBTke4eHM6BuCkwSW5qSC/hGdEjb820mM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92F9862E61;
        Wed, 26 Jun 2019 15:58:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BBFC062E60;
        Wed, 26 Jun 2019 15:58:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] Some more on top of nd/switch-and-restore
References: <20190620095523.10003-1-pclouds@gmail.com>
Date:   Wed, 26 Jun 2019 12:58:03 -0700
In-Reply-To: <20190620095523.10003-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 20 Jun 2019 16:55:19 +0700")
Message-ID: <xmqq8stoce5w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B67981CE-984C-11E9-88A8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is small refinements (except 4/4).

What's the status of these?  As another low-prio topic interferes
with the code touched by nd/switch-and-restore and hence needs to
wait for these to stabilize, I'd rather see us focus on finishing
these before switching our attention to other things.

Thanks.
