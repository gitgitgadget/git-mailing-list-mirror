Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6343C20373
	for <e@80x24.org>; Sat,  7 Oct 2017 01:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbdJGBYu (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 21:24:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51128 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752155AbdJGBYt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 21:24:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB944B0391;
        Fri,  6 Oct 2017 21:24:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cZC+Squ6++kkgJnpfFWeD3F77jg=; b=i82hke
        Aga0dPmSE7DCECSvUGoVHAn9QCLamyETjPntrLEcg7l+F/WHVM/9BsBFroOjhWuV
        mQK2HaImq+vUTPacVgKflLCHE0ii/z4IOekeY+reYOxb4dNxiy2RE0u/F7dF/fkL
        fR1g+UOsYFDQwyrpxW8k9ag8Ymr13GkK9ameA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K3gcecuMuJ4XaU3a423idaNedpEoPwMK
        LadxTqvfkAVmzOaIW9eXhxxqy2QxtRYNeYKytsv+n7CmZM5xZrpbKneYbMMIAsHB
        o0fddvkZzFubCmk3AbFZReyg4A0ml4JA2w3mFpEF6V15HITzVyOOZj3BL/gkCVbV
        TvG0vU1ZPpg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C296FB0390;
        Fri,  6 Oct 2017 21:24:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 372E9B038F;
        Fri,  6 Oct 2017 21:24:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de, bmwill@google.com
Subject: Re: [RFC PATCH v3 0/4] implement fetching of moved submodules
References: <20171006222544.GA26642@sandbox>
Date:   Sat, 07 Oct 2017 10:24:47 +0900
In-Reply-To: <20171006222544.GA26642@sandbox> (Heiko Voigt's message of "Sat,
        7 Oct 2017 00:25:44 +0200")
Message-ID: <xmqqa813vjfk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F081F38-AAFE-11E7-9B77-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> So the thing here is: If we want to make sure that we stay backwards
> compatible by supporting the setup with gitlinks without configuration.
> Then we also should keep tests around that have the plain manual setup
> without .gitmodules files. Just something, I think, we should keep in
> mind.
>
> Apart from the tests nothing has been added in this iteration. Since I
> finally have a working test now I will continue with reviving the
> fallback to paths.

Thanks for an update.
