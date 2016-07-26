Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73955203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 12:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287AbcGZMzW (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 08:55:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:56590 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225AbcGZMzU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 08:55:20 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MFR2O-1bVLGK3nEa-00EKra; Tue, 26 Jul 2016 14:55:17
 +0200
Date:	Tue, 26 Jul 2016 14:55:08 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Orgad Shaneh <orgads@gmail.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH] commit: Fix description of no-verify
In-Reply-To: <1469519305-11361-1-git-send-email-orgad.shaneh@audiocodes.com>
Message-ID: <alpine.DEB.2.20.1607261452281.14111@virtualbox>
References: <1469519305-11361-1-git-send-email-orgad.shaneh@audiocodes.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jCOAHRStEWu+1lF/z7ZzYO0cua1ckx4BV7Zf+fsiHlfegarFB9a
 4foQp6lFQCCVlBCChaX9XroW80Ja6BvrmAxD2azzMUdlf+Deir7f+6djA+DpU8iXv+UvAMn
 js7cALTyUV8cAwlqUSo/a3B5jV7QkS1c5+jyvg7KRoMsf7t8fbxTBArx17HannNHevitzi0
 fD5I/hzDI+Jvt3FLFH9Pg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:GBsF8VMOO2U=:cgqG0QlQz1WH1aiNm935N1
 94Zc2/ycs+lvlvnAjKqRxSt3fbHLfNLr6bUVljS+ENYMng21mzn1cZofyjpqCMxQtZsqDpIdM
 2JSaS4HIWCQi0WDMeGiz7SYurxzRtiB8scxHa5SWpI/OxMzKiSJJ8jFbxxqHVXkftYzcBkBaZ
 ypKCZabCKMVavCw7K/VR6pNYbo+VqhW8sfivGHHR5gh9A24Pv2/Xuq3JzGwjmW+L1vN2J3YGw
 XO+1eBzilkCFj+D2gFJndA1/tFr1g5TnT1B3BCBSXtVKT/xwq+k2pl0B2n3hhKB6EFqyTg/eh
 PpHduag68S1r3X6+2Q0VxEZIXf3VIRZ1JrkeLtWBalxMMKGeAPkUANPslwdbl7tV6o9FyFEeM
 roZ3by9I09yXvn7rgu9JFBNPy8z7EAIp4B6jtCsVRDLj1zRvehucc9z9yYrm9ge2LT9bTUlGG
 qlfb2UAeCWEDjDjkmjnvQWu9/V3LD7B9Y+qAEqjkOggKOq6oq1Y1r5nKoD8sf6Gv9fD9ZVxnB
 YU5ryFjqFhPdZAYOmwL/AWU8eCMqM9FStv4/cxqjqWYEp8pXwBw3+yaax/uI9bShJNAgDg39q
 6LP0pMc+ARCTn5rwqI4xTFwJCnaa/0Cml79cXtzWW429qf0NM9mm6xwjAS8N4RCK5t59gG5U6
 Ix2gzExESZEzk6ffLYfPx/NixSR4mATKRyj0q8WYBM7XrHPWoZVSODVjpXKxv88UN+seO+ABL
 n4ejWv6NI2jWL/RJtMqgdhADhsA8X1kK40JrKlAl22ijsr5/OSH/ADONgS0UW8ppvtgYSop0A
 aZr8g2N
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Orgad

On Tue, 26 Jul 2016, Orgad Shaneh wrote:

> From: Orgad Shaneh <orgads@gmail.com>

This is unnecessary, as it matches your email address.

> include also commit-msg hook.

This comment was a bit cryptic, until I read the patch. Now I find that
comment redundant with the patch.

However, I think that...

> -		OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit hook")),
> +		OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit and commit-msg hooks")),


... it may be more desirable to future-proof this simply by saying "bypass
hooks".

In the alternative, it would be good if the commit message could
convincingly make the case that there are no other hooks that will be
skipped with -n.

Of course, I could go and look at the source code to convince myself. But
it is really the duty of the commit message to be already convincing
enough.

Ciao,
Dscho
