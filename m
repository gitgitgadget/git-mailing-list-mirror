Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ECE81F461
	for <e@80x24.org>; Mon, 26 Aug 2019 15:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbfHZPVu (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 11:21:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55880 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfHZPVt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 11:21:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B71F16076E;
        Mon, 26 Aug 2019 11:21:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wUwneT3e0XoppolV7wTjZWMZ35I=; b=sNxa/I
        Jc8wSKUFSSnkrUtCPN+L+J9blqrTRAFhakS/jyh0YN/648SoH1gznJJyyCGu5Kbf
        BYmD3IqeyYKVYhKD5G4DNoTikqnGQwM0klcVwoBJJcqRJffKLlZ/1XtM5JjELZOB
        jy0ZJeMl5+QKjjkAQr36V0WWp4IirMYTI0dXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w8y9lQ31uS3SkSdFwJk1+f7J7f2b65aJ
        eqvBVnhcFT6z5+PNERFzeBSf8gfCGP55gBkzbRj+rXynL2+muNp+yg9Q/vMvaQbe
        N59hT4iAgs2O+eAo5aIetv1rumVn+zXFPpEOokEOHMhMI95TF3Fma2ifPsTilJuL
        HE8cjPYjTkM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8251D16076D;
        Mon, 26 Aug 2019 11:21:47 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7C9916076C;
        Mon, 26 Aug 2019 11:21:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 00/13] format-patch: clean up tests and documentation
References: <cover.1566285151.git.liu.denton@gmail.com>
        <cover.1566635008.git.liu.denton@gmail.com>
        <20190824082815.GA13369@archbookpro.localdomain>
Date:   Mon, 26 Aug 2019 08:21:45 -0700
In-Reply-To: <20190824082815.GA13369@archbookpro.localdomain> (Denton Liu's
        message of "Sat, 24 Aug 2019 04:28:15 -0400")
Message-ID: <xmqqwof0j6k6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37E350A8-C815-11E9-9233-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> On Sat, Aug 24, 2019 at 04:25:17AM -0400, Denton Liu wrote:
>> *** BLURB HERE ***
>
> Whoops, perhaps we also need a configuration option for turning this off
> as well ;)

Yes.

I think it is OK to just remove it when we are taking anything from
the branch.*.description (and any other stuff that leaves human
readable text in the future) to add to the body.

