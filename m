Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED8B51FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 18:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756124AbcK2Sf4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 13:35:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62221 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753367AbcK2Sfk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 13:35:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D59E352A56;
        Tue, 29 Nov 2016 13:35:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tfldWfu2KXdGDricDFTRTiVj3y0=; b=km2xVz
        DhifEI2gCVr2xOblsC70Wh/cOL7DM4iSDflfh3AOPHiw5zvc9W+iYx2LPudL/H2z
        M7AjdVbNBF+qxrgE+25IjEDVzz2vZ9eJzUPcQYpWdCerJmPMCC4fI+9nf7XxeJYc
        lDJDnzL8BG1E4sH3TUacv8uRDwv2L2jHFpajA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tb7hhnFnU65go8Vj0oymEkF0lo/P8JZu
        q953u+ko6Cw426HV5iDsREzlgUD2XYXZrXVpr0LIuteMVh3gCJnOeHJP6JVKdmi2
        jTYmo4nDVY5L5GRgvRB9a1C2YVSSGm+wDcoreIljh9T6aDwKY/WbIHqo5ha8Wh3d
        6BsvBf0g2b0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDD2752A55;
        Tue, 29 Nov 2016 13:35:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C55552A54;
        Tue, 29 Nov 2016 13:35:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] RelNotes: typo fix in 2.11.0 notes
References: <xmqqinrdlr3o.fsf@gitster.mtv.corp.google.com>
        <20161129095725.13280-1-tklauser@distanz.ch>
Date:   Tue, 29 Nov 2016 10:35:38 -0800
In-Reply-To: <20161129095725.13280-1-tklauser@distanz.ch> (Tobias Klauser's
        message of "Tue, 29 Nov 2016 10:57:25 +0100")
Message-ID: <xmqqbmwygmmd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A044EC50-B662-11E6-8996-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tobias Klauser <tklauser@distanz.ch> writes:

> s/paht/path/ in the "Backwards compatibility notes" section of the
> 2.11.0 release notes.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---

This looks somewhat familiar.  Perhaps

  https://public-inbox.org/git/1477668782.1869.4.camel@seestieto.com/



>  Documentation/RelNotes/2.11.0.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/RelNotes/2.11.0.txt b/Documentation/RelNotes/2.11.0.txt
> index b7b7dd361ef0..4c8a9be60f52 100644
> --- a/Documentation/RelNotes/2.11.0.txt
> +++ b/Documentation/RelNotes/2.11.0.txt
> @@ -5,7 +5,7 @@ Backward compatibility notes.
>  
>   * An empty string used as a pathspec element has always meant
>     'everything matches', but it is too easy to write a script that
> -   finds a path to remove in $path and run 'git rm "$paht"' by
> +   finds a path to remove in $path and run 'git rm "$path"' by
>     mistake (when the user meant to give "$path"), which ends up
>     removing everything.  This release starts warning about the
>     use of an empty string that is used for 'everything matches' and
