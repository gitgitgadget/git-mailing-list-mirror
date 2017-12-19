Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BD041F406
	for <e@80x24.org>; Tue, 19 Dec 2017 20:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbdLSU2P (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 15:28:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56087 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750918AbdLSU2O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 15:28:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 128A4AF4B2;
        Tue, 19 Dec 2017 15:28:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/LqG/KXon3WXtHHzmGtn70nev34=; b=WZKXIU
        nSkq3zDYlJwAZ3E32rcKG0LTvF3IW3khws3r/WRQOCbWQG3JCqbQ16frLrGEFc7f
        Ckxgyic92Zl4m0crPGasOtIMloB88oCHOXXotkezU56f5WwQpCO41H4Zs+jeli2W
        ST+Qy23pL05vKjirCzB8JTfVPWuBZiztM8gsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qmx/B3HjmA31ZkxHL7fHrbzX58X3bNQp
        hClyN+zmWVLEBTgYeZfqCaFXAxZlVeusVVeOGdbsjtEnqnUxD/F8hLGDIg/Its24
        NDmOfMsU+z93a2205gPiuUxr3/Xl1tDUbeiJPuu65r/Oj6AOAg/gIcawN13UlGlM
        XJ7WPdqTpGU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B0EAAF4B0;
        Tue, 19 Dec 2017 15:28:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7859AAF4A8;
        Tue, 19 Dec 2017 15:28:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 4/6] fsmonitor: Add a trailing newline to test-dump-fsmonitor
References: <20171219002858.22214-1-alexmv@dropbox.com>
        <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com>
        <dab89f071d22a21b85dff5d31e9e9a8ceb6458e3.1513642743.git.alexmv@dropbox.com>
Date:   Tue, 19 Dec 2017 12:28:12 -0800
In-Reply-To: <dab89f071d22a21b85dff5d31e9e9a8ceb6458e3.1513642743.git.alexmv@dropbox.com>
        (Alex Vandiver's message of "Mon, 18 Dec 2017 16:28:56 -0800")
Message-ID: <xmqqlghyv4wz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 231C6F64-E4FB-11E7-AA6E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Vandiver <alexmv@dropbox.com> writes:

> Subject: Re: [PATCH 4/6] fsmonitor: Add a trailing newline to test-dump-fsmonitor

"Subject: fsmonitor: complete the last line of test-dump-fsmonitor output"

perhaps.

> This makes it more readable when used for debugging from the
> commandline.
>
> Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
> ---
>  t/helper/test-dump-fsmonitor.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
> index 53b19b39b..4e56929f7 100644
> --- a/t/helper/test-dump-fsmonitor.c
> +++ b/t/helper/test-dump-fsmonitor.c
> @@ -19,5 +19,6 @@ int cmd_main(int ac, const char **av)
>  	for (i = 0; i < istate->cache_nr; i++)
>  		printf((istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) ? "+" : "-");
>  
> +	printf("\n");

That (and existing) uses of printf() all feel a bit overkill ;-)
Perhaps putchar() would suffice.

I am not sure if the above wants to become something like

	for (i = 0; i < istate->cache_nr; i++) {
        	putchar(istate->cache[i]->ce_flags & CE_FSMONITOR_VALID ? '+' : '-');
		quote_c_style(istate->cache[i]->name, NULL, stdout, 0);
		putchar('\n');
	}

instead of "a single long incomplete line" in the first place.  Your
"fix" merely turns it into "a single long complete line", which does
not quite feel big enough an improvement, at least to me.

>  	return 0;
>  }
