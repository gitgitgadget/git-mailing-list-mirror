Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C72620194
	for <e@80x24.org>; Tue, 19 Jul 2016 22:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbcGSWBr (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 18:01:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36720 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbcGSWBq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 18:01:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id x83so4286789wma.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 15:01:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+CN+JObBFLrKIuFoUSbZmkFOCLygphuOx+1ptEB9Enk=;
        b=oEwLD0wPXg5i2OBU09/JQOEi1JhTEyzY48qtV+i/SsBU0ww3Th3aReZQYxcMVztdP8
         hnsIQEZl13YhcyLKo54z4T6jft40SHCwxZpWt0A3CELAXScmylEOXL4CnbgbvV0sMprN
         rATcr+nbvSVstAd4UhvE8/xZ1sS4VRDJS7Ep1lNUR5t/zdt3IFPPA6kp6faQ0oYQhXxf
         bgT+NmPa+qY2lQqCFP9EMv3VM2BGfdxVf+hR4daSXOL+OnLhXcMUha5aR4Gm4AeLotX1
         hDTAIOxHkO13X73sULloErTGUEY8wqC7W/2gNqC6+F4uBFlVU6iPJIFlmYkodDoy4hem
         70eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+CN+JObBFLrKIuFoUSbZmkFOCLygphuOx+1ptEB9Enk=;
        b=ghgUubWFzymOF5h7QynYmEE+zhRBZiIRAC44n29+3z0FoGj2o5pflCO/8RC7sYO0Ea
         IT+Wl+S1kiJ7VZtZNqoLgghy9I9Q/PwOVV7TpbVg7NRnbY0Q6lwZVSA3sc5A2e+O1uT2
         etI1sSvZPYjbyE3zYn3gn9h7xQZk+CtI9wUfYM767xjEi3YCI6ROVlw25ay6sTMLHE4N
         5KN//LqU+6Yrqwq60STg6DSO+2TuQBjKD4292shRqQe5ZZAAT1WN7CKOXRg6W9xrP8bK
         bN6Kgsb5u4r1eSe7gI5NZhSkG3ONrPbKIEVuZDIw6XmM8zyaaD7OaCE8MN9DfQrKy3zd
         JZdA==
X-Gm-Message-State: ALyK8tIycohJAxCyxvl4b5N9zerkpsqkXM2B4p9mIwiJEtRRrh8Cu0laBAVE1dzspFcSFg==
X-Received: by 10.28.226.85 with SMTP id z82mr7398156wmg.101.1468965704566;
        Tue, 19 Jul 2016 15:01:44 -0700 (PDT)
Received: from slxbook3.fritz.box (p508BA0C8.dip0.t-ipconnect.de. [80.139.160.200])
        by smtp.gmail.com with ESMTPSA id f187sm41734wmf.15.2016.07.19.15.01.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jul 2016 15:01:43 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: Looking for help to understand external filter driver code
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqr3ape2ju.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 20 Jul 2016 00:01:40 +0200
Cc:	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
Content-Transfer-Encoding: 7bit
Message-Id: <BDD74384-AA02-4B60-A246-504B4C6DDF02@gmail.com>
References: <67D9AC88-550E-4549-9AFD-2401B70B363B@gmail.com> <xmqqbn1th5qn.fsf@gitster.mtv.corp.google.com> <xmqqlh0xfoho.fsf@gitster.mtv.corp.google.com> <7B44C694-7CB2-411D-9CC6-7334CCBAD20B@gmail.com> <xmqqr3ape2ju.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.1878.6)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


On 19 Jul 2016, at 23:33, Junio C Hamano <gitster@pobox.com> wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> Git writes --> 4 byte filename length
>> Git writes --> filename string
> 
> Why limit to 32GB?  Perhaps NUL termination is more appropriate
> here?
OK, I will use NUL termination for the filename. 
You're also right about the limit - I will use 8 byte to encode the 
content length.


>> Git writes --> 4 byte content length
>> Git writes --> content string
>> Git reads <-- 4 byte filtered content length
>> Git reads <-- filtered content
> 
> Do you really need to force the sender to know the length in
> advance?  Together with the sequential nature of the above exchange,
> i.e. the filter is forbidden from producing even a single byte of
> its output before reading everything Git feeds it, you are making it
> impossible to use filters that perform streaming conversion.
That is correct. However, for my particular use case streaming
conversion wouldn't be useful anyways:
https://github.com/github/git-lfs/pull/1382


> Of course, with the "sequential" thing, you do not have to worry
> about deadlocking hence no need for poll/select, but I am not sure
> that is a good thing.
Thanks for the confirmation. I consider to exchange a "filter protocol 
version" right after the filter process has started. That way someone 
could add a more evolved "filter driver protocol" later on that supports 
streaming and the external filter could pick whatever protocol is most
appropriate (and supported). Could that be an acceptable compromise
to get a serious review of the "sequential" thing?

Thanks,
Lars


