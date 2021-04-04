Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9241FC433B4
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 06:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A7406128D
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 06:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhDDGVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 02:21:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62330 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhDDGVj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 02:21:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D75D110E51C;
        Sun,  4 Apr 2021 02:21:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QeioPAf0lfRI
        2EPqLZYncJ8aN+s=; b=O8jpjxBvql/0fMVfBmDAF7lnLw7oJQZhru6i1hTN9wh6
        U5yO4w/7I6UuupDLE52kvS3JUGnrzcsoLc8oRmfCRhIfhj49qV8GWlpyRLWKjZPe
        U26XtUbkvb3YcNzPyLsFFRnBj3qXwrTBC2ZUogBupCBHl8vQKyLyn0I40+YWnnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Qx+37g
        +qyRjmefDhgbWWq70DtEXfy/GgOmJEo9mHUjydCfOoBCm/3OkJ6wo6yvLeK+D6uv
        OiUe6gtB/mCaQsUSw3Lk/Gmy+B7H/Egj1CCSiQxa0tKi3X4Kpvin8mHc4cJJnjMb
        INWukHMp1JuM8E4eNXBnYokSsups3gHktI2yE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D091410E51A;
        Sun,  4 Apr 2021 02:21:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 100F010E519;
        Sun,  4 Apr 2021 02:21:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Firmin Martin <firminmartin24@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: Re: [PATCH v2 1/1] user-manual.txt: assign preface an id and a title
References: <20210402121303.344914-1-firminmartin24@gmail.com>
        <20210404040739.2671960-1-firminmartin24@gmail.com>
        <20210404040739.2671960-2-firminmartin24@gmail.com>
Date:   Sat, 03 Apr 2021 23:21:31 -0700
In-Reply-To: <20210404040739.2671960-2-firminmartin24@gmail.com> (Firmin
        Martin's message of "Sun, 4 Apr 2021 06:07:39 +0200")
Message-ID: <xmqqr1jqy3h0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 003A891A-950E-11EB-9709-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Firmin Martin <firminmartin24@gmail.com> writes:

>     -<preface>
>     -<title></title>
>     +<preface id=3D"_introduction">
>     +<title>Introduction</title>

Makes sense.

>     -@node Top, idm4, , (dir)
>     +@node Top, Introduction, , (dir)

and of course this looks nicer.

>      @documentlanguage en
>      @top Git User Manual
>     =20
>      @menu
>     -* : idm4.
>     +* Introduction::

so does this.

And the side effects on other formats are ...

>     --- before/user-manual.html.md	2021-04-04 05:20:55.378695854 +0200
>     +++ after/user-manual.html.md	2021-04-04 05:21:11.282850802 +0200
>     @@ -4,6 +4,8 @@
>     =20
>       **Table of Contents**
>     =20
>     +Introduction
>     +
>      1\. Repositories and Branches
>     =20
>         =20
>     @@ -278,7 +280,7 @@
>     =20
>      Todo list
>     =20
>     -#
>     +# Introduction
>     =20
>      Git is a fast distributed revision control system.
>     =20
>     --- before/user-manual.pdf.txt	2021-04-04 05:28:20.367036836 +0200
>     +++ after/user-manual.pdf.txt	2021-04-04 05:30:01.680026312 +0200
>     @@ -487,6 +487,7 @@
>     =20
>      vii
>     =20
>     +Introduction
>      Git is a fast distributed revision control system.
>      This manual is designed to be readable by someone with basic UNIX =
command-line skills, but no previous knowledge of Git.
>      Chapter 1 and Chapter 2 explain how to fetch and study a project u=
sing git=E2=80=94read these chapters to learn how to build and test a

... all sensible.

> Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
> ---
>  Documentation/user-manual.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
> index fd480b8645..f9e54b8674 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1,5 +1,8 @@
>  =3D Git User Manual
> =20
> +[preface]
> +=3D=3D Introduction
> +
>  Git is a fast distributed revision control system.
> =20
>  This manual is designed to be readable by someone with basic UNIX

Thanks, will queue.
