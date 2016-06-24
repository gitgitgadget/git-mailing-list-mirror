Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A34671F728
	for <e@80x24.org>; Fri, 24 Jun 2016 09:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbcFXJ0m (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 05:26:42 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34721 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbcFXJ0l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 05:26:41 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u5O9QUhG000735
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 24 Jun 2016 11:26:30 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5O9QVOm010494;
	Fri, 24 Jun 2016 11:26:31 +0200
From:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:	Alex Henrie <alexhenrie24@gmail.com>
Cc:	gitster@pobox.com, diane.gasselin@ensimag.imag.fr,
	vascomalmeida@sapo.pt, git@vger.kernel.org
Subject: Re: [PATCH] unpack-trees: fix English grammar in do-this-before-that messages
References: <20160624053135.7848-1-alexhenrie24@gmail.com>
Date:	Fri, 24 Jun 2016 11:26:31 +0200
In-Reply-To: <20160624053135.7848-1-alexhenrie24@gmail.com> (Alex Henrie's
	message of "Thu, 23 Jun 2016 23:31:35 -0600")
Message-ID: <vpqeg7nj5tk.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Fri, 24 Jun 2016 11:26:30 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5O9QUhG000735
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check:	1467365193.5061@JAP09Wc6jUiFv7glojUrTQ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

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

I'm not a native speaker, but I think both versions are correct.

I'm OK with the change, though. Dropping something useless is usually a
good thing :-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
