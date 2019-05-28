Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC111F462
	for <e@80x24.org>; Tue, 28 May 2019 13:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfE1N6h (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 09:58:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59030 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfE1N6h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 09:58:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D3B71478A6;
        Tue, 28 May 2019 09:58:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GoPh/P4o9V8Z
        p0N+Ib3IqRBpaJk=; b=YsQhGwlXLSJB3ssAtCHFmHhpoKv/njNELRd8lSoxrqlO
        SuDWOo1bzmMQk11PoXXygx9yu10VIgjJQzHPGOg/nOdRFMysxi2AfQet1Qf5l6JL
        wwmmJBxFfb6STAa5BIvmfffVdH7MSUYm2KUhMmb4FsKuwsoxIUfpQ5tSNG95rPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=U/6uGj
        17TW1Q3taHPETL6lvvv27egDBLye7QkhP0VaFJTK2wZ0plT7lSZRycGe7ZdoUK4h
        fu6qLl96mu5lc7OoeGRKHGuLbqwks/il1yBS9j7SFvODfDN2qxzHqb3TzdKoYUJe
        NJCBmFyrSQv3KTiIHvQbbP95W/RHbJEcYJJqg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 753BA1478A5;
        Tue, 28 May 2019 09:58:35 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D96241478A2;
        Tue, 28 May 2019 09:58:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     GitList <git@vger.kernel.org>
Subject: Re: [PATCH] doc branch: provide examples for listing remote tracking branches
References: <CACsJy8CwY8gzeWa9kNRX3ecez1JGiQiaOknbAoU7S+hiXBoUGQ@mail.gmail.com>
        <20190528121315.2604-1-philipoakley@iee.org>
Date:   Tue, 28 May 2019 06:58:33 -0700
In-Reply-To: <20190528121315.2604-1-philipoakley@iee.org> (Philip Oakley's
        message of "Tue, 28 May 2019 13:13:15 +0100")
Message-ID: <xmqq5zpuel4m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AF3F5CE8-8150-11E9-AA84-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> The availability of these pattern selections is not obvious from
> the man pages, as per mail thread <87lfz3vcbt.fsf@evledraar.gmail.com>.
>
> Provide examples.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---

Please try again, perhaps after reading
<CACsJy8B_3ZytR+5HvOax=3Dngw7ECse8_5ajkOvUEcOj3MuNxQvQ@mail.gmail.com>

Thanks.

>
> in response to=20
> <CACsJy8CwY8gzeWa9kNRX3ecez1JGiQiaOknbAoU7S+hiXBoUGQ@mail.gmail.com>
> https://public-inbox.org/git/?q=3D%3CCACsJy8CwY8gzeWa9kNRX3ecez1JGiQiaO=
knbAoU7S%2BhiXBoUGQ%40mail.gmail.com%3E
>
> to: "Git Mailing List <git@vger.kernel.org>"
> cc: "Duy Nguyen <pclouds@gmail.com>"
> cc: "=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>"
>
>  Documentation/git-branch.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
> index 3bd83a7cbd..7ed91f1be3 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -314,6 +314,18 @@ $ git branch -D test                              =
      <2>
>  <2> Delete the "test" branch even if the "master" branch (or whichever=
 branch
>      is currently checked out) does not have all commits from the test =
branch.
> =20
> +Listing branches from a specific remote::
> ++
> +------------
> +$ git branch -a -l '<remote>/<pattern>'                 <1>
> +$ git for-each-ref 'refs/remotes/<remote>/<pattern>'    <2>
> +------------
> ++
> +<1> This can conflate <remote> with any local branches you happen to
> +    have been prefixed with the same <remote> pattern.
> +<2> `for-each-ref` can take a wide range of options. See linkgit:git-f=
or-each-ref[1]
> +
> +Patterns will normally need quoting.
> =20
>  NOTES
>  -----
