Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E7A51F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754552AbcJNNqy (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:46:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34449 "EHLO mx2.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756873AbcJNNqu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:46:50 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u9EDkikD008493
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 14 Oct 2016 15:46:44 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u9EDkkvg027862;
        Fri, 14 Oct 2016 15:46:46 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Can we make interactive add easier to use?
References: <CAHd499AnuVximRgM0MKdq5JC-hwkrhox6bK_KA+XGrawoz2W+g@mail.gmail.com>
Date:   Fri, 14 Oct 2016 15:46:46 +0200
In-Reply-To: <CAHd499AnuVximRgM0MKdq5JC-hwkrhox6bK_KA+XGrawoz2W+g@mail.gmail.com>
        (Robert Dailey's message of "Fri, 14 Oct 2016 08:20:40 -0500")
Message-ID: <vpqfunz2gc9.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Fri, 14 Oct 2016 15:46:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u9EDkikD008493
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1477057605.49763@MzuzyJNwGhlU2/Qh01NUNg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey <rcdailey.lists@gmail.com> writes:

> Normally when I use interactive add, I just want to add files to the
> index via simple numbers, instead of typing paths. So I'll do this as
> quick as I can:
>
> 1. Type `git add -i`
> 2. Press `u` after prompt appears
> 3. Press numbers for the files I want to add, ENTER key
> 4. ENTER key again to go back to main add -i menu
> 5. Press `q` to exit interactive add
> 6. Type `git commit`
>
> This feels very tedious. Is there a simplified workflow for this?

My workflow is to ... not use "git add -i" ;-).

To add patch hunks individually, "git add -p" jumps directly to the
"patch" inner loop of "git add -i".

To add whole individual files, a plain "git add" using zsh's smart
completion (autocompletes only files for which "git add" is not a
no-op), or globs.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
