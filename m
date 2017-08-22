Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84C0F1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 19:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753489AbdHVTWs (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 15:22:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63444 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753596AbdHVTWp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 15:22:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26AC6A7514;
        Tue, 22 Aug 2017 15:22:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hx7WzWQtnWTHNL5bhTKwjPv20Ok=; b=jkuTYj
        wSFGEiu1cQq67CD5x3zSUNEqI+wla+7IXPOtb21QwKTYU1LMNKM0CuXij6chT343
        ma2SSzMrRleGTxz9+Oqivefgy5Jt0ZoWNodh7bmp/PliET2bC322Fg6aGx3F1j40
        pgERapz1LyYnlRVn+M4aqaBz/bFWGz4DPaEfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kZfYCfvCq2qbWRxThKw0gsltDCp24yyO
        W74Wkbp+KkiPBs3HLByeO/t+CrwSwfT0RTLDW+qPLicxsiE6P9nNQF/coTCI6Dvx
        Sd4EN857qER03H+upr3LZV2jhVTXLfU0HVwaXnxHqFA8VdUo9nLL46K5F5HKYPst
        vsLLg2ctBpc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D435A7513;
        Tue, 22 Aug 2017 15:22:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65B88A7512;
        Tue, 22 Aug 2017 15:22:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Job Snijders <job@instituut.net>
Cc:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        yashi@atmark-techno.com, Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add 'raw' blob_plain link in history overview
References: <20170802185901.GA27243@Vurt.local>
        <20170820180332.GC39363@Vurt.local>
        <CAOxFTcxOt878uDYj1Y0QMDNe8mNkfX3ZaZayOH3Njp9RWCJo0Q@mail.gmail.com>
        <20170821104425.geetdgi7q2uqycyt@hanna.meerval.net>
        <CAOxFTcxaxRjdsd0OSQX9E9ncEnO4XFLoa-0puXm2AByv6dZUow@mail.gmail.com>
        <20170821141306.wnlfn5a4hmgnj3yn@hanna.meerval.net>
Date:   Tue, 22 Aug 2017 12:22:43 -0700
In-Reply-To: <20170821141306.wnlfn5a4hmgnj3yn@hanna.meerval.net> (Job
        Snijders's message of "Mon, 21 Aug 2017 16:13:06 +0200")
Message-ID: <xmqqo9r72yrg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4614F606-876F-11E7-819B-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Job Snijders <job@instituut.net> writes:

> Add 'raw' blob_plain link in history overview
>
> Reviewed-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> Signed-off-by: Job Snijders <job@instituut.net>
>
> ---

Thanks; I somehow thought that your earlier one not just said what
it does (twice---that is not needed) but why this change is useful,
but that is lost in the patch description?

>  gitweb/gitweb.perl | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 9208f42ed..959f04b49 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5967,6 +5967,9 @@ sub git_history_body {
>  		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
>  
>  		if ($ftype eq 'blob') {
> +			print " | " .
> +			      $cgi->a({-href => href(action=>"blob_plain", hash_base=>$commit, file_name=>$file_name)}, "raw");
> +
>  			my $blob_current = $file_hash;
>  			my $blob_parent  = git_get_hash_by_path($commit, $file_name);
>  			if (defined $blob_current && defined $blob_parent &&
