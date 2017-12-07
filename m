Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0350520954
	for <e@80x24.org>; Thu,  7 Dec 2017 20:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbdLGUfS (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 15:35:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60530 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751001AbdLGUfS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 15:35:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 84242C46DA;
        Thu,  7 Dec 2017 15:35:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uiSEFF5My7aLD2PQB6RpPsmN72s=; b=Se56jk
        NmSWVJE8vpJmPXFBI1HtH1mFji/K0oDPp3Hnt71ABfjnzW1T7MiynajrP3tFoutX
        B+6TSwJ0Vza0hXSEz83wkWKj5PPkXBcD9E20nVaUwBCmEpxH6x1LjfzmMfagl+1w
        bDGPeaTFZKVyn4xbMHtcIM75km1y9aMZc+c00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gnGUkRtOtqrctCNgB+IA93GXIsdArYXb
        /MJYxLKcc3Dxs5hSwwKigrVBCTIHsklpIs/LeyEDmA9Us7TZ6iEVwdwQa/A2whCA
        78qPQZOb4S7pMc7T2Ii8OvmBMTMe2R4vAcpGxbyqbcJzpCS2uThLgG0wX3luPpZX
        AZzvVv8DPiI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B063C46D8;
        Thu,  7 Dec 2017 15:35:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E114DC46D7;
        Thu,  7 Dec 2017 15:35:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] RelNotes/2.16: Fix submodule recursing argument
References: <20171207195145.11965-1-sbeller@google.com>
Date:   Thu, 07 Dec 2017 12:35:15 -0800
In-Reply-To: <20171207195145.11965-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 7 Dec 2017 11:51:45 -0800")
Message-ID: <xmqqpo7qcm4c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22896D0C-DB8E-11E7-A902-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Junio, feel free to just squash this into a future update
> of the release notes.
> ...
> - * "git checkout --recursive" may overwrite and rewind the history of
> + * "git checkout --recurse-submodules" may overwrite and rewind the history of

Thanks.
