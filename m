Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6FF2207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 12:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758065AbcILMXO (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 08:23:14 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:7187 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754615AbcILMXO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 08:23:14 -0400
Received: from [192.168.1.112] (unknown [164.177.97.114])
        (Authenticated sender: jn.avila)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 16089780398;
        Mon, 12 Sep 2016 14:23:02 +0200 (CEST)
Subject: Re: [PATCH v2 09/14] i18n: notes: mark error messages for translation
To:     Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org
References: <1473679802-31381-1-git-send-email-vascomalmeida@sapo.pt>
 <1473679802-31381-9-git-send-email-vascomalmeida@sapo.pt>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Message-ID: <83f72924-9a9d-dc1c-109f-341f0cd7ac96@free.fr>
Date:   Mon, 12 Sep 2016 14:23:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1473679802-31381-9-git-send-email-vascomalmeida@sapo.pt>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 12/09/2016 à 13:29, Vasco Almeida a écrit :
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>  builtin/notes.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index f848b89..abacae2 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -340,7 +340,7 @@ static struct notes_tree *init_notes_check(const char *subcommand,
>  
>  	ref = (flags & NOTES_INIT_WRITABLE) ? t->update_ref : t->ref;
>  	if (!starts_with(ref, "refs/notes/"))
> -		die("Refusing to %s notes in %s (outside of refs/notes/)",
> +		die(_("Refusing to %s notes in %s (outside of refs/notes/)"),
>  		    subcommand, ref);
>  	return t;
>  }

Not sure this one will be easy to localize. The verb is passed as a
parameter : see line 366 "list", line 426 "add", line 517 "copy", line
658 "show", line 816 "merge", line 908 "remove" or line 595 with argv[0].

If all the verbs are real subcommands, then the translators should be
warned that this is some english twisting, but that they need to refer
to the subcommand on the command line.

Otherwise,

Acked-by: Jean-Noël Avila <jean-noel.avila@free.fr>

JN
