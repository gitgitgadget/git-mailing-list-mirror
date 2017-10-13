Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FFFA20372
	for <e@80x24.org>; Fri, 13 Oct 2017 00:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753286AbdJMAXY (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 20:23:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51974 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751205AbdJMAXX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 20:23:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E927AAF0CA;
        Thu, 12 Oct 2017 20:23:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FWSrtgyGAPI9nOolRLY/N/N+NtM=; b=yhyhxL
        BKVtWau3ypOYXqX0OdaMRQGrLK3weugzFL6Hs62pOIGqiPQCqInfFwJ3Rh/WkCjW
        UHCZMJislRuEwlwsRRIvVzs6iev1T9HN4/NscuBhHvs7QM18yUMo97MAMN/uhxDY
        9E0+vkIDeVCkVCwxq9JICKCctLJ892p5JI25o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ir0KDe6pAa1QgU1k+NUQlPXU0Y9QWIu2
        a3cc5VpP5+LolQ836W5m7rXRK4nJHnk5dmfHLsMW0SfXhmEwROfLoeGmQoKHDVvQ
        k9I9BOudUhwZnVhQGo/RKqhkfGOtZCEyUHjiwAe9dEzu/JV3DqIWxXo3aOWahrLC
        A4LwgDFGHg4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E14C9AF0C8;
        Thu, 12 Oct 2017 20:23:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68BE0AF0C7;
        Thu, 12 Oct 2017 20:23:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     second.payre@gmail.com
Cc:     git@vger.kernel.org,
        PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>,
        MOY Matthieu <matthieu.moy@univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
Subject: Re: [PATCH v2] Documentation/git-config.txt: reword missleading sentence
References: <xmqqtvz7pewn.fsf@gitster.mtv.corp.google.com>
        <20171012091727.30759-1-second.payre@gmail.com>
Date:   Fri, 13 Oct 2017 09:23:20 +0900
In-Reply-To: <20171012091727.30759-1-second.payre@gmail.com> (second payre's
        message of "Thu, 12 Oct 2017 11:17:27 +0200")
Message-ID: <xmqqa80vyjyf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B89A481A-AFAC-11E7-946B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

second.payre@gmail.com writes:

> From: PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>

Should I assume that the name/address on the last Signed-off-by: we
see below is what you want to be known as?  As a part of school
work, I'd imagine that Matthieu wants your work to be associated
with the univ-lyon1.fr address, so perhaps you want to go the other
way around?  It's not my place to decide between the two, but it is
unusual to see that the name/address of the author (which is the
above line) does not match what is on the Signed-off-by: line.

> Change the word "bla" to "section.variable", "bla" is a placeholder
> for a variable name and it wasn't clear for everyone.
> This change clarify it.
>
> Change the appearance of 'git config section.variable {tilde}/' to
> `git config section.variable {tilde}/` to harmonize it with
> the rest of the file, this is a command line then the "`" are
> necessary.
>
> Replace "git-config" by "git config" because the command
> is not "git-config".
>
> See discussion at:
> https://public-inbox.org/git/20171002061303.Horde.SL92grZCqTRV9oQkBFPELQ7@crashcourse.ca/
>
> Signed-off-by: MOY Matthieu <matthieu.moy@univ-lyon1.fr>
> Signed-off-by: Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
> Signed-off-by: Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
> Signed-off-by: Nathan Payre <second.payre@gmail.com>
> Noticed-by: rpjday@crashcourse.ca
> ---
>  Documentation/git-config.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 83f86b923..2ab9e4c56 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -174,11 +174,11 @@ See also <<FILES>>.
>  	either --bool or --int, as described above.
>  
>  --path::
> -	'git-config' will expand leading '{tilde}' to the value of
> +	'git config' will expand leading '{tilde}' to the value of
>  	'$HOME', and '{tilde}user' to the home directory for the
>  	specified user.  This option has no effect when setting the
> -	value (but you can use 'git config bla {tilde}/' from the
> -	command line to let your shell do the expansion).
> +	value (but you can use `git config section.variable {tilde}/`

Does this reference to {tilde} get expanded inside the `literal`
mark-up?  In the description for 'gitdir', we find this passage (in
Documentation/config.txt):

     * If the pattern starts with `~/`, `~` will be substituted with the
       content of the environment variable `HOME`.

So I'd expect `~` to be a safe way to get what you want, not `{tilde}`.

> +	from the command line to let your shell do the expansion).
>  
>  -z::
>  --null::
