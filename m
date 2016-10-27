Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531B520193
	for <e@80x24.org>; Thu, 27 Oct 2016 20:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942157AbcJ0U2b (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 16:28:31 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38306 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936148AbcJ0U2a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 16:28:30 -0400
Received: by mail-wm0-f46.google.com with SMTP id n67so72295639wme.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 13:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pelly-co.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Pi1MXdUcBtJeILCOPi0VBlNLXKrB01xyGoiJAr2tUMs=;
        b=ZFOvKwfDU8/N/C8oSZn3OPjINX9nrOZ7EQ3brzlVcrs5RjYrsCr0ui7GAgz6fWmiqH
         0XoAyDUYlc8wtyFcHcJ4O5L0Re2qE9Em2FL3f7eS1/Gl8XLFFZjeQdSjhqtxQuzbIMxo
         q6AVR21NK/2H8TVSfdJRKdburqdtAQ3uazzDcNZUQdBwFOhzRPmgqN+FCHf6EJ3O4QTa
         m3n32ooLREv2thWQ88n7dwqppZKtUZPr0NjzjTP/99u0GvIZ3nr2nPGULcS5GYd6Ctfn
         mQs5MyxD2QptuYBB+4B9QUHALX2faokkp1Dwasv7OYyUtTqKVeql/1MQeo2OqIa0XhU7
         E6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Pi1MXdUcBtJeILCOPi0VBlNLXKrB01xyGoiJAr2tUMs=;
        b=V1eUnOkbSqYTC2j/E01pZkumS5XAg8bvq7SNqft0Y8/fmpuOP+DxT7UVEh/XsPDWMG
         xIRThweJXPKfAm/zCKg9XWLAqowmYtWlqfmCTYmeQKpGqZ3Km+SjcnKaI8HMc/wMdqZx
         O+p4rcOROQfPv+YiXrz8NW7JTy4ajBoBt5UfO+a47Xt4IkNFZdvNqI1iE9CqHHiLGCl1
         GgSLQtdpO53f2b4vObQ25tugV8FsXl4AfU3EIy1OxOG6R6+mQNehlMCw+ZLp4YEIVm9W
         adLRaJc9X2sf0SAZ5n518u/PvbgpRnTgtmVB6CWu5UQhTPR0fK6tYqnyaKrvWTFGlS3u
         7eyQ==
X-Gm-Message-State: ABUngvez8yr8UttfgQpBr4iaSsLRJHAiCI74zcAPli10JZBG4VswhYT+5FhQgyY0Fu96VA==
X-Received: by 10.28.212.17 with SMTP id l17mr197061wmg.64.1477600108353;
        Thu, 27 Oct 2016 13:28:28 -0700 (PDT)
Received: from [10.3.1.6] ([49.50.252.82])
        by smtp.googlemail.com with ESMTPSA id l19sm5177650wmg.5.2016.10.27.13.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Oct 2016 13:28:27 -0700 (PDT)
Subject: Re: Expanding Includes in .gitignore
To:     Jeff King <peff@peff.net>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
 <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Aaron Pelly <aaron@pelly.co>
Message-ID: <b20b458c-440d-df09-d2c7-e510ac20492c@pelly.co>
Date:   Fri, 28 Oct 2016 09:28:23 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/10/16 23:50, Jeff King wrote:
> I'd shy away from an actual include directive, as it raises a lot of
> complications:

I'm leaning that way now too.

>   - we parse possibly-hostile .gitignore files from cloned repositories.
>     What happens when I include ask to include /etc/passwd? Probably
>     nothing, but there are setups where it might matter (e.g., something
>     like Travis that auto-builds untrusted repositories, and you could
>     potentially leak the contents of files via error messages). It's
>     nice to avoid the issue entirely.

I understand the issue.

It's not obvious to me how using a .d solves this problem though.

>   - finding a backwards-compatible syntax

using .d directories solves this nicely in my opinion

> Whereas letting any of the user- or repo-level exclude files be a
> directory, and simply reading all of the files inside, seems simple and
> obvious.

Apart from backwards compatibility, unless there's something I'm missing.

> If you go that route, it probably makes sense to teach
> gitattributes the same trick.

Understood. I'll keep that in mind.

>> In the case of a directory the plan would be to add links to files
>> stored/sourced elsewhere. This does pose a precedence question which I
>> haven't thought about yet, but probably makes it too hard for the
>> limited value it brings.
> 
> I think the normal behavior in such "foo.d" directory is to just sort
> the contents lexically and read them in order, as if they were all
> concatenated together, and with no recursion. I.e., behave "as if" the
> user had run "cat $dir/*".
> 
> That lets you handle precedence via the filenames (or symlink names).

That was my thinking at first, but I didn't want to bias the discussion.

> It
> can't handle all cases (some items in "00foo" want precedence over "01bar"
> and vice versa), but I don't think there's an easy solution. That's a
> good sign that one or more of the files should be broken up.

I've been burned by this myself by packages interfering with each other
in /etc/sysctl.d

Could we put this down to caveat emptor? I think this sorting should be
intuitive to most people these days, and simple to document and comprehend.



