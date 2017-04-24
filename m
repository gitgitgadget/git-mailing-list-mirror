Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DAFC207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 02:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164359AbdDXCzn (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 22:55:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65018 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1164262AbdDXCzl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 22:55:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AEAB80F86;
        Sun, 23 Apr 2017 22:55:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=T+Jkrte6i5gz
        QrnK7XpfNd3DpcQ=; b=AyGmjCCi9vEiGFXzrxonJuzeUD4a4Onj1mJN1IYoV21v
        IbTtV+J0j8oi8jP0aPXAa5p0kz2QXWTnnFFHIKZ/Ucy6tDH6WPNQ43ESLAAKHyY6
        2Ls1CDewk5ETis/dEDwoxNweAdi3QnIHXgMAYXuyLMhM3g9Cf/wT/2O8qBJqZPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=csrjRl
        an6d8dGCK2BT7m6EXOhrC2kUzEDnpt+LIStapDcBIzqHkVbRVdOGtJ60mJHCvoKA
        /MsMawZ+3QJu3TmQHqatfi41R+vKIczZeqCrxy4HhPXZLuQxu2enEvf6HLokMcKU
        K7FLRTo8HjmYsY9nURQghzhLfMgfhihN8QOMA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73F4080F85;
        Sun, 23 Apr 2017 22:55:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D06D380F84;
        Sun, 23 Apr 2017 22:55:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Genz <liebundartig@freenet.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: git-pull.txt use US spelling, fix minor typo
References: <1492965925-29744-1-git-send-email-liebundartig@freenet.de>
Date:   Sun, 23 Apr 2017 19:55:38 -0700
In-Reply-To: <1492965925-29744-1-git-send-email-liebundartig@freenet.de>
        (=?utf-8?Q?=22Ren=C3=A9?= Genz"'s message of "Sun, 23 Apr 2017 18:45:25
 +0200")
Message-ID: <xmqq1ssi345x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7FE1A76A-2899-11E7-973C-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Genz <liebundartig@freenet.de> writes:

> ---

Missing sign-off.  Otherwise all good changes.  Thanks.

> Instead of using two command lines I could have replaced the comma with=
 a semicolon.
>
> I do not mind, if this patch is squashed into the other minor typo fixe=
s of mine:
> 3c228f462d02e76956062b8d8572158cbcdbbc7b
>
>
>  Documentation/git-pull.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index 4470e4b..942af8e 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -67,7 +67,7 @@ with uncommitted changes is discouraged: while possib=
le, it leaves you
>  in a state that may be hard to back out of in the case of a conflict.
> =20
>  If any of the remote changes overlap with local uncommitted changes,
> -the merge will be automatically cancelled and the work tree untouched.
> +the merge will be automatically canceled and the work tree untouched.
>  It is generally best to get any local changes in working order before
>  pulling or stash them away with linkgit:git-stash[1].
> =20
> @@ -210,7 +210,8 @@ EXAMPLES
>    current branch:
>  +
>  ------------------------------------------------
> -$ git pull, git pull origin
> +$ git pull
> +$ git pull origin
>  ------------------------------------------------
>  +
>  Normally the branch merged in is the HEAD of the remote repository,
