Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1CE209B3
	for <e@80x24.org>; Fri, 14 Oct 2016 21:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932226AbcJNVIL (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 17:08:11 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35957 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753693AbcJNVIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 17:08:09 -0400
Received: by mail-yw0-f174.google.com with SMTP id u124so82410852ywg.3
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 14:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FQM14G44dLT68gxXHakMAWcJ3yVc64sDzvgUVoxZ4E4=;
        b=Ds/TkF/iBzd3LyxQv5Nf/rvRe1Lr7b3xz55iDtBWMOG5m59NkwrZXf48v2+ynmR30K
         7davPfTxcCqCI08ZE9LT7gM4zdyvNbx+iNeZiSumlVJ/OmQhe+e9p+No4DlmjY6Fh6nL
         ioTM/ga3LOq8oZVbgr0HNeGfbEkR+lkQxi6XNTrXnMjpQlPn+o8OaqabcFPh+5ocHmd/
         Q9U4bg3vRbFSdnnf5wwmQ9wsyem/onlwhcIDqdq1Nk0vZyCGmHa5txzRsH+ttKXnEcJS
         Qu8gpGqBQZgjH9D9aWRn7P7s24SybFWnma9WSodQ4T69QHnMffnrVY6i4/ZGSQ45mzuu
         7rZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FQM14G44dLT68gxXHakMAWcJ3yVc64sDzvgUVoxZ4E4=;
        b=da5gqQtjOSHgGx399997Dpkyr1nN9nitVj9IRBYsHW4sOQF/+vuQL51zn/E0qQ3XjU
         Fs+HqJSXGvIjWuhJadTSF4YM/fKt7wmQXUMsO516Yi1aAYn5PG3VY/sK4zcPGWbcM0y2
         O0meHRJYO4ZusIn0XdeoWuEx9DTUGpe1nKck42svN/oDCcvgLwGDecUmfHDtKl9UR3+5
         ggWYoGRWnIvS/3QgzmSy7oWCTin+CvVvOFcJW7H6zWI8216ZZ7gcwWnJyZuLQo6Sobsn
         pImWAIlvZ0KIbEHB6JBEZu1BNLaUAC9KHxxvLhnTFYB5YnxKu5P5e+37A/6lfegRtZwO
         tasQ==
X-Gm-Message-State: AA6/9RkEV5o7H6BOiJbXMDOKDHAyDer12JKTGHd/8GOfH9z5oMuToqzehesqPEHhLgTBazSeuEEJMh/OWQNifg==
X-Received: by 10.129.32.196 with SMTP id g187mr12304636ywg.62.1476479228966;
 Fri, 14 Oct 2016 14:07:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.208.3 with HTTP; Fri, 14 Oct 2016 14:06:48 -0700 (PDT)
In-Reply-To: <20161014205842.GA6350@ikke.info>
References: <CACPiFC+8+wVEcDt9JZgTW1dwCCFKszyXD6ysDxNQorcNkom7Lw@mail.gmail.com>
 <20161014205842.GA6350@ikke.info>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Fri, 14 Oct 2016 17:06:48 -0400
Message-ID: <CACPiFCJFXGmsJX97kQuA2h3trVX7L3SacwKrD4mpEU5SPxkLAA@mail.gmail.com>
Subject: Re: Automagic `git checkout branchname` mysteriously fails
To:     Kevin Daudt <me@ikke.info>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2016 at 4:58 PM, Kevin Daudt <me@ikke.info> wrote:
> Correct, this only works when it's unambiguous what branch you actually
> mean.

That's not surprising, but there isn't a warning. IMHO, finding
several branch matches is a strong indication that it'll be worth
reporting to the user that the DWIM machinery got hits, but couldn't
work it out.

I get that process is not geared towards making a friendly msg easy,
but we could print to stderr something like:

 "branch" matches more than one candidate ref, cannot choose automatically.
 If you mean to check out a branch, try git branch command.
 If you mean to check out a file, use -- before the pathname to
 disambiguate.

and then continue with execution. With a bit of wordsmithing, the msg
can be made to be helpful in the various failure modes.

cheers,


m
-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
