Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37EA3203E2
	for <e@80x24.org>; Sun, 24 Jul 2016 11:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbcGXLYb (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 07:24:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36171 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbcGXLYa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 07:24:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id x83so12520197wma.3
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 04:24:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NW9tnXum44gCfwVE7gAMsdoT7S0tIIx7ojGoWOynSZo=;
        b=eG2V2QAnBCWKV3ZttREaIBdwyurGjcDxmJP/FafEhh1x2GCymknnDyCsntaNRUHOxn
         RzFVCUyyfGyLldgQiNMlOwXH4uGOmr4oOtQSSzc/m7Zix9KrkKouk3Zj/T+ozzaSn3L3
         3OuRmxYOYBH0nz54Ov6mAv17CGSZInvj2lUewrftPC2aeEqdVj8bIvaMpgOqmt54B/pA
         iwDlqsro7hufogHZO8dg9tTbUMtnBxFpJ5bwqUDlpiXKdHRtwrXiCull9EFjBeTHEozj
         mPXc7Oso8+DNC0zEFN62pbCjpsQlkU/qHbIuaoRcWQ8/Q8QYgXzKNq+3daWuQbiDAX1t
         maTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NW9tnXum44gCfwVE7gAMsdoT7S0tIIx7ojGoWOynSZo=;
        b=Jtd2kCCdK3iCfsFXwbJmQvRFldKp5C0n8iCtNz5YPvmG0GOyXU6Kk5wAsO/KmQ7BvF
         Fz87c+yUvA6co2fvbDSMwm7m1bu49+LzZEsnCIgt0kgo9XkPD5R8TD83IaXKbCafVY0/
         M41LJP+ogNQMuInK9mc4MRnhIFl2FrlcUptExBcu4NxxV4dZnKvqcrujoiqr/YUg7xRj
         CWTKUFNjtkKnxfwVcnk/gkXXjKvC/SPRHE45E9rX2RkRY0MinAT6WdPbnh8lMq8UoRqc
         JWpRF8QBsBS566WPQ/iDJbF+QXgDQhYnKsAoOtIS6Xqw6mnSZbRaB5ccWBApLT9IkQ96
         zyNQ==
X-Gm-Message-State: AEkooutx3oEFqp+nlXjc7xQdmnl3U1UOi49tmm683L7tPfeiDbE+ygYH5soflpEoJUr5fw==
X-Received: by 10.194.235.229 with SMTP id up5mr11352357wjc.69.1469359468396;
        Sun, 24 Jul 2016 04:24:28 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB5F1D.dip0.t-ipconnect.de. [93.219.95.29])
        by smtp.gmail.com with ESMTPSA id hy3sm10260347wjb.8.2016.07.24.04.24.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jul 2016 04:24:27 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v1 0/3] Git filter protocol
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqshv18i8i.fsf@gitster.mtv.corp.google.com>
Date:	Sun, 24 Jul 2016 13:24:29 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	jnareb@gmail.com,
	=?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	peartben@gmail.com, mlbright@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <7DABD0C7-8838-4FEC-B6E5-36F82E521312@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <xmqqshv18i8i.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.1878.6)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


On 22 Jul 2016, at 23:39, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
> 
>> The first two patches are cleanup patches which are not really necessary
>> for the feature.
> 
> These two looked trivially good.
Thanks!


> I think I can agree with what 3/3 wants to do in principle, but
> 
> * "protocol" is not quite the right word.  The current way to
>   interact with clean and smudge filters can be considered using a
>   different "protocol", that conveys the data and the options via
>   the command line and pipe.  The most distinguishing feature that
>   differentiates the old way and the new style this change allows
>   is that it allows you to have a single instance of the process
>   running that can be reused?
I agree that the name is not ideal. When I started working on the
featured I called it "streaming" but then I read your comment in
$gmane/299863 and realized that this would be a misleading name.
Afterwards I called it "persistent"/"long running" but then I thought 
this term could trick people into thinking that this is some kind of 
daemon. Somehow I want to convey that the filter is persistent for 
one Git invocation only.

What if we would keep the config option "protocol" and make it an "int"? 
Undefined or version "1" would describe the existing clean/smudge 
protocol via command line and pipe. Version "2" would be the new protocol?


> * I am not sure what's the pros-and-cons in forcing people writing
>   a single program that can do both cleaning and smudging.  You
>   cannot have only "smudge" side that uses the long-running process
>   while "clean" side that runs single-shot invocation with this
>   design, which I'd imagine would be a downside.  If you are going
>   to use a long-running process interface for both sides, this
>   design allows you to do it with fewer number of processes, which
>   may be an upside.
We could define the protocol for clean and smudge individually. However,
if you have implemented the more complicated long-running protocol already
for one filter, then you could reuse the code for the other filter, too, as
this protocol is, as far as I can see, always more efficient (assuming you 
have source code access to both filters). Another argument could be that we 
don't define the "required" flag for the filters individually either.


> * The way the serialized access to these long-running processes
>   work in 3/3 would make it harder or impossible to later
>   parallelize conversion?  I am imagining a far future where we
>   would run "git checkout ." using (say) two threads, one
>   responsible for active_cache[0..active_nr/2] and the other
>   responsible for the remainder.
I hope this future is not too far away :-) 
However, I don't think that would be a problem as we could start the
long-running process once for each checkout thread, no?


Thank you,
Lars
