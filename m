Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAEA31F728
	for <e@80x24.org>; Fri, 24 Jun 2016 11:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbcFXLj3 (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 07:39:29 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:52505 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750951AbcFXLj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 07:39:28 -0400
Received: (qmail 22127 invoked from network); 24 Jun 2016 11:39:25 -0000
Received: (qmail 19549 invoked from network); 24 Jun 2016 11:39:25 -0000
Received: from unknown (HELO [192.168.1.66]) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 24 Jun 2016 11:39:23 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Subject: Re: [PATCH] unpack-trees: fix English grammar in do-this-before-that
 messages
To:	Alex Henrie <alexhenrie24@gmail.com>
References: <20160624053135.7848-1-alexhenrie24@gmail.com>
From:	Vasco Almeida <vascomalmeida@sapo.pt>
X-Enigmail-Draft-Status: N1110
Cc:	gitster@pobox.com, diane.gasselin@ensimag.imag.fr,
	Matthieu.Moy@imag.fr, git@vger.kernel.org
Message-ID: <576D1BEA.8020509@sapo.pt>
Date:	Fri, 24 Jun 2016 11:39:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20160624053135.7848-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Às 05:31 de 24-06-2016, Alex Henrie escreveu:
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  unpack-trees.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 6bc9512..11c37fb 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -62,17 +62,17 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
>  	if (!strcmp(cmd, "checkout"))
>  		msg = advice_commit_before_merge
>  		      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
> -			  "Please commit your changes or stash them before you can switch branches.")
> +			  "Please commit your changes or stash them before you switch branches.")
>  		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s");

The only downside I can tell about this is translator are going to have
to update those strings on their translations, but that is a normal
thing to do on an active project like Git.

I'm not a native speak either, but I think I have translated that as if
the sentences were like this patch introduces. I agree with this change.
