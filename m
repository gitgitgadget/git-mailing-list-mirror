Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46B561F462
	for <e@80x24.org>; Mon, 20 May 2019 20:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfETUit (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 16:38:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39568 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfETUit (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 16:38:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id g9so7243574plm.6
        for <git@vger.kernel.org>; Mon, 20 May 2019 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kpPcRD8+P46UuyNogW4r491cyoUyyCXqxf8VeGh0NPs=;
        b=t1O0HLG6atruIiZ7sgWF+aTJWkaEGdqj8NIaHUi6kYzbkscPns8vNs/WFPI3anq3sk
         JzBwEDcaOCMcxG5rJHjkCkq7ap8Ab7IFTPCkqb7O7cl6AFx0nKrgopYTifesdn57DpPW
         dGDSRDbmEYmlS3McdLcahf+tluo8Tp+dFIrvs/IutnJ2qB5XjUB3tHQr9KUwPaApXZhP
         Z4O39SzL8Wx8ieO6Tlt8A515Ozj5QFWweWYLC4F5GDRn/EJWv+VcobR8RGHXcmZxmHUB
         4poR3QSxDF7ev67lUniXpAu2lYdHElAcc5hnOvIXvGceJfJESTqGenYRbgAfiMao/CK+
         dIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kpPcRD8+P46UuyNogW4r491cyoUyyCXqxf8VeGh0NPs=;
        b=cinwP1aJvV90q54LrTE2B3ZhJI1VS//EwxZDflrHdFNZ/Uz/u9npDKpdAPjVOpmHAe
         W6voP0YFW4+PAn0wgvuzl4AtJzIJL/Fx2d8i1h3O+Ego0lyZuCN+F2SOFpnDUQ3PiCjG
         Q1312zhZP6QZ1/tsoIcf2Yx+bvosSeRu2Xy3fS14lpWGb57eRiqMLrprnbnVIo6q5h1+
         XCuZidSbZnUOYuJ8uTNowkP7BH8FzAgy2MfBOyFiWC57oMlXNHShgF+AtlAy9yKpOZJ4
         EPEhtzrTzJ5W06Ag3TBo6x10yfGcvlAWRFVDY4gKKX8hp7/d658UyWoykuziLzR7TQPo
         R1hQ==
X-Gm-Message-State: APjAAAXesVOVtKfDdZoJTxPA2KvVMrGdavKCy0XX8H8qI6zstBgQfV1N
        69qKqar9PF6KGUDb5fAA4HZfrQgUb9slEA==
X-Google-Smtp-Source: APXvYqyaCGxSs0q6xfRa3uJ/imN6TRf0OLGmtjWeYp11Qg3Uru5h+6vRtiU5uohD7meojZGmLtRPMg==
X-Received: by 2002:a17:902:e30b:: with SMTP id cg11mr77318008plb.3.1558384728322;
        Mon, 20 May 2019 13:38:48 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id 135sm34242399pfb.97.2019.05.20.13.38.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 13:38:47 -0700 (PDT)
Date:   Mon, 20 May 2019 13:38:43 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] doc: hint about GIT_DEBUGGER
Message-ID: <20190520203843.GA64994@google.com>
References: <20190517204826.45308-1-emilyshaffer@google.com>
 <CABPp-BHZkQG+pr4MmVGahHDR56grqvRsYNxZ=uShK70APzj9LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHZkQG+pr4MmVGahHDR56grqvRsYNxZ=uShK70APzj9LA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[snip]

> > + - You can launch gdb around your program using the shorthand GIT_DEBUGGER.
> > +   Run `GIT_DEBUGGER=1 ./bin-wrappers/git foo` to simply use gdb as is, or
> > +   run `GIT_DEBUGGER=debugger-binary some-args ./bin-wrappers/git foo` to
> 
> Missing some quotes around debugger-binary and some-args:
> +   run `GIT_DEBUGGER="debugger-binary some-args" ./bin-wrappers/git foo` to
> 
> Also, one thing I always wonder about with command documentation like
> this is whether people will understand that "debugger-binary",
> "some-args", and "foo" are just placeholders rather than literal text
> -- and that everything else is literal text and not meant to be
> placeholders.  Does it make since to include a couple examples, or
> perhaps modify the text somehow to avoid confusion between
> placeholders and literals, or maybe just tell me I overthinking this?
> (I've been bit by similar problems in other contexts, so I'm just
> flagging it for you to consider).

It's a good point. I like to use placeholders that don't sound like a
real command (and failed a little here), for example,
`GIT_DEBUGGER=my-cool-debugger some-various-args`. It can be a challenge
to choose a placeholder that sounds fake but also doesn't sound too
informal (the above feels informal to me). I think the best way is to
show an example, that's a good idea. I'll come up with one and send
another round this week.

Thanks a bunch for having a look.

 - Emily

> 
> Elijah
