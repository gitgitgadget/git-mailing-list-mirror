Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77FC20986
	for <e@80x24.org>; Wed, 19 Oct 2016 23:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbcJSXBf (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 19:01:35 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35721 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbcJSXBe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 19:01:34 -0400
Received: by mail-pf0-f182.google.com with SMTP id s8so23515623pfj.2
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 16:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5VXOYNzmBtW4e1jEKxZMatazOpC5hTgftK75O96hTcM=;
        b=IoWc3s3aN7BfHaPmCjGkjJQyy+H+0EV1B8WT5J3T7QNwsMJ2JlCabnfjnLd7X//0TP
         vr0KBVkFNocQ9SJKTIxIPZ199SPhB6KV6uSY2wQpZ+fKL4Cx3XIQEhkqF6Qu3r1y8116
         9qFX0blgmgheE2AaxWNDeCSopyXMVuhRF0yj9hQh32xelaXb+AF0ilXC8Izxc+ysCEzi
         UF6dSmaGwYsL4WiKWUzhQHLch96xeMVr79BCGUWbxp/4gb/U3FrGtYVHl5V9E4PQzsr/
         zXHGutrsv425yjSwdc2yQHgyUMbmJ6DDnztJOyVDStDbhdg606AfnV+q5RB4VUb8BtUk
         hlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5VXOYNzmBtW4e1jEKxZMatazOpC5hTgftK75O96hTcM=;
        b=GvmbGRl23q9R+hhCclse8yOJ/d2tcFguZ5ray+eT0jVhnasy4RyBCgiqC9xITESpEp
         GYRx7RAaCI8hSokMqpUQKRGPvcn7m0AElKss0y5efP3bOq7+vkxk50t2ssk5RqXbJsYJ
         ccdLjixJzJQ4z2xHiqfIqNcIgFdBUaJcqjul8O6PD388cOuQ7n50PTcBw7BoRLmloeGB
         Rd7Ffai++IfFRcrU4o+ERUoH8lq8bmD+wvTqNbu0Z6zpkBiAbc5NasJ3U09OKGRGIvuJ
         FUreV1dPiC0hWNSBykZkRSDSLNbwXq4aa+nxDEYgFCLfw0khq+MgTm+GV54AeB5VsDDD
         Qazw==
X-Gm-Message-State: AA6/9RknsUMrvHBKViwLVyiCCIxc1XTiDYDX8V9jl5kurKCQucbuZ+SBRREPOT9T6wcomZ/9
X-Received: by 10.99.53.75 with SMTP id c72mr12715162pga.168.1476918093051;
        Wed, 19 Oct 2016 16:01:33 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:31f6:4f01:d7c9:6ee3])
        by smtp.gmail.com with ESMTPSA id yu9sm6939099pab.15.2016.10.19.16.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Oct 2016 16:01:32 -0700 (PDT)
Date:   Wed, 19 Oct 2016 16:01:30 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] submodules: update documentaion for submodule branches
Message-ID: <20161019230130.GA21768@google.com>
References: <20161019204254.97659-1-bmwill@google.com>
 <xmqqmvi0j9rv.fsf@gitster.mtv.corp.google.com>
 <xmqqzim0hsdz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzim0hsdz.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/19, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Brandon Williams <bmwill@google.com> writes:
> >
> >> Update the documentaion for the the special value `.` to indicate that
> >> it signifies that the tracking branch in the submodule should be the
> >> same as the current branch in the superproject.
> >
> > Thanks.  Will typofix while extending with info supplied by Stefan
> > like so:
> 
> Ugh.  Should have proof-read before sending it out.
> 
> >     4d7bc52b17 ("submodule update: allow '.' for branch value",
> >     2016-08-03) adopted from Gerrit a feature to set "." as a special
> >     value of "submodule.<name>.branch" in .gitmodules file to indicate
> >     that it signifies that the tracking branch in the submodule should
> >     be the same as the current branch in the superproject.
> 
>     ... in .gitmodules file to indicate that the tracking branch in
>     the submodule should be ...
> 
> "to indicate that it signifies that" was overly redundant.

Sorry that seems to have stemed from my poor commit message.

-- 
Brandon Williams
