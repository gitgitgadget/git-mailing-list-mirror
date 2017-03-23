Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7B020958
	for <e@80x24.org>; Thu, 23 Mar 2017 17:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935014AbdCWRCW (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 13:02:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65238 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755788AbdCWRBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 13:01:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B72887F89;
        Thu, 23 Mar 2017 13:01:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lZgEormICVJ9
        3XpHqJq0r6h+70Q=; b=LoZ/ggMpqmtvXL7QFw8X72wkpc/N4+VuLr5rOl7yJZL9
        GITz82bx9lLKdAwqDDBTuPaTezw3iDDQ9Oslx212+vIAdQnv3Tv2U5WALE8oTYN3
        qDbZ4A8j8SXujo6wzjd15Rz8g5p+NaZPK95R9JYGjDx+Sh+k4j3xbFOn8kNjm/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xxni+5
        yyZxWsGo73ecjHyQbQiIuTy1CaXLvl+fyQPz3Bl18sY6sy45Wq/5/vh8f3WPOCY1
        cNNtA/SqdAWH9PKhRMyPFP4fXQyuF9Qk50VwsLj4z61I8Xu0yFfRRwpSxMAdqbhv
        Uh9ewrqiFugFrjKiqK/lXkkRhXawSh2g+tm2I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82F0787F88;
        Thu, 23 Mar 2017 13:01:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E36B487F87;
        Thu, 23 Mar 2017 13:01:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch doc: Change `git branch <pattern>` to use `<branchname>`
References: <20170323120326.19051-1-avarab@gmail.com>
Date:   Thu, 23 Mar 2017 10:01:00 -0700
In-Reply-To: <20170323120326.19051-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 23 Mar 2017 12:03:26 +0000")
Message-ID: <xmqq1stoexmb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4B5FF55E-0FEA-11E7-A37F-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change an example for `git branch <pattern>` to say `git branch
> <branchname>` to be consistent with the synopsis. This changes
> documentation added in d8d33736b5 ("branch: allow pattern arguments",
> 2011-08-28).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/git-branch.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
> index 092f1bcf9f..e65e5c0dee 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -142,7 +142,7 @@ This option is only applicable in non-verbose mode.
>  	List both remote-tracking branches and local branches.
> =20
>  --list::
> -	Activate the list mode. `git branch <pattern>` would try to create a =
branch,
> +	Activate the list mode. `git branch <branchname>` would try to create=
 a branch,
>  	use `git branch --list <pattern>` to list matching branches.

This makes the description more correct.

I am not sure if it makes that much sense to have that sentence here
in the first place (after all, it is describing a behaviour of a
mode that is *not* the list mode), but I guess that it may be a
common mistake to forget to specify "-l" while asking for branches
that match the pattern?  If we were writing this today from scratch,
I would perhaps write something entirely different, e.g.

	--list::
		List branches.  With optional <pattern>... at the
		end of the command line, list only the branches that
		match any of the given patterns.  Do not forget '-l'
		and say "git branch <pattern>", as it will instead
		try to create a new branch whose name is <pattern>,
		which is a common mistake.

though.

Thanks.
