Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0383520705
	for <e@80x24.org>; Fri,  9 Sep 2016 18:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbcIIS3o (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 14:29:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56332 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751463AbcIIS3n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 14:29:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DEAB3910C;
        Fri,  9 Sep 2016 14:29:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DLA5xfhF9h/VSDML4akeZUflB14=; b=Mvt96x
        vkdlAsaKyM/uZkItAEz1K8eLNhIAE9eV/oL13ga5dno/NY5ESkR7OSAgTRjpA2s6
        ZV/aTFwONntB/XZzjYnpwgOytklzf1gQYPgSClE4dKVZJh3lkYH57ZPPFS2vvwz9
        MNhiIHTW6mzntUvmU1l6GjnLQYyV6J4n01yHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UXHVsVB2QCU3KqBQQlF1dUbuRYLInS3/
        kVsgwivBYV4LlHTDXJQB2ZmuTb51dt0Tgsafvr78IS5yYbI2XEXijlJvLYlcVLVI
        ZtZUmt45XWl6RHlQlRpE7kqPwKUDc7M7Rl2XgRS6XbNrmC+O3kkpbM33kfBgae3z
        YbP5AkFtZPc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 466473910B;
        Fri,  9 Sep 2016 14:29:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C302A3910A;
        Fri,  9 Sep 2016 14:29:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: respect commit.gpgsign again
References: <550e7de5e08e53b5893e1ce021bffee468adfc9d.1473424091.git.johannes.schindelin@gmx.de>
Date:   Fri, 09 Sep 2016 11:29:39 -0700
In-Reply-To: <550e7de5e08e53b5893e1ce021bffee468adfc9d.1473424091.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 9 Sep 2016 14:28:24 +0200
        (CEST)")
Message-ID: <xmqqr38tapv0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5FB604C6-76BB-11E6-8A92-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> As of v2.9.0, `git commit-tree` no longer heeds the `commit.gpgsign`
> config setting. This broke committing in Git GUI.

Thanks.  Will shift it up to apply to my copy of git-gui project and
then pull in the result.

>  git-gui/lib/commit.tcl | 3 +++
>  1 file changed, 3 insertions(+)
