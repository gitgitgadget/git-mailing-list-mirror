Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B169E1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 12:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbfJOMGd (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 08:06:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39026 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfJOMGd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 08:06:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so23556792wrj.6
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 05:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iXFaGoMP3uJvDjRmqMy2OpXtZ4WY2d2TVm8ojdrYaZE=;
        b=AxAPoFd8K/TKEcmmAbYpoA5VbNOS9ToXnL5vqv/6xw2eYLiDdwSnPlkayGQQ8EhR6A
         maLxo4mFHviKeoq0vRddElhvjCdOshC7Brn7DXL4UyCJZ0moIZlH/gUygirIbtV87ASg
         fYEwSbpz0MZ/rRipDQoTNLS7alVdMFQBCHwhynz5lqfVhAw7fwPJiv7R9ZmnO6QhshvZ
         l2x0OiugCZVTROlkNw/iJLk095Ng3J8iy15HKhwnxgpeP5DLe+pl85We1xWwog1ob7cn
         4ReAIEMWQ9UAgNqRuNwe6YzEikqBce5g+FWf1sKGjJ5bEwKaCLTNwb/U53HTxe4MCSOz
         C7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iXFaGoMP3uJvDjRmqMy2OpXtZ4WY2d2TVm8ojdrYaZE=;
        b=mviYCFNCuLGX8EKldqo3qzGKVWPob8nwEx9cnUbgK1HDxNqCf3zbyokJ45+NPc3T8X
         roWNMUDvk0Yww23vM5IrLcH1z/tkG9JoWntLZZa94pQu4XBp0NrRHFbmRJw+SjGTLRMP
         8eMV4brGXZRyJiB6bDQ+ZGI51S3Q83zNtU634IgU8nd9Wd1Ex26+KMAoTpGx7e/F36J1
         2XiYjKvjnx/EuLTj/Ngtut7TPaeBGqlpzbYwSIaUpcfJK9K805J9OsVZp+903D2HLS/k
         VaQIUCxC90aczy4Acglq76YxwpLtcFmXNp3yebxzjmzeMndFFPEB8kFD2A/ASj2BpilB
         1bCg==
X-Gm-Message-State: APjAAAW+GIBHt3CWa+bTL+Bckz+mao3rDq30sPAjZcnZ5Klt6jUOmiMG
        rHIbuho7s0ethdXqegVGuU0=
X-Google-Smtp-Source: APXvYqwwvAWOaWyUJOlUWyMnyedHDxaYXr7e0WF8gtGXL65phfXmjoTfQTrritdcKdzq8DTkaMd0Wg==
X-Received: by 2002:adf:ec84:: with SMTP id z4mr30365755wrn.254.1571141191053;
        Tue, 15 Oct 2019 05:06:31 -0700 (PDT)
Received: from wambui ([197.254.95.158])
        by smtp.gmail.com with ESMTPSA id q66sm26623590wme.39.2019.10.15.05.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 05:06:30 -0700 (PDT)
Date:   Tue, 15 Oct 2019 15:06:26 +0300
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [Outreachy] [PATCH] blame: Convert pickaxe_blame defined
 constants to enums
Message-ID: <20191015120626.GA21821@wambui>
Reply-To: 20191014214629.134882-1-jonathantanmy@google.com
References: <20191014193734.GA13706@wambui>
 <20191014214629.134882-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014214629.134882-1-jonathantanmy@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 14, 2019 at 02:46:29PM -0700, Jonathan Tan wrote:
> > > Well, I agree that it could be better, but with the C language as we
> > > have it now, I still slightly prefer an enum to a list of #define. Both
> > > ways, we still have to manually enter values for each flag, but with
> > > enum, we get better debugger display (at least in gdb) and in the
> > > function declaration and definition, we can put a specific type (instead
> > > of "unsigned" or "int"). gdb supports the notion that a few people use
> > > enums this way too, but if we decide as a project to not use enums in
> > > this way, that's fine too. For what it's worth, I tried doing a search
> > > online, but most of the results I got was for C# (where it is
> > > recommended - they have a "[Flags]" attribute for enums), so maybe I am
> > > indeed in the minority.
> > 
> > I'll try to pick another set of constants to convert - before this is
> > agreed on.
> 
> Thanks - perhaps that's the best way to proceed for now. Do you remember
> where you found the idea to convert #define to enum? Maybe I could add a
> note there to avoid converting bitsets/bitflags.

I found it in a mailing list thread[1], but seems that a comment on bit
field values was added to a similar issue on GitGitGadget[2].

[1] https://public-inbox.org/git/20190923180649.GA2886@szeder.dev/
[2] https://github.com/gitgitgadget/git/issues/357

