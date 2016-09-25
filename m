Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A146D1F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 22:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938997AbcIYWym (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 18:54:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53211 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933173AbcIYWyl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 18:54:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7251640676;
        Sun, 25 Sep 2016 18:54:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4oze7erstamRlgdzjZ/hBXDLYQc=; b=oPHi0l
        XxLjrXTXtCJlWP5ysSECV1OxKil0h44aDFxzjUv4ZuYmCicLk7966tOY+TLVZ9Rc
        ANUkMxUPBQDOyL1VqIOEAJ+B5kX7z2p5OOtTVfkp3izZP4J4tjLiYZbfRB6Tq+Z5
        y3DzSbiU/vZSRhOi9BlKnLQc3qTVYchl8l4Go=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s2FvuTz8butv9YyzDWoOq1ZB/keHe0iV
        jANA8dKTYvizoNTsGUXTA9IOoOTsDFnAGxFP70b7HBQZslaD/RIJdpQ/JU7A7xrs
        KfHahTJeW8/vdgcdzcN6F47gnVAjpMUkyeDQc/XQsPI2z9bZB3r3aueDt4ED2kh8
        0rnw2uMLVdE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B45240674;
        Sun, 25 Sep 2016 18:54:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E5E8D40673;
        Sun, 25 Sep 2016 18:54:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 02/11] i18n: add--interactive: mark simple here documents for translation
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
        <1472646690-9699-3-git-send-email-vascomalmeida@sapo.pt>
Date:   Sun, 25 Sep 2016 15:54:38 -0700
In-Reply-To: <1472646690-9699-3-git-send-email-vascomalmeida@sapo.pt> (Vasco
        Almeida's message of "Wed, 31 Aug 2016 12:31:21 +0000")
Message-ID: <xmqqmvivy4i9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A5AAF9E-8373-11E6-9157-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> -Prompt help:
> +	print colored $help_color, __(
> +"Prompt help:
>  1          - select a numbered item
>  foo        - select item based on unique prefix
> -           - (empty) select nothing
> -EOF
> +           - (empty) select nothing"),
> +"\n";
>  }
>  
>  sub prompt_help_cmd {
> -	print colored $help_color, <<\EOF ;
> -Prompt help:
> +	print colored $help_color, __(
> +"Prompt help:
>  1          - select a single item
>  3-5        - select a range of items
>  2-3,6-9    - select multiple ranges
>  foo        - select item based on unique prefix
>  -...       - unselect specified items
>  *          - choose all items
> -           - (empty) finish selecting
> -EOF
> +           - (empty) finish selecting"),
> +"\n";
>  }
>  
>  sub status_cmd {
> @@ -1573,14 +1573,14 @@ sub quit_cmd {
>  }
>  
>  sub help_cmd {
> -	print colored $help_color, <<\EOF ;
> -status        - show paths with changes
> +	print colored $help_color, __(
> +"status        - show paths with changes
>  update        - add working tree state to the staged set of changes
>  revert        - revert staged set of changes back to the HEAD version
>  patch         - pick hunks and update selectively
>  diff	      - view diff between HEAD and index
> -add untracked - add contents of untracked files to the staged set of changes
> -EOF
> +add untracked - add contents of untracked files to the staged set of changes"),
> +"\n";
>  }

Do we need TRANSLATORS: comment to all of the above not to touch the
command words that are explained and translate only the explanation?
