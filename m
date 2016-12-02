Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFEF51FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 13:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758316AbcLBNmS (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 08:42:18 -0500
Received: from mx1.imag.fr ([129.88.30.5]:52896 "EHLO mx1.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757569AbcLBNmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 08:42:16 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id uB2Dg3PG028704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 2 Dec 2016 14:42:03 +0100
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id uB2Dg4Q9001050;
        Fri, 2 Dec 2016 14:42:04 +0100
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     "Alfonsogonzalez\, Ernesto \(GE Digital\)" 
        <ernesto.alfonsogonzalez@ge.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "Your branch is ahead of 'origin' by X commits"
References: <D465BDE6.B7DE%ernesto.alfonsogonzalez@ge.com>
Date:   Fri, 02 Dec 2016 14:42:04 +0100
In-Reply-To: <D465BDE6.B7DE%ernesto.alfonsogonzalez@ge.com> (Ernesto
        Alfonsogonzalez's message of "Thu, 1 Dec 2016 19:49:40 +0000")
Message-ID: <vpqk2bisb0z.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Fri, 02 Dec 2016 14:42:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: uB2Dg3PG028704
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1481290927.64846@Ld9yQQR84nwCShksnTRBTQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alfonsogonzalez, Ernesto (GE Digital)" <ernesto.alfonsogonzalez@ge.com>
writes:

> Hi,
>
> Git status tells me "Your branch is ahead of 'origin' by 108 commits.²,
> but my local and origin/master are pointing to the same commit.
>
> What am I doing wrong?
>
> $ git diff origin/master
> $ git status
> On branch master
> Your branch is ahead of 'origin' by 108 commits.

This line should say "ahead of 'origin/master'" in common setups, where
'origin/master' is the remote-tracking branch configured as upstream for
'master'.

My guess is that you have a badly configured upstream.

What does "git pull -v" say? What's the content of the [branch "master"]
section of .git/config?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
