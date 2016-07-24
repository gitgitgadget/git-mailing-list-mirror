Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F9C203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 19:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbcGXT5y (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 15:57:54 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35947 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbcGXT5x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 15:57:53 -0400
Received: by mail-pa0-f44.google.com with SMTP id pp5so54165224pac.3
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 12:57:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=79/QeS+djHwCN9RjEknQnS9BvDAq5GHyQk3MUB8ti5A=;
        b=NFTz9LB7z54H8p3i2Znr6Sy+U9vnu4UAt1f2pOdXlXob9CQZCFTbUT5bolPWLmqTf9
         NOrJQ2I9ycTsL+VYg4hqVzNNQMzWn8+pljZ2+FWRQgYYkwa4CK3RE5Z++MgxJj2g2dRQ
         9QfRlR0+ri33y+alBfCGV03a7ZSlH5l44YXtOPoDkVRxuiPglN5+tGbE36/8r4uq/CBX
         +Atw6MmsUhZeaAIKbil+MENibAvwqFfJRdMs7DcdFUkAzG4Owx5Bn0XlAmW4lO2nCoeM
         ynXlczmOrLmDQzNMUhrZkC7pv4riHf+lKWY8sxmZVGq3E0rzpmcAt3q05b/Kt8M62ZMi
         G1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=79/QeS+djHwCN9RjEknQnS9BvDAq5GHyQk3MUB8ti5A=;
        b=XqNcPiuKvaNXlpNbWNFs+fMZP77VcJf70NfwBPU8QdTZ61aIfUjM5xP6xq+DhfRk/c
         lQBYqgcDrzfNNgDoq5uP2qvl9+NJ3Oz2QzylI6Q/SsHfM2vA78qJGdB+V+11R0ZQWYy7
         95hX6VIGx5+TU0g6JNzP97kWIQ7O6sesn9GxJ1V3yWjMH1/gU6qAKiZXsHxbT4UBFy4H
         Opjl+DRFRIaSfUSxXXrs6arjQApTNY1tD3AQkF5PuVihnHkSNdAx2Rr4kn4/Aqkhkuuh
         /uOAjkvyQ8CO8B/tNH1snjT+KMS4s8sgKB0vQGTbV7LufhrFxkKdhDE0RuGsBfZtMcp0
         oqgg==
X-Gm-Message-State: AEkooutCBC1xFBMHIzwVTQQS5UXEcsG54/pFP/C3BI0po9OnA29+D4R1NiH5sQ0wnxL9GQ==
X-Received: by 10.66.76.132 with SMTP id k4mr23434062paw.22.1469390272681;
        Sun, 24 Jul 2016 12:57:52 -0700 (PDT)
Received: from [192.168.0.109] (c-71-202-183-39.hsd1.ca.comcast.net. [71.202.183.39])
        by smtp.googlemail.com with ESMTPSA id g10sm34398951pfc.57.2016.07.24.12.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2016 12:57:51 -0700 (PDT)
Subject: Re: [RFC] A Change to Commit IDs Too Ridiculous to Consider?
To:	Rodrigo Campos <rodrigo@sdfg.com.ar>
References: <nn30dv$5sn$1@ger.gmane.org> <20160724185132.GN25141@sdfg.com.ar>
Cc:	git@vger.kernel.org
From:	Jon Forrest <nobozo@gmail.com>
Message-ID: <c0af7511-a5d5-29bb-d279-66b6c3e0519c@gmail.com>
Date:	Sun, 24 Jul 2016 12:57:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160724185132.GN25141@sdfg.com.ar>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 7/24/2016 11:51 AM, Rodrigo Campos wrote:
> And what is the problem with that, if you are doing it with instructional
> purposes? Let's assume that this helps and not confuses later when the commits
> *do* change. What is the problem you face?

A lot of instructional material contains stuff like "Do [xxx] and you'll
see [zzz]. If you don't then something went wrong so try to figure out
what happened and do it again."

Git, as it stands, for good reason doesn't allow this approach.

I don't think a Git beginner, when using a version of Git that somehow
works the way I proposed, will be confused. The fact that performing the
same steps results in the same commit IDs won't be something that
they'll care about or even notice. The material can include a callout
mentioning the difference between "real" Git and "learners" Git.

> I mean, for some examples you can use HEAD, HEAD^, HEAD~4, etc. and that always
> works, no matter the commit id.

This will work in some cases, but should come later in a Git book.
But, in many cases using relative commit IDs, rather than absolute,
will be less clear (I believe).

> In which cases do you want/need the commit ids to be equal?
> Can you be more specific?

Sure. Take a look at the 2nd or 3rd chapter of Pro Git Reedited, 2nd
Edition (or just Pro Git 2nd Edition - it doesn't matter). You see
lots of output showing 'git commit' commands and the commit IDs that
result. I suspect you'd see the same in almost any book about Git.

Jon
