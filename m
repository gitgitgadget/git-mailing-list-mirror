Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FEA7207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 12:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753240AbcJFMNf (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 08:13:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57847 "EHLO mx1.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751591AbcJFMNe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 08:13:34 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u96CDKZQ006971
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 6 Oct 2016 14:13:20 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u96CDLE8018060;
        Thu, 6 Oct 2016 14:13:21 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johan Herland <johan@herland.net>,
        Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] push: Re-include "push.default=tracking" in the documentation
References: <20161006084905.14944-1-avarab@gmail.com>
Date:   Thu, 06 Oct 2016 14:13:21 +0200
In-Reply-To: <20161006084905.14944-1-avarab@gmail.com> (=?iso-8859-1?Q?=22?=
 =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?=
        Bjarmason"'s message of "Thu, 6 Oct 2016 08:49:05 +0000")
Message-ID: <vpq1sztsmji.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 06 Oct 2016 14:13:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u96CDKZQ006971
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1476360804.50831@Db6QXkF+9fSISBQd0I7V0g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> That's bad, either we shouldn't support it at all, or we should
> document what it does. This patch does the latter.

I vaguely remember a similar discussion and probably even a patch in the
past (maybe by you actually). I think the proposal was to add a mention
of tracking but avoid promoting it at the same level as the others.

I have a slight preference for a patch adding stg like "`tracking` is a
deprecated alias supported only for backward compatibility" to the item
of `upstream`, but I'm OK with the current patch too.

> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2344,6 +2344,10 @@ push.default::
>    pushing to the same repository you would normally pull from
>    (i.e. central workflow).
>  
> +* `tracking` - Deprecated synonym for `upstream`, which we still
> +  support for backwards compatibility with existing configuration
> +  files.

Nit: I think the doc normally doesn't use "we" this way (we = the Git
developers or the Git tool). Hence my s/which we still support/still
supported/ above.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
