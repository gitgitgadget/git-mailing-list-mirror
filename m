Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29772C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBDB664E09
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhBWTQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:16:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62641 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhBWTQg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 14:16:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8B02BC433;
        Tue, 23 Feb 2021 14:15:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=rDPgew85pHuryIbT11c3T5dKjPI=; b=LaRN2VcRA0h9iuOMj1Xt
        b+GQ2ixqFpAryslcjNwnJmK68vuIsUNvjm2FL/SMGp+DzJHyhfvGxOsgk9mzBTPt
        qa5lv4mHBNHH+Nlzk0T9kn2x3WbFjSIpG0mc/jTPVwjfn8i5sBYj5WxjjoA/kSr5
        rr1aq0bOkJpf68gkjuLBVoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=vb/6LFbGmSXPfJ9I2OJK64SYDMtG3XkRQxlYURzUlzHWzA
        dlVLVrJM6Bhl+hvQA0gqp2I/p4BAA0XwEmvo6ODUrjSnmASYi++TM9lwvc0nKTy0
        V+MQM8f9O0jGN2f/1zU188UlvD85rxfbR92QBERwx5xXUA/6WxtyTieG1G9Co=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD19DBC432;
        Tue, 23 Feb 2021 14:15:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 59DD1BC431;
        Tue, 23 Feb 2021 14:15:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] i18n.txt: camel case and monospace
 "i18n.commitEncoding"
References: <cover.1614062288.git.liu.denton@gmail.com>
        <cc48b125166a241ef5f24138fd161223ab35e361.1614062288.git.liu.denton@gmail.com>
Date:   Tue, 23 Feb 2021 11:15:50 -0800
Message-ID: <xmqq7dmy389l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B0277D2-760B-11EB-A21B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In 95791be750 (doc: camelCase the i18n config variables to improve
> readability, 2017-07-17), the other i18n config variables were
> camel cased. However, this one instance was missed.
>
> Camel case and monospace "i18n.commitEncoding" so that it matches the
> surrounding text.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Documentation/i18n.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looking good.

> diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
> index 7e36e5b55b..6c6baeeeb7 100644
> --- a/Documentation/i18n.txt
> +++ b/Documentation/i18n.txt
> @@ -38,7 +38,7 @@ mind.
>    a warning if the commit log message given to it does not look
>    like a valid UTF-8 string, unless you explicitly say your
>    project uses a legacy encoding.  The way to say this is to
> -  have i18n.commitencoding in `.git/config` file, like this:
> +  have `i18n.commitEncoding` in `.git/config` file, like this:
>  +
>  ------------
>  [i18n]

Thanks, but whenever you noticed an issue like "Ah, here we used an
incorrect spelling i18n.commitencoding", please make it a habit to
see if we did exactly the same mistake elsewhere (you have been
working with Git long enough to know how cheap such a check is):

    $ git grep -F -e i18n.commitencoding -- \
         Documentation/ ':!Documentation/RelNotes/'

and you would have found three other instances.

This obviously does not have to be part of this miniseries, but I
wonder if we should have a list of all the configuration variables
in one place that we can use to record the canonical spelling of
these variables.  As

$ git grep -h -E -i \
	-e '^[a-z][-a-z0-9]*\.[a-z][-a-z0-9]*::' \
	-e '^[a-z][-a-z0-9]*\.(\*|<?[a-z][-a-z0-9]*>?)\.(\*|<?[a-z][-a-z0-9]*>?)::' \
	Documentation/config

gives many hits with camelCased names, it might be a good place to
start.

Pretending that the above gives a good "canonical list" (it does not
yet, if you look at the hits), I got curious how far we can go.

Massaging the output from the above into config-variables.lst

$ ... above command ... |
  sed -e 's/::$//' |
  sort -u >config-variables.lst

and then to extract use of these tokens in the main part of the
documentation like this:

$ git grep -h -o -i -F -f config-variables.lst -- \
  Documentation/ ':!Documentation/RelNotes/' |
  sort -u >config-usage.lst

gives us something we can compare with the "canonical" usage list.

$ comm -3 config-usage.lst config-variables.lst
blame.blankboundary
core.excludesfile
core.filemode
core.gitproxy
core.ignorestat
core.logallrefupdates
core.repositoryformatversion
core.trustCtime
http.sslverify
http.sslversion
i18n.commitencoding
push.pushoption
remote.<name>.partialCloneFilter
remote.pushdefault
repack.UseDeltaBaseOffset
sendemail.aliasesfile
showbranch.default
transfer.hiderefs
uploadArchive.allowUnreachable

Some of them may be false hits, some may be showing that the copy in
Documentation/config/ are spelled in all lowercase, but the majority
of the hits above seem to be genuine errors similar to what you fixed
in your patch.

Thanks.


