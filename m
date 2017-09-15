Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72C8B20A21
	for <e@80x24.org>; Fri, 15 Sep 2017 02:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbdIOCVH (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 22:21:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53577 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751858AbdIOCUi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 22:20:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08A8AA02A7;
        Thu, 14 Sep 2017 22:20:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6UCnvizt4937YMYFyFSx1P6vjPA=; b=Q4+OAG
        eqD/2TaKlHZwncnKL0KigZW/ot6yvoQ8ss2dQlhYwkfI4DdPLNdt8PkJPBQ4E2RL
        sOk/nOSX3U0Gi9yvOjrvXaZCWr4EtjvXAfBfucpBS9ECKKWm0EYKfkKqQy2qp5s1
        bHhouROHxTvl5CylfTKSozD+ntLpOTNaJ2uv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jVz502sNyd6UGLfLFchZiHrOGK6fhPci
        8INXt1AtKIXeFKd6ttpv5OvPLYMshcggZHcKEij/AV8S86eoe+j7fordCfv4yGY3
        vATDmhPM2x2f+CiE4yDnb123KyAGt8QcYiz0iE4TFgWByJUWiQn4snNwkySQ5BSw
        oDQ7CdMwRK8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3223A02A6;
        Thu, 14 Sep 2017 22:20:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59ABBA02A5;
        Thu, 14 Sep 2017 22:20:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/4] Fixes from the per-repository object store series
References: <20170912172330.GA144745@aiede.mtv.corp.google.com>
Date:   Fri, 15 Sep 2017 11:20:36 +0900
In-Reply-To: <20170912172330.GA144745@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 12 Sep 2017 10:23:30 -0700")
Message-ID: <xmqqa81wzoqz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 762FD734-99BC-11E7-BD34-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> This is a continuation of the series at [1].  That was part 1 ---
> you can think of this as part 0, since it contains the simplest and
> least controversial part of the series --- each patch in this series
> is a bugfix in its own right.
>
> Patch 1 should be familiar if you reviewed the series [1].  It is
> unchanged from the patch there, except to note Peff's ack.
>
> Patches 2-4 have not yet visited the list but are fixes (or, in the
> case of patch 4, cleanups) noticed as part of the same process of
> teaching object store code to handle multiple repositories.
>
> We hope that splitting these out should make them easier to review
> and for people to benefit from these fixes without having to wait
> for the rest of the series to settle.

One thing that is unclear is if you are tentatively withdrawing the
longer series with this update, but I'd assume that it is the case
because these two obviously will conflict with each other, and the
most of what these four patches do are subset of what the larger one
you sent earlier do.

Thanks.
