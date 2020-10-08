Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153D8C433DF
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 17:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD6F22202
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 17:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JdEzeUAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbgJHRc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 13:32:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54618 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbgJHRc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 13:32:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F1B3F6E38;
        Thu,  8 Oct 2020 13:32:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xyv5honhUnDyh4X6Ar6A1fbBW6c=; b=JdEzeU
        AO60XoOet5QFHc3ysoJ4i33jrHbG4uwVGH/YfFKghUMpeuAZP48VYc08c+S43MLO
        Esui0rPAWAjkpP5+S1RkN8MS7UM1u0NFQtSr6ehcR7fldrJ70Ndmluycs4K+JDGt
        DkXLTzCZx2WjQ26Gi/O7I9V3EG1BQfUwfiSJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=udyLY4j93gldS5mZQZWfAgwk91zs4LKw
        g+Kg567qWIqH/OfAw8gFQCJ0yeawZMqCCiIe38oD/PTxC868lvviiq6gSsz+RGG5
        HDze3HgJukgiuh09thd4weZpllMOTbNC7mwqUdcYLrsnu/4nTWeXyjPPpGU7K1dx
        sEEl4T3X3Vg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 97879F6E37;
        Thu,  8 Oct 2020 13:32:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DF45FF6E35;
        Thu,  8 Oct 2020 13:32:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] contrib/git-resurrect.sh: indent with tabs
References: <cover.1602139448.git.liu.denton@gmail.com>
        <5f5f1763043e80cbae6f9d4286aa5ba1960d32e0.1602139448.git.liu.denton@gmail.com>
Date:   Thu, 08 Oct 2020 10:32:22 -0700
In-Reply-To: <5f5f1763043e80cbae6f9d4286aa5ba1960d32e0.1602139448.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 7 Oct 2020 23:44:39 -0700")
Message-ID: <xmqqa6wwy66x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A12B68E-098C-11EB-B7C2-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In the git-resurrect script, there are a few lines that are mistakenly
> indented with spaces. Replace these lines with tabs.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  contrib/git-resurrect.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/git-resurrect.sh b/contrib/git-resurrect.sh
> index 8c171dd959..57a77c03f9 100755
> --- a/contrib/git-resurrect.sh
> +++ b/contrib/git-resurrect.sh
> @@ -27,7 +27,7 @@ n,dry-run            don't recreate the branch"
>  
>  search_reflog () {
>  	sed -ne 's~^\([^ ]*\) .*	checkout: moving from '"$1"' .*~\1~p' \
> -                < "$GIT_DIR"/logs/HEAD
> +		< "$GIT_DIR"/logs/HEAD
>  }

Unless this is done in preparation for a more meaningful change
(like not reading from on-disk logs/HEAD and instead reading from
"git reflog" output in order to help our future migration to the
reftable backend), I do not think the reviewers' time is worth it
for cosmetic changes on this script.

>  search_reflog_merges () {
> @@ -41,9 +41,9 @@ _x40="[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]"
>  _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>  
>  search_merges () {
> -        git rev-list --all --grep="Merge branch '$1'" \
> -                --pretty=tformat:"%P %s" |
> -        sed -ne "/^$_x40 \($_x40\) Merge .*/ {s//\1/p;$early_exit}"
> +	git rev-list --all --grep="Merge branch '$1'" \
> +		--pretty=tformat:"%P %s" |
> +	sed -ne "/^$_x40 \($_x40\) Merge .*/ {s//\1/p;$early_exit}"
>  }
>  
>  search_merge_targets () {
