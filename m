Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B942E1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 17:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbeIDVxd (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 17:53:33 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:34018 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeIDVxd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 17:53:33 -0400
Received: by mail-wr1-f50.google.com with SMTP id g33-v6so4843865wrd.1
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 10:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WOwecirR4TfR28iWe+F8NXFRnreG+kWkKjM2enOpUxY=;
        b=d4i1V2EL2XPlPFnlmPkIEENUsX8jqDmrK+GwCJ3VpL18pAQ71uTMXJlAu4CUmIFczR
         p5yv15qTt9dtnSST1+YtRtIYtACfUxMtbWYGaWXYBvZz08cQ+LN+TyzYH/Tz6hd2OLxj
         0ApWnj/xUwfTpxi+LqDZf44gy8uGATwIFf+Vhu1ncnIUp1g3x/QcctgvLLA0JY5H8Rig
         9+0W4yPZPxihAoh4AozTdt1uxxpH78gHSZxiQ/iPTWrjc9YLqo4g11chwmSDDb1cCFV9
         ElAHnhs196XQCV7ovx7/SpESNiSeO3OC6cH6+d2JNnP1aIQe3hMGrvZ/Qz9rynSj3pZD
         nK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WOwecirR4TfR28iWe+F8NXFRnreG+kWkKjM2enOpUxY=;
        b=rqKSGa+379ByCCgWfN63jZs8E+uToHR2dYxFZk4jRe8ye1XgaKmWUVlRi+8N/b2Nz1
         CIw+gihzZyepUIKR3lprK4HEZIuelZxY/wF2IA+kxKECBtJjhcKh2ziKDcAszfVFfTuZ
         8649Rv4xIrWfk/0xr10HhuiIFK8TZMW5yWqKkIgADCB3JCBEA1KgdRgwnxv6QRUUkfVy
         bCR3RVDIwJlLGVKn0CV8OpETSYplLwfcUCp9jkY5+aNyYUolTDsPKnMG67CrJriQufl8
         Fu8207egVaWheG4GdtzdsTmcSCYVcPB+BnTWNcNGQBCOQ+6/yRR7OnJrOWNg3h6Ob6pD
         BOsA==
X-Gm-Message-State: APzg51CrYtzDANYavMLEduqqYnbFvm7nQMTg0+J3V5hI5HVLtw4n5Egs
        SrPPgry1HsbHA9eQL6sLsSM=
X-Google-Smtp-Source: ANB0VdaX6igHBD8+YcrROuHd9XrFPG5HhrWHVqDrJG4uny2+tm773lx5wzMSzLBR98psw1sqC9sZ4A==
X-Received: by 2002:adf:eb87:: with SMTP id t7-v6mr23784271wrn.123.1536082048109;
        Tue, 04 Sep 2018 10:27:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h17-v6sm21176078wrq.73.2018.09.04.10.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 10:27:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: test files with same names?
References: <CACsJy8B1UDN26tWPvOtixSBiFF6bYP2BtK2n1u4W-tWdVeKK1A@mail.gmail.com>
Date:   Tue, 04 Sep 2018 10:27:26 -0700
In-Reply-To: <CACsJy8B1UDN26tWPvOtixSBiFF6bYP2BtK2n1u4W-tWdVeKK1A@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 3 Sep 2018 20:16:00 +0200")
Message-ID: <xmqqwos19nr5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> t2000-checkout-cache-clash.sh
> t2001-checkout-cache-clash.sh

These date back to 368f99d5 ("[PATCH 2/2] The core GIT tests: recent
additions and fixes.", 2005-05-13) which later were renamed by
f50c9f76 ("Rename some test scripts and describe the naming
convention", 2005-05-15).  One was about checking out a regular file
to a path where a directory currently sits, and the other is about
checking out a regular file that requires a parent directory at a
path where a regular file currently occupies.  These days, I suspect
that we would make these into a single "d/f conflict when checking
files out" test script, and f50c9f76 might have been a good chance
to do such a clean-up.  If somebody cares deeply enough, I do not
mind seeing a belated clean-up, either.

> t7500-commit.sh
> t7501-commit.sh
> t7502-commit.sh
> t7509-commit.sh

These seem to have organically grown and it is very likely that ones
later introduced were added more from laziness.

If somebody wants to clean them up, probably the first thing to do
is to study them to come up with a clear $test_description for each
of them.  I think t7509 says --reset-author and it may have started
as a test on that single feature, but it now covers other ways to
set and/or preserve authorship information, so it may make sense to
update its $test_description to "commit authorship" or something,
for example.

