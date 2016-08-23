Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E1F41FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753455AbcHWQHR (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:07:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53465 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751032AbcHWQHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:07:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0EEC34FCD;
        Tue, 23 Aug 2016 12:06:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xPFsYCjPEp+ryuPJjNwr1hqKn40=; b=vrNg78
        WSTw8nQLxv8NaNh+7XwuWUpQAulnRQMbbGpEHZ2svttgIHLY+Z74zmrKgTNe59fi
        UIElMEG30v3gdPMQ3Pawf8YzMJodOBCDs3DAqAEm5f0MoSGiaBKQiCNjRNuhf4wV
        eZ4HjVzK3W24Sj4kcdYoFVWBz/arF1F6G66NA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B/ODCiwblUgL43p9bgBI0Y/EJGSEuJ+W
        IlnVYMw2rkAA2baEMPVRD+1is0mhFiIsf00SjIiyvoQ7qxZ10ROLiN8o8WgyJapl
        oCSonBNPxiHEDL2z7XEVZjB52zoHHV+vqW72AOhpAqYLK7WtE+w/ZeMophYj8cuL
        NtEgbatG3y0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8F1134FCC;
        Tue, 23 Aug 2016 12:06:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4B19D34FCA;
        Tue, 23 Aug 2016 12:06:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] i18n: fix typos for translation
References: <xmqqy43rxqqz.fsf@gitster.mtv.corp.google.com>
        <20160821145039.12121-1-jn.avila@free.fr>
Date:   Tue, 23 Aug 2016 09:06:13 -0700
In-Reply-To: <20160821145039.12121-1-jn.avila@free.fr> (Jean-Noel Avila's
        message of "Sun, 21 Aug 2016 16:50:37 +0200")
Message-ID: <xmqqk2f7xyfe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84D264FC-694B-11E6-82B6-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noel Avila <jn.avila@free.fr> writes:

> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> ---
>  bisect.c    | 10 +++++-----
>  sequencer.c |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 6f512c2..b9a0701 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -760,7 +760,7 @@ static void handle_skipped_merge_base(const unsigned char *mb)
>  	char *bad_hex = oid_to_hex(current_bad_oid);
>  	char *good_hex = join_sha1_array_hex(&good_revs, ' ');
>  
> -	warning(_("the merge base between %s and [%s] "
> +	warning(_("The merge base between %s and [%s] "

I _think_ most these are not typos and must stay as they are.  From
time to time we try to clean things up, cf. 8c3ca351 (config:
lower-case first word of error strings, 2016-04-09).

The removal of "a" from "a another reviert" is good.  If you are
fixing the cases, you would want to do the correction the other way.

>  		"must be skipped.\n"
>  		"So we cannot be sure the first %s commit is "
>  		"between %s and %s.\n"
> @@ -846,7 +846,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
>  	int fd;
>  
>  	if (!current_bad_oid)
> -		die(_("a %s revision is needed"), term_bad);
> +		die(_("A %s revision is needed"), term_bad);
>  
>  	/* Check if file BISECT_ANCESTORS_OK exists. */
>  	if (!stat(filename, &st) && S_ISREG(st.st_mode))
> @@ -863,7 +863,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
>  	/* Create file BISECT_ANCESTORS_OK. */
>  	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
>  	if (fd < 0)
> -		warning_errno(_("could not create file '%s'"),
> +		warning_errno(_("Could not create file '%s'"),
>  			      filename);
>  	else
>  		close(fd);
> @@ -914,7 +914,7 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
>  			*read_good = "good";
>  			return;
>  		} else {
> -			die_errno(_("could not read file '%s'"), filename);
> +			die_errno(_("Could not read file '%s'"), filename);
>  		}
>  	} else {
>  		strbuf_getline_lf(&str, fp);
> @@ -944,7 +944,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
>  
>  	read_bisect_terms(&term_bad, &term_good);
>  	if (read_bisect_refs())
> -		die(_("reading bisect refs failed"));
> +		die(_("Reading bisect refs failed"));
>  
>  	check_good_are_ancestors_of_bad(prefix, no_checkout);
>  
> diff --git a/sequencer.c b/sequencer.c
> index 2e9c7d0..3804fa9 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -702,7 +702,7 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
>  	if (action != opts->action) {
>  		if (action == REPLAY_REVERT)
>  		      error((opts->action == REPLAY_REVERT)
> -			    ? _("Cannot revert during a another revert.")
> +			    ? _("Cannot revert during another revert.")
>  			    : _("Cannot revert during a cherry-pick."));
>  		else
>  		      error((opts->action == REPLAY_REVERT)
