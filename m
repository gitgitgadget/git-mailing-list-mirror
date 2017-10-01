Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D09320A10
	for <e@80x24.org>; Sun,  1 Oct 2017 20:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbdJAUbD (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 16:31:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55947 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751672AbdJAUbC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 16:31:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73B7FB3993;
        Sun,  1 Oct 2017 16:31:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8Gcz9EYcwUcSeFk9k0SrL7YdGJY=; b=BLhd0R
        P+yEbylJX1ssLAaaquMOLw6vVT7KgC1c2WKl+zHRHCwmz8yFi5xUCnRwStx+o1Nu
        R6lFzHTGmMNVlzPQEsB8woVZbrY3dlj+l1IgpZRi6HMVaLS6WI76UcnlbdzTT9OA
        2hyDkzbfZCA2mhb53MRtji5XE9pulkvVTbm8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wFkr6iiNxDJ8u+yazT5TAkD/jLYRuLkS
        EAz9IYpY5nVSBDSconqjoKOsBOBTTrAu7jf+ypm+odMFvN9gGJasXN1N65Fx+mnd
        RVjDFw/gSAjlRbhna+RRr43XSfoZ3pzgezBhOE6+UbOt05Q1aw7bhRbYGlnfnIwS
        b7PdUtgK4/c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E897B3992;
        Sun,  1 Oct 2017 16:31:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7DE37B3991;
        Sun,  1 Oct 2017 16:31:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] Add a comment to .clang-format about the meaning of the file
References: <20170929224505.GN19555@aiede.mtv.corp.google.com>
        <20171001154425.5568-1-s-beyer@gmx.net>
Date:   Mon, 02 Oct 2017 05:30:59 +0900
In-Reply-To: <20171001154425.5568-1-s-beyer@gmx.net> (Stephan Beyer's message
        of "Sun, 1 Oct 2017 17:44:25 +0200")
Message-ID: <xmqq3772vce4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70086A1E-A6E7-11E7-A197-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephan Beyer <s-beyer@gmx.net> writes:

> Having a .clang-format file in a project can be understood in a way that code
> has to be in the style defined by the .clang-format file, i.e., you just have
> to run clang-format over all code and you are set. This is not the case in the
> Git project, which is now reflected by a comment in the beginning of the file.
>
> Additionally, the working clang-format version is mentioned because the config
> directives change from time to time (in a compatibility-breaking way).
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>
> Notes:
>     On 10/01/2017 04:45 AM, Junio C Hamano wrote:
>     > it makes as if a random patch to "make it
>     > conform" without thinking if the rules make sense were a welcome
>     > addition, which is absolutely the last signal we would want to send
>     > to the readers.
>     
>     Right. I dropped that last sentence and replaced it by a sentence about human
>     aesthetics judgement overruling mechanical rules -- I think that's somehow quoted
>     from a comment of yours on the list.

Sorry, but that is not what I meant.

I think we do want the endgame to be that .clang-format defines how
the code should look like.  It's that we are not there yet, and I
think that is what we should say in this comment.

	Note that this style definition does not yet quite reflect
	how we want our code to look like, and adjusting the rules
	to match our style is still work in progress.  Do not
	blindly adjust the style of _existing_ code, without
	checking if the code is styled incorrectly, or the style
	definition in this file is still wrong.

is what I should have suggested when writing my response.

