Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C857420986
	for <e@80x24.org>; Thu, 29 Sep 2016 11:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbcI2LAM (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 07:00:12 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32928 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750700AbcI2LAK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 07:00:10 -0400
Received: by mail-pf0-f196.google.com with SMTP id q2so3453969pfj.0
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 04:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id
         :content-transfer-encoding:mime-version:date:cc;
        bh=Q3Ulazua7eb3O7Lmjyt9xvjBcFNIe4/FO+TVh2nXJ+Y=;
        b=kgFVByh0msXEQnfBFsCkZwLrnxuGuBSz6+doTe6cEvDNpX1vLAckBX+US4H8GwJArw
         IArQX1YY2g7XBahjTnBRbf31tg+Mv+YLZ+gRtUDwTQuwGT1s7JLZFu8SDlV54TWh2r0M
         PfQkV6ZNAWY5+mogqGNtlBmajbziW2TBUgB1hjPMQ358OJY9BKa6EceJ7wr2IKAmOm/9
         uEz/zZ3kdZpT8aIms7jxAWN6+1cM4sJS+DDb3nuXTJtzET3lfYGoQf2SVm8mwbiYVXBG
         UObS6uzjj5++GyMx/Ul0xuy6kiJxH8HbGS54qakG8+gLErJ1+97UpbpPCvFS4jJX2CkN
         mO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:in-reply-to:subject:references
         :message-id:content-transfer-encoding:mime-version:date:cc;
        bh=Q3Ulazua7eb3O7Lmjyt9xvjBcFNIe4/FO+TVh2nXJ+Y=;
        b=NdUj9joo4GJkeKzZYiphTFk+jg2xzAf5UmJI8jbooLdvqdrMPtDWIEw4YIUsJYAHCm
         ozj2EPzaX3YDJRb6/ZE7OGj6auOMp2RI5umZpUDy2tE0HFiZtyNHxjLojrYYnP8tKx8r
         EaUWrlYqPOGcZTFJvkcc2yR/jlf8vaSWC4X5JG0+sUqFmicMXq2n8FCrNcl/eoxEdMmH
         P2McNZLMQ9oVBnNzANBHeJKQ25k2dm4gJ621E43iuswXTgGIlciADEccWZOJE1FQFhhB
         J4rIxJdz9EwP9mMvVPAiRQG4AZhMHJKlW/r53USVqZfcqkV53HYh6MBJcFV2d2fRBvsb
         NypQ==
X-Gm-Message-State: AA6/9RkHahCV7qk9LYkeQzwD8nZYaU79bgGyNNzLNI5apI0Yy6+p/r3DW42b8Dgg/BLUPg==
X-Received: by 10.98.194.133 with SMTP id w5mr1363196pfk.42.1475146809249;
        Thu, 29 Sep 2016 04:00:09 -0700 (PDT)
Received: from ?IPv6:2002:46b5:ad14::223:12ff:fe05:eebd? ([2002:46b5:ad14:0:223:12ff:fe05:eebd])
        by smtp.gmail.com with ESMTPSA id y2sm19356018pan.31.2016.09.29.04.00.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 29 Sep 2016 04:00:08 -0700 (PDT)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Jeff King <peff@peff.net>
In-Reply-To: <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
Subject: Re: [PATCH/RFC] git log --oneline alternative with dates, times and initials
References: <git-log-times@mackyle-at-gmail-com> <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
Message-Id: <82EE6519-E58F-4382-87A5-55D9D1BBDCA9@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date:   Thu, 29 Sep 2016 04:00:06 -0700
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sep 29, 2016, at 01:33, Jeff King wrote:

> On Wed, Sep 28, 2016 at 10:34:51PM -0700, Kyle J. McKay wrote:
>
>> git log-times --graph --date-order --decorate --no-merges -n 5 v2.5.3
>>
>>    === 2015-09-17 ===
>>  * ee6ad5f4 12:16 jch (tag: v2.5.3) Git 2.5.3
>>    === 2015-09-09 ===
>>  * b9d66899 14:22 js  am --skip/--abort: merge HEAD/ORIG_HEAD tree  
>> into index
>>  |   === 2015-09-04 ===
>>  | * 27ea6f85 10:46 jch (tag: v2.5.2) Git 2.5.2
>>  * 74b67638 10:36 jch (tag: v2.4.9) Git 2.4.9
>>                       ..........
>>  * ecad27cf 10:32 jch (tag: v2.3.9) Git 2.3.9
>
> I was surprised to see this as a separate script, but it is true  
> that we
> cannot quite pull it off with --format. I think we are very close,
> though.  With the patches below I think you can do:
>
>  git log \
>    --commit-header='%C(auto,bold blue)== %as ==%C(auto,reset)'
>    --format='%C(auto)%h %C(auto,green)%ad %C(auto,red)%aS/%cS%C(auto) 
> %d%C(auto,reset) %s' \
>    --graph --no-merges --author-date-order --date=format:%H:%M
>
> and get the same (or very similar) output.
>
>  [1/5]: pretty: allow formatting DATE_SHORT
>  [2/5]: pretty: allow formatting names as initials
>  [3/5]: graph: fix extra spaces in graph_padding_line
>  [4/5]: graph: helper functions for printing commit header
>  [5/5]: log: add --commit-header option
>
> Each of those commits[1] needs some minor polish, and as I'm not  
> really
> that interested in fancy log output myself, I don't plan on working on
> them further. I was mostly curious just how close we were. But if  
> you'd
> like to pursue it, feel free to use them as a starting point.

Those patches are missing some of the features like showing root  
commits, handling two letter initials, showing the weekday, inserting  
a break where needed to avoid parent-child confusion in graph output  
and properly handling Duy's initials. :)

I suppose if all the objects that output a date took a '(' <strftime>  
')' option that would get you part of the way -- it could replace  
DATE_SHORT with DATE_STRFTIME.

Also the above example doesn't handle marks properly in graph mode.   
Yes, you can add the "%m" format option but it does something odd and  
the script fixes it up.

On the other hand, git-log-times started out as a script for something  
else (a shell script actually) and just got embellished further and  
turned into a perl script for speed.

Your patches are a good first start though but reading the --graph  
code gives me headaches and I figured it would be like going down a  
rabbit hole to make the code support everything the script does.

The script also has one big advantage.  It works with the version of  
Git everybody already has installed.  :)

And nobody is ever going to want to type several lines of arcane  
formatting instructions to get the output.  ;_)

It would need a new option, perhaps --oneline-extended or something.

The patches are a good start but that doesn't help anyone using Git  
today which is why git-log-times is submitted as a contrib script --  
much like the way diff-highlight is still a contrib script and not  
supported directly by Git either.

--Kyle

