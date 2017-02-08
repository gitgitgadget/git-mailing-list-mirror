Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B43471FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 02:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbdBHCm5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 21:42:57 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36275 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdBHCm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 21:42:56 -0500
Received: by mail-pg0-f68.google.com with SMTP id 75so13715985pgf.3
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 18:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Pq71LUbq98/wlXxXrFSZs9Uk3m1TKV4J7CItRQrdA9s=;
        b=Mm9pSxNYq0TMs1KenT4jKotPkfnoo0lJYbCNVtWRW93Q8Fmcqx/hOgMhy+smDCOLyv
         vmeAdgTz37I7s0Qq9UuB5lAQXAzL1eWNKFXI2QxNjPytwlP3UnxEpdLiF1CPOcIjNHuo
         uyrfA3Ikg1inIf9A11axwPG/fokgwzISR3eBChSqiMHjCVYyQNhHI1LFw19jn+CAeOLS
         bHrh6dDweOjm8VHtAlNt2rjsGTU1b45uh0iV3pCBu/hEDn5g89qBH+YPieRV43cf2Zyz
         c/s2U7RwnhCXEblkyY/GpV+c/4bY+L1B+rHY+APwGuwvjFjXV/aZYhYgCxEws9p22rQl
         uGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Pq71LUbq98/wlXxXrFSZs9Uk3m1TKV4J7CItRQrdA9s=;
        b=cdzxSLb/QDY8+TURo31W7ttnEDNOa3+PW/2Um/uB+mbOZkBW0z2sk1sMRIl9atSdgg
         raRb2dRXMZzkGyJpucYTITAUbz8Pdy33llFhsvOWWQTuB4bqZn6iso7s0WZQlQjxpdca
         G72AzrlQpKEDT9nJF0+6IcwBSpBfeviR4HW1EkmsEOwxPqIE8KREmPA16T0D35qNuVA2
         qda/c/tXM35NYZzLS9anN5TW+x3qqKVxNZq9t3YLC1WFfEVvGMc0ja0icgI5PWtJu1En
         bk5ZEMydMlaeMX44pGXZQd2sRN4zMiHDllEHF62CDRip7nPzCNx3IngD9y2FubDZ4/C9
         KMbg==
X-Gm-Message-State: AIkVDXL8+MwehDzG7ZkxrjASOe1utHPRC4ObEQRbqi/sO9xFKlg+yXK8liEWGTwWoXK+BA==
X-Received: by 10.84.233.132 with SMTP id l4mr30765048plk.15.1486521776247;
        Tue, 07 Feb 2017 18:42:56 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:1564:f4f3:f1b4:c9b2])
        by smtp.gmail.com with ESMTPSA id b67sm14672546pfj.81.2017.02.07.18.42.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 07 Feb 2017 18:42:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Fwd: Possibly nicer pathspec syntax?
References: <CA+55aFyznf1k=iyiQx6KLj3okpid0-HexZWsVkxt7LqCdz+O5A@mail.gmail.com>
        <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com>
        <alpine.LFD.2.20.1702071739060.17609@i7.lan>
Date:   Tue, 07 Feb 2017 18:42:54 -0800
In-Reply-To: <alpine.LFD.2.20.1702071739060.17609@i7.lan> (Linus Torvalds's
        message of "Tue, 7 Feb 2017 17:48:26 -0800 (PST)")
Message-ID: <xmqqefz9xv0x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So here's an RFC patch, and I'm quoting the above part of my thinking 
> because it's what the patch does, but it turns out that it's probably not 
> what we want, and I suspect the "." behavior (as opposed to "no filtering 
> at all") is actually better.
> ...
>
> Comments?

 1. I think some commands limit their operands to cwd and some work
    on the whole tree when given no pathspec.  I think the "no
    positive?  then let's give you everything except these you
    excluded" should base the definition of "everything" to that.
    IOW, "cd t && git grep -e foo" shows everything in t/ directory,
    so the default you would add would be "." for "grep"; "cd t &&
    git diff HEAD~100 HEAD" would show everything, so you would give
    ":(top)." for "diff".

 2. I am not sure what ctype.c change is about.  Care to elaborate?

 3. I think our recent trend is to wean ourselves away from "an
    empty element in pathspec means all paths match", and I think we
    even have accepted a patch to emit a warning.  Doesn't the
    warning trigger for the new code below?

> -	if (nr_exclude == n)
> -		die(_("There is nothing to exclude from by :(exclude) patterns.\n"
> -		      "Perhaps you forgot to add either ':/' or '.' ?"));
> -
> +	/*
> +	 * If everything is an exclude pattern, add one positive pattern
> +	 * that matches everyting. We allocated an extra one for this.
> +	 */
> +	if (nr_exclude == n) {
> +		init_pathspec_item(item + n, 0, "", 0, "");
> +		pathspec->nr++;
> +	}
>  
>  	if (pathspec->magic & PATHSPEC_MAXDEPTH) {
>  		if (flags & PATHSPEC_KEEP_ORDER)
