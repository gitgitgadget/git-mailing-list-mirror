Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5760420D11
	for <e@80x24.org>; Fri,  2 Jun 2017 01:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbdFBBpl (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 21:45:41 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34476 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdFBBpk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 21:45:40 -0400
Received: by mail-pf0-f193.google.com with SMTP id w69so10167424pfk.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 18:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aMM9CSOlzusRQQ4py+9aylzRMCsfttdwA5utiwk5xy0=;
        b=NzAYnZgq6WNzJ2TRZ7h4zyEry6NQTzSie9mhYVnJEjq1vSNmp88BsUnDW+bUCovWUt
         xPwfifBw9FCxKC7GRtY/YKUDQq6DKVBGL5lat0NywGqo6+SDFUCyL1BeVw5iVi1kcg/R
         nhYRxoYRFRUanz6/uaqntUVvmfddhTSiZ6/H8yYx9Q1WmoBJzljxaP2EyzWlJgwiDQJ3
         l+RQyoHxA7y/t8IQl5HELcSCOY47mBVdzn2KXWERF+mANSUUYRSh+NPvbOWj+l9kCmI/
         AoZ4M8VheDJpXxL6azLILi60o39wujxxKYVlcWLeRfcFOWyo0gCtIwQN4x5/bfw3jxNH
         d5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aMM9CSOlzusRQQ4py+9aylzRMCsfttdwA5utiwk5xy0=;
        b=CtqvXb301pt2I+gpAPUnuVAfBZIwnXoB36wdivpRU+nxNlUq3TAf+4aACNbU0rvy3W
         QFw41ocADV9FH7G8lYWmq1y2AddK49Bb8AQshQHvTnOmVxGTHWTKrYmY4dgAcKRp3pMS
         UUAIcF0PwW2BtCuFwZrK6TZKxgP6PPCczBXbF2y2/8oIgKMXM8Le5ctr660+vGX0pjOd
         E+A7NvDiSW+nj0ZxHFGHjXborshZFcVp9S3xR82MCHMrVEbccFPD+6NnQC7hENNOR9j7
         Fa6lyraKTKER14Isxn7jVYgwpxiLykAmTwH2bfQwN8aiwOm1busi4xAf02PC/FvU8zNU
         ENIQ==
X-Gm-Message-State: AODbwcCBsmxbixnlX1puUtHrqa69XwYMZTAAFmfjJfWd6dP5RXQ/+b5C
        yMtjMVFs3sP+7g==
X-Received: by 10.99.126.67 with SMTP id o3mr4251419pgn.36.1496367939656;
        Thu, 01 Jun 2017 18:45:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id n71sm36030164pfg.46.2017.06.01.18.45.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 18:45:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
Subject: Re: [PATCH v2] docs: fix formatting and grammar
References: <20170601095520.GA25777@dinwoodie.org>
        <20170601103703.12216-1-adam@dinwoodie.org>
        <20170601155311.urqaxmjagqgiogmh@sigill.intra.peff.net>
Date:   Fri, 02 Jun 2017 10:45:38 +0900
In-Reply-To: <20170601155311.urqaxmjagqgiogmh@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 1 Jun 2017 11:53:12 -0400")
Message-ID: <xmqqr2z317st.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jun 01, 2017 at 11:37:03AM +0100, Adam Dinwoodie wrote:
>
>> When compiling the documentation, asciidoc thinks a backtick surrounded
>> by whitespace shouldn't be interpreted as marking the start or end of a
>> literal.  In most cases, that's useful behaviour, but in the git-pull
>> documentation it means asciidoc is failing to correctly detect which
>> text should be monospaced and which shouldn't.
>> 
>> To avoid this, remove the extraneous spaces from the text to be
>> monospaced.  It would also be possible to fix the formatting by
>> switching to asciidoc's ++ monospace format markers and still have the
>> space characters included in the monospace text, but the spaces aren't
>> necessary and not having them keeps the markup simpler.
>> 
>> Also include a minor grammar fix suggested by Jeff while we're changing
>> these lines.
>> 
>> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
>> Helped-by: Jeff King <peff@peff.net>
>> ---
>>  Documentation/git-pull.txt | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> This looks fine, although...
>
>>  In order to determine what URL to use to fetch from, the value
>>  of the configuration `remote.<origin>.url` is consulted
>> -and if there is not any such variable, the value on `URL: ` line
>> +and if there is not any such variable, the value on the `URL:` line
>>  in `$GIT_DIR/remotes/<origin>` file is used.
>
> ...I should have read to the end of the sentence. It should also be "in
> the `$GIT_DIR/remotes/<origin>` file". Or just drop "file".

There is another one nearby.  Here is what I understand as your
suggestion (the "just drop" variant), which I'll queue as SQUASH???
on top of Adam's patch.

Thanks.

 Documentation/git-pull.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 1d90dd17bd..e414185f5a 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -160,14 +160,14 @@ present while on branch `<name>`, that value is used instead of
 In order to determine what URL to use to fetch from, the value
 of the configuration `remote.<origin>.url` is consulted
 and if there is not any such variable, the value on the `URL:` line
-in `$GIT_DIR/remotes/<origin>` file is used.
+in `$GIT_DIR/remotes/<origin>` is used.
 
 In order to determine what remote branches to fetch (and
 optionally store in the remote-tracking branches) when the command is
 run without any refspec parameters on the command line, values
 of the configuration variable `remote.<origin>.fetch` are
 consulted, and if there aren't any, `$GIT_DIR/remotes/<origin>`
-file is consulted and its `Pull:` lines are used.
+is consulted and its `Pull:` lines are used.
 In addition to the refspec formats described in the OPTIONS
 section, you can have a globbing refspec that looks like this:
 
