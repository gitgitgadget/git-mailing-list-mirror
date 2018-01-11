Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A6CD1FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 20:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933644AbeAKUUp (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 15:20:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54951 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932766AbeAKUUn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 15:20:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 263BAC4073;
        Thu, 11 Jan 2018 15:20:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0bt+DwGTCNVaM3NHpkmasycfWWg=; b=d9rSLH
        ZKz5GBFYNwAw4InJEMIO6KRjdHJ5o53X04eGLplNd4bIfnxpCCZ+v3LpAHQkEm96
        BpvTF3BuDRxxhoLVPPHfBDsyBReKJMZVmwFCttahPlrymPb4difly+5+hi+pJ1DM
        dVOns2SqjcccpZiL5a7Pv5xwhQFNKkeTC1K6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s70gXtpBi4spv0ZflssLUFJOu+ku5OLP
        44bDqVEsDOiM0Jvd5BCEo0sKUP4wi2Z7XV2tu04zFFL+xYlD9YlFGTD6aVeaH0CY
        Toj74ucgGP0Z6uigPieU6ETWPMP8DgsH8i3hNacNexkhKK5tWJazITgOFzCWqHID
        d9hv1yspqmY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16A1AC4072;
        Thu, 11 Jan 2018 15:20:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 87776C4071;
        Thu, 11 Jan 2018 15:20:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] Documentation/git-worktree.txt: add missing `
References: <20180111181821.28071-1-ralf.thielow@gmail.com>
Date:   Thu, 11 Jan 2018 12:20:39 -0800
In-Reply-To: <20180111181821.28071-1-ralf.thielow@gmail.com> (Ralf Thielow's
        message of "Thu, 11 Jan 2018 19:18:21 +0100")
Message-ID: <xmqqzi5kxi3s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4A3FCCE-F70C-11E7-BFA2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ralf Thielow <ralf.thielow@gmail.com> writes:

>  	of creating a new branch from HEAD, if there exists a tracking
> -	branch in exactly one remote matching the basename of `<path>,
> +	branch in exactly one remote matching the basename of `<path>`,
>  	base the new branch on the remote-tracking branch, and mark
>  	the remote-tracking branch as "upstream" from the new branch.

Thanks.
