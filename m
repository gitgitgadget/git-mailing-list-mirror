From: Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Nov 2015, #02; Fri, 6)
Date: Wed, 11 Nov 2015 10:59:26 -0800
Message-ID: <CAGZ79kaK==GhD4nUTh4nnd_NPTNsUG15kS61hAhmP=K6MdHmYg@mail.gmail.com>
References: <xmqq4mgy3dcr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 11 19:59:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwacG-0001yC-6w
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 19:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbbKKS72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 13:59:28 -0500
Received: from mail-yk0-f172.google.com ([209.85.160.172]:34865 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbbKKS71 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 13:59:27 -0500
Received: by ykba77 with SMTP id a77so64389065ykb.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 10:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=+28iKXZcjb7u7q9UJMNWabR90FzCIPRkw3wMQEkPO54=;
        b=ibTMJFGEhHCpb/6+feyBEgzT0e+2fL7y0agDVPmJotIqz2fhukA9HwaxAzNVe9OY3S
         q76aR9g06IRWIIUfDOvdyWAu4zGMLSCKtVVj1Y/WS8e+kbiGrnjH5SL03H6wMtyn5Vlz
         MIHYO+UCSYXuzBg8qObcSTmcqqLj+aI9+bjTlMI+mbRMCtxmUQwR4ie2v8A6k/8ULoqg
         vBtjCkMj9kQs0zSNaJvXb9yXixEQ5dO3lIF5sT34t44BkZ98QcYjdnAFx1oEvm0ydY/W
         M9hEQwLEO3sRjmOHQhZ/FThlPIMKsnBO4G/TN/xCDjgFjn3U4jmNM/DKDJ0Kf5fRCFcI
         IH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=+28iKXZcjb7u7q9UJMNWabR90FzCIPRkw3wMQEkPO54=;
        b=ImDQyzHcTK4G81hLwJ48x2FT/vCQe2QXaN/Gw/a9LvmaL6Xq3vjOXNFL02aDDRxH0v
         81KoG4uhQORdsRO8Bwk+19/OwFynD6JzfvXXvAPCFuHQDxyHoPkLyiGkTE2fpcrn0qwE
         XYZIND8GTe3zKPpVf4gVZU49UQ5CnE2oM4UR2AcchsF5dDCySIbSdkgQwyaNM7Fklsid
         vYjx8FHsGmTjNpU6Fb9kUPLC3YpPrNqq/MWBqox/iuQeB9nB671YJT0HlHD/6uV4O9CX
         Nm7N/ltsOe0bOXqaPtvVgz80HxY1JHDqkaWleVSBxRndkcqHcqqJLanr97T42pYd+P+A
         wfeg==
X-Gm-Message-State: ALoCoQnHSEa4/pMffMU1uMbnQnbqtCXtESUoB+dwXnCWmQ7hCkEcE5P0kL7QfrNwynPuludtRqFH
X-Received: by 10.13.251.2 with SMTP id l2mr11643852ywf.44.1447268366292; Wed,
 11 Nov 2015 10:59:26 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 11 Nov 2015 10:59:26 -0800 (PST)
In-Reply-To: <xmqq4mgy3dcr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281176>

On Fri, Nov 6, 2015 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I'll be offline for a few weeks, and Jeff King graciously agreed to
> help shepherd the project forward in the meantime as an interim
> maintainer.  Please be gentle.
>

Jeff,
gently asking where I can find our interims maintainers tree. :)

> * sb/submodule-parallel-update (2015-11-05) 10 commits
>  - clone: allow an explicit argument for parallel submodule clones
>  - submodule update: expose parallelism to the user
>  - git submodule update: have a dedicated helper for cloning
>  - fetching submodules: respect `submodule.jobs` config option
>  - submodule config: update parse_config()
>  - submodule config: remove name_and_item_from_var
>  - submodule config: keep update strategy around
>  - run_processes_parallel: add output to tracing messages
>  - Merge branch 'rs/daemon-plug-child-leak' into sb/submodule-parallel-update
>  - Merge branch 'sb/submodule-parallel-fetch' into sb/submodule-parallel-update
>  (this branch uses sb/submodule-parallel-fetch.)
>
>  Builds on top of the "fetch --recurse-submodules" work to introduce
>  parallel downloading into multiple submodules for "submodule update".
>
>  Waiting for sb/submodule-parallel-fetch to stabilize.
>
>  It would be the cleanest to rebuild sb/submodule-parallel-fetch on
>  top of 2.7.0 once it ships and then build this directly on top;
>  that way, we do not have to have merges in this topic that
>  distracting (besides, some part of the other topic can be updated
>  in-place instead of this follow-up topic tweaking them as past
>  mistakes and inflexibilities).

Ok I can do that. I am stalling on  sb/submodule-parallel-update
until we all agree on  sb/submodule-parallel-fetch being solid.

>
> * sb/submodule-parallel-fetch (2015-11-05) 16 commits
>  - strbuf: update documentation for strbuf_read_once()
>  - run-command: remove set_nonblocking()
>   (merged to 'next' on 2015-10-23 at 8f04bbd)
>  + run-command: fix missing output from late callbacks
>  + test-run-command: increase test coverage
>  + test-run-command: test for gracefully aborting
>  + run-command: initialize the shutdown flag
>  + run-command: clear leftover state from child_process structure
>  + run-command: fix early shutdown
>   (merged to 'next' on 2015-10-15 at df63590)
>  + submodules: allow parallel fetching, add tests and documentation
>  + fetch_populated_submodules: use new parallel job processing
>  + run-command: add an asynchronous parallel child processor
>  + sigchain: add command to pop all common signals
>  + strbuf: add strbuf_read_once to read without blocking
>  + xread_nonblock: add functionality to read from fds without blocking
>  + xread: poll on non blocking fds
>  + submodule.c: write "Fetching submodule <foo>" to stderr
>  (this branch is used by sb/submodule-parallel-update.)
>
>  Add a framework to spawn a group of processes in parallel, and use
>  it to run "git fetch --recurse-submodules" in parallel.
>
>  Still being worked on, but it seems that we are seeing light at the
>  end of the tunnel.
>  ($gmane/280937)
>

 ($gmane/280937) is represented by
  - strbuf: update documentation for strbuf_read_once()
  - run-command: remove set_nonblocking()

So IMHO we're solid as required for  sb/submodule-parallel-update.

I am not sure if the rebuild on top of 2.7.0 expects a complete new
series which doesn't even mention O_NONBLOCK (squashing some
patches or reordering them), or if we want to keep the history around,
such it is easier to follow the development in the future if some bugs
show up.
