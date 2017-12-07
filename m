Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B27920954
	for <e@80x24.org>; Thu,  7 Dec 2017 17:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753841AbdLGRwp (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 12:52:45 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38034 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755576AbdLGPtA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 10:49:00 -0500
Received: by mail-wm0-f53.google.com with SMTP id 64so13654845wme.3
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 07:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sEIkAyWFFUOXxEhAjkQB0hUDh0SqRhJ/O9pEezJ0eq0=;
        b=cHZy1+awlvhy45RMV68gay5yiQtlwAqB559tswbt7yUhFbuziK+ig+KQiKdDvOUE+y
         O8ZmSA1C/4sYAczULXC6g9Ut0tKNGnwx2Yd1lntbOOhUD+uoyA80UgMdKsZgi9f1Kp4n
         NrbYYeBMjwitfIdD+rLrUzWbpKXVPe67asEg1Td82gYER4ZX7vp5TZZ9G/KIjya83bR+
         zUDNZ8zcWXQklhC4Jtr0z0c1n9oFCNhM5tCbsK1dYiQckD6sG9C3C83E2Oo8VxxTuXHw
         dyvxlx/GHTR+sxQsGc/GEJmBRWcqxvN0tNJy0FdsBqMQGHQZXlHPgBS7z032UDGWlzHa
         z5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sEIkAyWFFUOXxEhAjkQB0hUDh0SqRhJ/O9pEezJ0eq0=;
        b=JROLhgP8zc8C+Pv5e3e+hXogwFkIl8cK8OsjElmbDX5t9M4C7pNvZ8YQMyanJq4HFg
         YeTsXVbVodyu1BvkBs+jam2TQ/ae70WT8x0dj/AZzoqlCjdkkiBVg6EjY3H5IU2FgmK8
         X3wwv5M0SFgBABJFmXd8sk1iisO6bKU+OSUJb+3p2z5+YPipNRidGRCNzxb1S3AT9yN9
         SRlRYlswRbKMq3f336O4vSOJ4GKNBJ6UumKnRm6lTqPR0LjB8ucs7GqUjWVvUaDGgMgw
         d6nxoaJi/ci+8g2S+4Z4aHA0lGKroNtVz1vTvwXseFbTrSerBcfP4LLN9rbP+0pIjPCh
         Exyw==
X-Gm-Message-State: AKGB3mIYa8gUJCsb18uDNexO74d5kNgcM+MD0bnIWY3enOdsmlRjJySt
        LcBVrMKZ/6ipL7wVFIp15kg=
X-Google-Smtp-Source: AGs4zMYNGZL9IXNQPV9HTgC+q/78xzgW0yUY5aKUZMerEtB/2LzILnXFRTUjYzVqoU9GVkN1PKolLg==
X-Received: by 10.28.156.208 with SMTP id f199mr1658818wme.27.1512661739485;
        Thu, 07 Dec 2017 07:48:59 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id y78sm5844183wrb.51.2017.12.07.07.48.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Dec 2017 07:48:58 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 2/2] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqr2s6ee7e.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 7 Dec 2017 16:48:57 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>, git@vger.kernel.org,
        sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net
Content-Transfer-Encoding: 7bit
Message-Id: <FCBDBD58-0593-4FFC-B574-61D67CAF13C6@gmail.com>
References: <20171207151641.75065-1-lars.schneider@autodesk.com> <20171207151641.75065-3-lars.schneider@autodesk.com> <xmqqr2s6ee7e.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Dec 2017, at 16:43, Junio C Hamano <gitster@pobox.com> wrote:
> 
> lars.schneider@autodesk.com writes:
> 
>> +		if (print_waiting_for_editor) {
>> +			fprintf(stderr,
>> +				_("hint: Waiting for your editor to close the file... "));
>> +			if (is_terminal_dumb())
>> +				/*
>> +				 * A dumb terminal cannot erase the line later on. Add a
>> +				 * newline to separate the hint from subsequent output.
>> +				 */
>> +				fprintf(stderr, "\n");
>> +			fflush(stderr);
>> +		}
> 
> Was the trailing whitespace at the end of the hint message intended?
> 
> If we expect the editor to spit out additional garbage on the line,
> it would probably help to have that SP,

Argh. I forgot to mention that in the cover letter. Yes, I added
the whitespace intentionally for exactly that reason.


> but if that is why we have it
> there, it probably should be done only when !is_terminal_dumb().

That, of course, is correct. My intention was to make the code simpler
but I can see that people would be confused about the whitespace.

How about this?

			fprintf(stderr,
				_("hint: Waiting for your editor to close the file..."));
			if (is_terminal_dumb())
				/*
				 * A dumb terminal cannot erase the line later on. Add a
				 * newline to separate the hint from subsequent output.
				 */
				fprintf(stderr, "\n")
			else
				fprintf(stderr, " ")

Can you squash that if you like it?

Thanks,
Lars
