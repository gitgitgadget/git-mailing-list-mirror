Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B99D1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 15:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeCTPeQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 11:34:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:53659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751448AbeCTPeP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 11:34:15 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjIit-1eSowD42JD-00dYHg; Tue, 20
 Mar 2018 16:34:07 +0100
Date:   Tue, 20 Mar 2018 16:33:46 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] rebase -i --keep-empty: don't prune empty commits
In-Reply-To: <20180320100315.15261-3-phillip.wood@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1803201630380.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180320100315.15261-1-phillip.wood@talktalk.net> <20180320100315.15261-3-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:r/c40nOMR1CC/eeLl2B5w4k7iTIBgC9vBKafrm7vH/93mS/2+JW
 ITpNo2guWvFnS2ab79Qc7AD79nVZgV4cKjuLggxib26e2yLjrz+X7CXAFpNdgJFa/S6A8zR
 gMwKeZbO+aJCNBY7vbqT8RJAETOrbNWwP1aJRNAJcO6QPtUNxjQ6bCWEor4G9rQc2m1G/V8
 joWKkinhxU6UsvCYLXkaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c51JesYVc2o=:GQE26J63LXnIuD5o5M66aq
 gtuvQ8BDOWcXGeMlRo907e0T2p7GMEBAfgB7M78mVY9AIhc0IJwOTPYvc6sPtb7Vz4UoRYvGQ
 9QxCcILJ8jzqm0KoCvFFO0WrwR7EUri5BDqSWRkpph/q+k13mnB45sA/sbX27LxAC0aO6jPk2
 wDRwCf0rgt6VuXVei0TaYPO+2h2W/Lb4/GO3DJmpGBs4OZEJGcaNEsCpGLTJWCw+gtqKBcx0n
 K7YpiqsvjjHYFy5QT/jQbH9WuE+DygD1ygQr+1JZw0c4Xb2/WoXRcKnYo8bvlIcMO2j+RaIR6
 ttgwEoKvFNOxyWK3KHf0ald+6aArlPy0LO5vWohTaqgAV2eVatG00s0ppyy6h1cQVVdcwaCot
 U/uz2v8NnlOWOh7WyoIDnVI6PvXDpPpiJKoaVkDqP6vzqhepVTungdCBlwa0lTMHdizcLmTOa
 17RjNyan9ElHYgAZsWjnpcrxthjI3Zhjfy9kjkPIYhj2RxFcC7VW4vg2m0bSHRIlC+8JwuFY8
 y3aFBwfaeLXvaoQ5ITAg1CWJ/Obx3ad5ggvi0BnqEnAgBEa9wQ3rlGA/XLKaYuUJR3nbZLFMb
 u2xHP/mQw/z7GKGjLxUJ2wRnNzKRC1atn1LLv8cW5b7mdZH4gkFIxSvLzMYqrAPdTZKjZG1UX
 ltzGXQmGIIb8HeQZ6jGvb29tHhPbJnd6QY2eUCjpPCY1gL13o6oVRigdgvGjc/di7FjR/0CyA
 yvVbRNFrWW4rRBkEtrwB7sj649gsE7ghMz4oLzdewzxBUFcbfUHintHRiVevzJu9HX0AU+lU0
 +SiWaQiSsQw6hAIHZqnCkRKmTf2Ppk3E2jJYjZBfcLIEc1h71k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 20 Mar 2018, Phillip Wood wrote:

> diff --git a/sequencer.c b/sequencer.c
> index 4d3f60594c..96ff812c8d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2470,7 +2470,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
>  	init_revisions(&revs, NULL);
>  	revs.verbose_header = 1;
>  	revs.max_parents = 1;
> -	revs.cherry_pick = 1;
> +	revs.cherry_mark = 1;

This will conflict with my --recreate-merges patch series, but in a good
way.

> @@ -2495,14 +2495,18 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
>  		return error(_("make_script: error preparing revisions"));
>  
>  	while ((commit = get_revision(&revs))) {
> +		int is_empty  = is_original_commit_empty(commit);
> +
>  		strbuf_reset(&buf);
> -		if (!keep_empty && is_original_commit_empty(commit))
> +		if (!keep_empty && is_empty)
>  			strbuf_addf(&buf, "%c ", comment_line_char);
> -		strbuf_addf(&buf, "%s %s ", insn,
> -			    oid_to_hex(&commit->object.oid));
> -		pretty_print_commit(&pp, commit, &buf);
> -		strbuf_addch(&buf, '\n');
> -		fputs(buf.buf, out);
> +		if (is_empty || !(commit->object.flags & PATCHSAME)) {

May I suggest inverting the logic here, to make the code more obvious and
also to avoid indenting the block even further?

		if (!is_empty && (commit->object.flags & PATCHSAME))
			continue;

> +			strbuf_addf(&buf, "%s %s ", insn,
> +				    oid_to_hex(&commit->object.oid));
> +			pretty_print_commit(&pp, commit, &buf);
> +			strbuf_addch(&buf, '\n');
> +			fputs(buf.buf, out);
> +		}
>  	}
>  	strbuf_release(&buf);
>  	return 0;

Thanks,
Dscho
