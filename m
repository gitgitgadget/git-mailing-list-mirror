Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC1ED20A40
	for <e@80x24.org>; Wed, 22 Nov 2017 10:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbdKVKlg (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 05:41:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53734 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751863AbdKVKle (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 05:41:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57EF5BFCF3;
        Wed, 22 Nov 2017 05:41:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mrE5ussVHFCj0Nu1fDTh4vM8b2o=; b=ZD59ok
        uxZwZFKuQaksqKYY0NySO3GJWzhafKKi6Y1W62kULfth6uY+g6/j6LDj222TIgCO
        XQUZKV6xfgWqHCkf/losU1tDRl9YaAZwfm9AuI1K71M7HgSGyapJjs6symsVezss
        suxq5/u18scGka36Zfs+hrt7AmB9xUUmLR7H0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bRKEkFy3opPAArEOStvMLVWg6oGgBdCz
        1e0r2ULnolMWHPuotKldhS2DvPD0d6mOkxmk11Hm/A/GVSBDGuNzh3IJG2APhS/h
        OvWf5aswFLftyBss23wlBKmj94ybV/Im27UyhmJFh8LbWzfW2EO4bnIs5Ho9+Y/a
        5n7pj0LdAqc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DC19BFCF2;
        Wed, 22 Nov 2017 05:41:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB3CCBFCF0;
        Wed, 22 Nov 2017 05:41:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] doc: Add missing "-n" (dry-run) option to reflog man page
References: <alpine.LFD.2.21.1711211038410.8568@DESKTOP-1GPMCEJ>
        <xmqqh8tnvvom.fsf@gitster.mtv.corp.google.com>
        <alpine.LFD.2.21.1711220249020.31052@localhost.localdomain>
Date:   Wed, 22 Nov 2017 19:41:27 +0900
In-Reply-To: <alpine.LFD.2.21.1711220249020.31052@localhost.localdomain>
        (Robert P. J. Day's message of "Wed, 22 Nov 2017 02:59:10 -0500
        (EST)")
Message-ID: <xmqqy3mysii0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B24DF92C-CF71-11E7-BFE5-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>   i appreciate the need for brevity, but this just takes us back to,
> is there a standard for man pages, given how they bounce around all
> over the place?
>
>   i tossed in that missing "-n" option for "man git-reflog" since it
> was the *only* option missing from the SYNOPSIS,...

Don't we also take "-v" for "--verbose"?

I am not sure what you meant by "bounce around", but by adding "-n"
without adding "-v", doesn't this patch worsen the situation by
making the result even locally inconsistent?


