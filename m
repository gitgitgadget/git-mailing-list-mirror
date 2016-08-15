Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0429D1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 20:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbcHOUix (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 16:38:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932115AbcHOUiw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 16:38:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A0CB347D9;
	Mon, 15 Aug 2016 16:38:51 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TIx3m8mkjh6ASovXBM14H/gDy+Y=; b=TC9UMM
	7GPDHzEZUc+gkUD3MCIHJXpL/YhKjddOrmRoyZ+yhVeL7zHfFOStiFsXjazMxHTj
	3yQeFb7cLUUqlezuDPvajDBEh6qyhrPevIvJnH67ch51x83PBPHsKId6v6fbgglF
	Cn3bLk0Ed9IdPcdMGArgAoseHgzo2Zxlam4g8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LGgP6Blm+gcbeTVFq6SjJ2B2YP5EAcVD
	wEznMO2CyUNYh7pwGhRnmxEOrXlNUhRRHAf1vor3O6RdL++TjQxLIGcaFpSzQ7GP
	5jTPVwP5dDzvmNef+EHi0pVSjmJ87wiymZ8zCMH6eE8idn/s+zDswZzjd3epZR+g
	e/8zITm7y9I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 31F62347D8;
	Mon, 15 Aug 2016 16:38:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD3C4347D7;
	Mon, 15 Aug 2016 16:38:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jacob Keller <jacob.keller@gmail.com>
Cc:	Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>
Subject: Re: storing cover letter of a patch series?
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
	<CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
	<CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com>
	<CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com>
	<CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com>
	<CACsJy8BdmR5USJvjJ6xbjj=bP787tdS72_oL+PDq0D+FPYmiPA@mail.gmail.com>
	<DD86BC6E2E3245BA991E4D65CE66E4A8@PhilipOakley>
	<CA+P7+xqbmZznxq024fhkejp2FeCVYkOYHTSdR69Di3nkzYJooA@mail.gmail.com>
Date:	Mon, 15 Aug 2016 13:38:48 -0700
In-Reply-To: <CA+P7+xqbmZznxq024fhkejp2FeCVYkOYHTSdR69Di3nkzYJooA@mail.gmail.com>
	(Jacob Keller's message of "Mon, 15 Aug 2016 13:09:42 -0700")
Message-ID: <xmqqwpjhg42v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46183BCA-6328-11E6-898D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Some people have suggested this simple idea, and I like it, but they
> did mention that modifying the cover letter now requires a rebase over
> a potentially large series of patches, which can get annoying.

That can be simply solved by keeping the cover at the end.  When you
are updating the real patch on the series with "rebase -i", you
would have a chance to update the cover at the same time that way.

