Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 807CB1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 22:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeJKFuY (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:50:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36539 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKFuY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:50:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so7300864wmf.1
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 15:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=68fjZjzgLqlHm7KntaNwo3JeSC7HhtZjKzOX/Edz3L8=;
        b=FmlmkVkT/3+rqvirH/Gf8DMHBnsRjhleqrn9rXKRuT32Q4PBRHN4kSxPpoQcTGRx10
         2P6LQdPQAiBLCEZPnX3lw7Kd39N/1js2hfJWwbHkp4i4UyyncExhPNTjU99V6eAf692c
         rXEmu/qqKEGEXxC+tzs/DaZTv4vc7zxWnLD4E9jvtHMqewpT5+h3+gBo5I0ySuxDmAeH
         +YICShjpRAwh7LM2j1VYv6yg75EjUb8D4wreoszLL8+BsLuHnXNpsoYsAshZ8cCZUFcc
         t8AY/J0g+aIoOe2AT2eqmZz8Yzi5cRKKBPES7vMJKi/z5wyTxqGaSkze4osj7QlEP7bE
         65Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=68fjZjzgLqlHm7KntaNwo3JeSC7HhtZjKzOX/Edz3L8=;
        b=IxsZm2nveNbcfUA/SUK0PrRgduR7fEm7hGwJKN2MbkX5+5KcwC8+RKocABuK8ipgwP
         M8xm+65J0ZSv1WWreNnsGI4lcEh0AtYSBydyXhnGLtNxEDLC92g9BPucSgTCErdfPKkE
         w6WLFiX2P6XY1t+0lOWZQ4F3RUthbGSamPRisjFsEd5xt0vPDKFBw7CK5QUAaMR8YHsk
         yYJQp6F9DkFjoDrmAfMU/X+YLX8ZEYgP7n9t1weLDnqcJYMBklMZkhMz0OXlSD+zQnFz
         spswUYnSasjYc+TjS0tFrNNE6miWfoZi4gS5ZG1bbCu1Z9/Pzvp5EGxn49ejQ9EYS4+c
         hvpQ==
X-Gm-Message-State: ABuFfogRVDqHVesQ0LkN29oln9nl97eXIYx9FmCXnwjzVM2z3dwvXLDg
        RUXkm9zeXBn9lZm/vI9eLsI=
X-Google-Smtp-Source: ACcGV63rhLqeCYqkAwdL5p7tOEGXmTbU8S4acQAMIKEuHD9nKIV+lrByqtdPrxGJ2D3jGfKAMpznTg==
X-Received: by 2002:a1c:924d:: with SMTP id u74-v6mr2480838wmd.105.1539210371467;
        Wed, 10 Oct 2018 15:26:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m143-v6sm17006378wmd.29.2018.10.10.15.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 15:26:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniels Umanovskis <daniels@umanovskis.se>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: move git-rev-parse from porcelain to plumbing
References: <20181010213726.26111-1-daniels@umanovskis.se>
Date:   Thu, 11 Oct 2018 07:26:10 +0900
In-Reply-To: <20181010213726.26111-1-daniels@umanovskis.se> (Daniels
        Umanovskis's message of "Wed, 10 Oct 2018 23:37:26 +0200")
Message-ID: <xmqqy3b5jv5p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniels Umanovskis <daniels@umanovskis.se> writes:

> git-rev-parse mostly seems like plumbing, and is more usd in
> scripts than in regular use. Online it's often mentioned as
> a plumbing command. Nonetheless it's listed under porcelain
> interrogators in `man git`. It seems appropriate to formally
> move git-rev-parse to plumbing interrogators.

Correct.  "ancillary" category ended up with full of Porcelain, it
seems, but there still are plumbing commands there, and this is a
prime example that should not be mixed up with Porcelain commands.

Among the remaining ones in the list, cherry and get-tar-commit-id
are probably better classified as plumbing.  I do not know why
cherry is marked for completion; perhaps some crazy people use that
on the command line?
