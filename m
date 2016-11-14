Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4939F1F858
	for <e@80x24.org>; Mon, 14 Nov 2016 19:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936072AbcKNTTV (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 14:19:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64164 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932343AbcKNTTR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 14:19:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E385C4F14C;
        Mon, 14 Nov 2016 14:19:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DrlkcWmkva4dFe+qwWCbaz//LxU=; b=bEn7lq
        Pt8fyFmLg/Y6juacrLx4DHjrMfJwOzZguxIZyS091XivmNqwJMo53c+xjj4yZ6Pc
        rEjgDg0mUSNAvc6OmOxOXyHuX0raNjx4S2bJM88VwevRRCUH5ef0OppZ9xj6184e
        /IH+1At6+RqYqWEO9s/V2uREVH3fEJHBR1OuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OHjwPEUGQsXDbDo57x3w5R1WPY2GGPZZ
        7nV42s6rxRiUelykac8YjHv27HWGAl5rUDEl8A9jFpCdvEGQfDel+aUeI8U76OAA
        B5BqNKaCPrpQVtnhesTBj/ZnmrRUu2PvlyiFIYizQ6+yMDaQaVnOBmrUFOVhUDPb
        mYTyZyPgsew=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC1DC4F14B;
        Mon, 14 Nov 2016 14:19:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3930F4F149;
        Mon, 14 Nov 2016 14:19:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: mention transfer data leaks in more places
References: <1479148088.2406.27.camel@mattmccutchen.net>
        <1479148255.2406.30.camel@mattmccutchen.net>
Date:   Mon, 14 Nov 2016 11:19:14 -0800
In-Reply-To: <1479148255.2406.30.camel@mattmccutchen.net> (Matt McCutchen's
        message of "Mon, 14 Nov 2016 13:20:24 -0500")
Message-ID: <xmqq7f85yiml.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BE10DA8-AA9F-11E6-81B8-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt McCutchen <matt@mattmccutchen.net> writes:

> The "SECURITY" section of the gitnamespaces(7) man page described two
> ways for a client to steal data from a server that wasn't intended to be
> shared. Similar attacks can be performed by a server on a client, so
> adapt the section to cover both directions and add it to the
> git-fetch(1), git-pull(1), and git-push(1) man pages. Also add
> references to this section from the documentation of server
> configuration options that attempt to control data leakage but may not
> be fully effective.

This round looks OK.  Will queue.  Thanks.

