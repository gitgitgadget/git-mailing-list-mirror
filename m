Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAFA9207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 16:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942090AbcJFQ2A (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 12:28:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39038 "EHLO mx1.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752677AbcJFQ17 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 12:27:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u96GRQYq008199
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 6 Oct 2016 18:27:26 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u96GRRBn025554;
        Thu, 6 Oct 2016 18:27:27 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johan Herland <johan@herland.net>,
        Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] push: Re-include "push.default=tracking" in the documentation
References: <20161006084905.14944-1-avarab@gmail.com>
        <vpq1sztsmji.fsf@anie.imag.fr>
        <CACBZZX5ycZbFrrVgr4PVy5pKQDbnvmvDxuephx7-uHzzcm3u=g@mail.gmail.com>
Date:   Thu, 06 Oct 2016 18:27:27 +0200
In-Reply-To: <CACBZZX5ycZbFrrVgr4PVy5pKQDbnvmvDxuephx7-uHzzcm3u=g@mail.gmail.com>
        (=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Thu, 6
 Oct 2016 18:18:18
        +0200")
Message-ID: <vpqlgy1h28g.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 06 Oct 2016 18:27:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u96GRQYq008199
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1476376049.92943@ZAjwMWCyviT4HCUOGhFRZw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Junio, looks like from the 2013 discussion that you preferred just
> having that mention in parenthesis instead of its own item, how about
> just re-applying your fa23348 (with conflicts resolved)?

(fa23348 did this:
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1749,7 +1749,8 @@ push.default::
   +
   This is currently the default, but Git 2.0 will change the default
   to `simple`.
-* `upstream` - push the current branch to its upstream branch.
+* `upstream` - push the current branch to its upstream branch
+  (`tracking` is a deprecated synonym for this).
)

I agree that doing the same thing is the best option.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
