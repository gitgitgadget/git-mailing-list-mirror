Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 383D21F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 18:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbdARSxI (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 13:53:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52823 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752092AbdARSxG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 13:53:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72BCC5FF49;
        Wed, 18 Jan 2017 13:52:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=esomUejuSXWmgujMzsSNjOys5OY=; b=ay/suw
        H5FZZL4MXRRoN6IQFXmSLfV0Y5CkBz7uC/MY4KRBIZNu/jjjAEFGuOc3O+qFMeX8
        wJz6Pq8/uajPFF63tZ7fvDWLHG2vZn+v8cG0vpdPHSIJ3rrOU+3tm64Ku5//E3v3
        gTZ9v7uMCtMylHmEK+a8wUL+OeJEAzthnLQo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b88e2lqeUhkje+MkuH1FJWk9z9YK/gRy
        RKA6Cexk8P4h/qiJa7WZ7hJV7vzY2DIctcgeoh0SisoL7jXUh/rNgsqPqe/tZw3c
        dxX8d29NJ+kVLNuryax1laIOWA4ngZcxbdleQ3DNJDJaqhsK11GRBpKUvfkpvHt7
        tBdtQ5/xzM4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67A545FF48;
        Wed, 18 Jan 2017 13:52:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A40D95FF44;
        Wed, 18 Jan 2017 13:52:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v6 4/6] builtin/tag: add --format argument for tag -v
References: <20170117233723.23897-1-santiago@nyu.edu>
        <20170117233723.23897-5-santiago@nyu.edu>
        <xmqqmvepb4oj.fsf@gitster.mtv.corp.google.com>
        <xmqqh94wb4y0.fsf@gitster.mtv.corp.google.com>
        <20170118182831.pkhqu2np3bh2puei@LykOS.localdomain>
Date:   Wed, 18 Jan 2017 10:52:42 -0800
In-Reply-To: <20170118182831.pkhqu2np3bh2puei@LykOS.localdomain> (Santiago
        Torres's message of "Wed, 18 Jan 2017 13:28:32 -0500")
Message-ID: <xmqqo9z49p51.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B873B22-DDAF-11E6-B9B5-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Santiago Torres <santiago@nyu.edu> writes:

>> Squashing the following into this commit solves this issue with the
>> former approach.  The lines it touches are all from 4/6 and I view
>> all of it as general improvement, including type correctness and
>> code formatting.
>
> Thanks!
>
> Should I re-roll this really quick? Or would you rather apply this on
> your tree directly? 

Nah, local squashing should be sufficient in this case.  The squash
only touches a single patch from the original and it itself is easy
to review (and was reviewed already from what I can tell in this
thread).

