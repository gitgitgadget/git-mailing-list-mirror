Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 820871FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 21:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbcHQVSq (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 17:18:46 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:33492 "EHLO
	mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbcHQVSp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 17:18:45 -0400
Received: by mail-ua0-f178.google.com with SMTP id 74so357323uau.0
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 14:18:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m2r8SQauY/vjLySCK4B4D0OGXssQeMtGMOXyWY/Ln2I=;
        b=YjvtNXEew6g7r3ALy9BvNm9kMe4dukN/TpI3f4SiLFYm32VpT5d5e3BATLObR3nd9e
         b+o30Oup5nDWcJTPcTFkxHc3kh+LTWPcEMduvehLQRsTq1IAP/MYglxAINS8sUyJhz3T
         eLaMKLxyyqWGa8B8ZlFs9NKF1eGxrx/i+swOw9vsX8EZH0V0M1oJW+iJeJeLIBG+wqtO
         tsOyU+DVi2yi6LcctEZ0WXP8AO5vJUmc4dB76VBfvS2fxzSLtRVNNylyHCGXqFHaHeJG
         H5xjJ2fXDt6Db+CfkOPW4B+/m5z/09LEYDUiQi5NIBPtWwACirtXxdhESY/zQASkhPJG
         A87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m2r8SQauY/vjLySCK4B4D0OGXssQeMtGMOXyWY/Ln2I=;
        b=jR1SFOtGVkAHHXqw6aV+SSM2mEtttDiA5DMuURCk5h3lIoIH0iqmLekDNpRNRmigv1
         R9KdONuOL8qfRr6RN35/aTkOqOi6iY3lSDydVI0FU14x6aaCB34jwS6pzFumKtuaO8eC
         5w5HQ0VACr2LqJlfRy9YlPAEp9Ov/uQz3ALJmqFeSEqYy6EqpYs2b28tJuRoYDzMbKi7
         slubblDyJPFAs71THKGlaxyO5bvJizNB16K8xlJZKbEa33nHHMKEZ4nhvVnLhPaUXdSR
         VIJVwsQbcU5S8dDpF5AHo4cmV4huN/51pcD+GKzeBZcCSb31qvxFKmzBQ0rCmJvUBn13
         ZcMw==
X-Gm-Message-State: AEkooutCvgwkHvJzd2zA3qE1YELJ/w3sdSdpFM4K8p6riOpUPr0GMqkk0jEOFk5xLtHIOQ==
X-Received: by 10.159.36.108 with SMTP id 99mr7355022uaq.79.1471468724635;
        Wed, 17 Aug 2016 14:18:44 -0700 (PDT)
Received: from gmail.com ([2800:370:4c:3a70::3])
        by smtp.gmail.com with ESMTPSA id 6sm178602uar.8.2016.08.17.14.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Aug 2016 14:18:37 -0700 (PDT)
Date:	Wed, 17 Aug 2016 14:18:28 -0700
From:	David Aguilar <davvid@gmail.com>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Luis Gutierrez <luisgutz@gmail.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org
Subject: Re: git-mergetool reverse file ordering
Message-ID: <20160817211828.GB14619@gmail.com>
References: <CAD8hE_yzNZDPkxRy8s4Fy2_dZN5ppWzLM_2xc01C-VAdR1Pj_g@mail.gmail.com>
 <20160814034221.GB21057@gmail.com>
 <20160814103801.tpixnskdsf5ycj66@john.keeping.me.uk>
 <CAD8hE_xR2mB3=_oot9cWxmFy7z4oBhjABNOo3aJKN=bOw5ybzQ@mail.gmail.com>
 <20160817012554.GA12991@gmail.com>
 <18a1ef52-1c5b-4f0a-5da2-777e816a1e3e@kdbg.org>
 <882f5f1d-19a6-7b4b-7c6a-7347981fee72@kdbg.org>
 <20160817064612.GA14619@gmail.com>
 <1c089d6b-0acc-a5da-91bf-1887b6eaedbb@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c089d6b-0acc-a5da-91bf-1887b6eaedbb@kdbg.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


Hi Luis and Hannes,

On Wed, Aug 17, 2016 at 09:35:56AM +0200, Johannes Sixt wrote:
> Am 17.08.2016 um 08:46 schrieb David Aguilar:
> > The only thing that using diff-files doesn't address is the
> > rerere support in mergetool where it processes the files in
> > the order specified by "git rerere remaining".  This is why I
> > initially thought we needed a generic sort-like command.
> 
> I see. This is actually an important code path. How about this code
> structure:
> 
> if test $# -eq 0
> then
> 	cd_to_toplevel
> 
> 	if test -e "$GIT_DIR/MERGE_RR"
> 	then
> 		set -- $(git rerere remaining)
> 	fi
> fi
> files=$(git diff-files --name-only --diff-filter=U -- "$@")
> 

Beautiful.

> This does not require an enhancement of rerere-remaining and still captures
> all three cases that currently go through separate branches. (Throw in some
> version of --ignore-submodules= if necessary, but I guess it is not.)
> 
> We do have a problem if there are file names with spaces, but it is not a
> new problem.

Thanks for the heads-up about file names with spaces.  We set,

IFS='
'

in git-mergetool--lib.sh so file names with spaces should be ok.
Naturally, we won't be able to support paths with embedded
newlines, but that's not a new problem ;-)

We should probably also set core.quotePath=false when calling
diff-files so that git doesn't try to quote "unusual" paths,
e.g.

	git -c core.quotePath=false diff-files ...

Lastly, for anyone that's curious, I was wondering why we were
passing "-u" to "sort", and why we won't need to use "uniq" in
the new version.

The reason is that "ls-files -u" lists the different index
stages separately, and thus it reports duplicate paths.

"diff-files" with "--diff-filter=U" does not do that, so that's
another benefit to be gained from this change.

I think we've touched all the bases now.

Luis, I hope that makes sense.  Let us know if any of this is
unclear.


ciao,
-- 
David
