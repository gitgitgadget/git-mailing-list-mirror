Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F27420365
	for <e@80x24.org>; Wed,  4 Oct 2017 17:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbdJDRBX (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 13:01:23 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:44849 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbdJDRBW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 13:01:22 -0400
Received: by mail-pg0-f49.google.com with SMTP id b1so5310292pge.1
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 10:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1JM62ymxRZioGQ8uLarZ8hWGV4+FK4DV0HFCOWUEVv0=;
        b=YNKlWPM+Ion3elPHiXWDKWEOHZQIFe0QQM2udGhWmp1MNVd7X7DyjzGAwM9Nd3fkqT
         iMMx1Vf6vXl1/OP4hHpp+CqIBqtHBxlO9sIdFszk5q0s/xbKDxfdnhiosuk+m3pGMxyJ
         31e9/qA8Ta6Mb/28kVurzdGOcXaKUkMnaJncnZJLshzYIqyGKE2lyFNRz7nOdT6SS+Jf
         10OH2e91/ThRayjLy0Z+717MyMTi/pmrA52yM2txPRqsxczobRoeyfmeqG/jqnkppBWa
         +jfw28g9IghZe5b1pJJmrYxJqftdVqD1cD0dy9qCYL1d8ZXOTYe/f0QcO+uK4iIES7Xw
         khDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1JM62ymxRZioGQ8uLarZ8hWGV4+FK4DV0HFCOWUEVv0=;
        b=adCcnJwxUXm8S5QsrRIXpprBtwc4AE3HOZ3wF/u/1Z0YQvtWx3LhSLax3+Ob7WYh9h
         x0zqVH7kGdmMC8u5Qb46Q3ubg10B9Oq8t0HB8WiMTKkK23YXazW8b+CzMXR0lk+iqVfz
         ZYmZiD/wvVVRvt1fBYW5E3wf02H/FLqbqd/lZliLCpaMX6whc0wnT1W6xA8TXXiJ0dPl
         nPL4gdQSmlOOSJQKlxXWuPL5t7zlJjkEOPgZdK1cyRLT4zNddtHO4zeFLN8N6VDkHbtv
         DoPatxO3m9SKerRokbE5MMDoU3okJjP9NfWu/YuhyuhBucbTUP8HCjLJOjAQ6FfxspZp
         /t+g==
X-Gm-Message-State: AHPjjUgnnwJQmpvCzEYiljFwJBqcRUChn2P9dQmpwlC1lbRXrLRV6ktk
        87eznJqWye8JB1EcmckV4bs=
X-Google-Smtp-Source: AOwi7QB/xLu6kgjO7Mm33yC8YyScsxyVE0Gmw7tVKTYpkpLR+r5fqvv0lp3+Ds4KXgUX8kWGgx0uGg==
X-Received: by 10.84.130.35 with SMTP id 32mr20125352plc.368.1507136481965;
        Wed, 04 Oct 2017 10:01:21 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:e14c:b8fa:a887:14e1])
        by smtp.gmail.com with ESMTPSA id s76sm28229297pfj.119.2017.10.04.10.01.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 Oct 2017 10:01:21 -0700 (PDT)
Date:   Wed, 4 Oct 2017 10:01:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ernesto Alfonso <erjoalgo@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: disable interactive prompting
Message-ID: <20171004170119.GO19555@aiede.mtv.corp.google.com>
References: <87tvzehp13.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvzehp13.fsf@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ernesto,

Ernesto Alfonso wrote:

> Waiting for git-push synchronously slows me down, so I have a bash
> alias/function to do this in the background. But when my origin is https, I
> get an undesired interactive prompt. I've tried to disable by
> redirecting stdin:
>
> git push ${REMOTE} ${BRANCH} &>/dev/null </dev/null
>
> but I still get an interactive prompt.
>
> Is there a way to either
>
> 1. disable interactive prompting
> 2. programmatically determine whether a git command (or at least a git
> push) would interactively prompt

You left out an important detail: what does the interactive prompt in
question say?

The general question is also interesting, but seeing the particular
prompt would make it easy to look into the specific case at the same
time.

Thanks,
Jonathan
