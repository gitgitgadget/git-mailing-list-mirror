Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91D621FAFC
	for <e@80x24.org>; Sun,  5 Feb 2017 07:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbdBEHoZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 02:44:25 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33661 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751735AbdBEHoY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 02:44:24 -0500
Received: by mail-pg0-f68.google.com with SMTP id 194so6090667pgd.0
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 23:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xjBBLXzDAdUuWyp6X0NUP+nQAkyyH7MjrOhJvmrz7q8=;
        b=B//7nvBmf9sIlOts/M8kNgWQJn6vRtoxjiVqYlVrutwtk7mAMQoScuHiV2x/EnfZME
         bbalFs+7Hkm7SynNJazVS7+qGLXTsFxjmrptSpn42yDTy4VGIOcW4wUwGWZq5BUFWNuJ
         JvFcwnRTnrTqoPk/PNF/U1g9hORIhJniC/WZETumOSI26mq9J59MyhH3XOVxvGOSnVG1
         W5OCkIl+PQKLllkUfg79yL7v7i2469e8lrF1rBSbNoQpybEUPurFQsSdsKslAz2bkeap
         TQHCvgSXianGfGIuwUH2S4/VvRpZh7BLkgZztuIl5DAfC1rYbuXOMX6kOhH9/W8d2c9Q
         eKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xjBBLXzDAdUuWyp6X0NUP+nQAkyyH7MjrOhJvmrz7q8=;
        b=o01RSbE3I8UdcdJKEMJqeTbGV8BBR09rRGw9BL73pk3TJfBzPN5gDtVN7xHnzc/19c
         qkVkkc4UqB2NUzNNFEEUe+TXR9RqX9eUlbG3Ph8qcPHeVlcIJqhL8xsOuK8CY/19cmT7
         NlaTUj0CDWcqP9LRVj9zU/991DaMehlvhCK32aQPHthgMOxFId4Li6FXJF4epNmzqrAX
         vyjzsZ2TsLCawe/eEIqNa3P1YIHdhalom3wh+2ph7WpKVgaTPYYQcqvsUM4a7KO3TYUr
         u7CgQ7gGLVcUCAWz+thaU7PW4SB2YfCjF0Ua3/FOKH9Tdx9JySL37/lODBMQOEaweV7T
         tTrQ==
X-Gm-Message-State: AIkVDXL642VXTmH1iBlaSaSpeiuOYquA0UJnBpoS0y8ce7yBPLKYurBUplXxJmELS3JOBg==
X-Received: by 10.84.176.1 with SMTP id u1mr8584255plb.71.1486280657466;
        Sat, 04 Feb 2017 23:44:17 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7d32:3ca2:6708:4960])
        by smtp.gmail.com with ESMTPSA id o18sm80250763pgn.36.2017.02.04.23.44.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 04 Feb 2017 23:44:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Zenaan Harkness <zen@freedbms.net>
Cc:     git <git@vger.kernel.org>
Subject: Re: release notes/ change number discrepancy ? - Documentation/RelNotes/2.10.0.txt "merge b738396..."
References: <20170205022156.GA19612@x220-a02>
Date:   Sat, 04 Feb 2017 23:44:14 -0800
In-Reply-To: <20170205022156.GA19612@x220-a02> (Zenaan Harkness's message of
        "Sun, 5 Feb 2017 13:21:56 +1100")
Message-ID: <xmqqvasp3wvl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zenaan Harkness <zen@freedbms.net> writes:

> Am I missing something in the following:
>
> looking at Documentation/RelNotes/2.10.0.txt I see the following release
> note (~line 35):
>
>  * "upload-pack" allows a custom "git pack-objects" replacement when
>    responding to "fetch/clone" via the uploadpack.packObjectsHook.
>    (merge b738396 jk/upload-pack-hook later to maint).
>
>
> but when I run git show b738396 , I get the following:
>
> commit b738396cfdcc276c0cde0c1a6462c5cc74ba7b76
> Author: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date:   Thu Jul 14 15:58:59 2016 +0200
>
>     mingw: fix regression in t1308-config-set
>
> which seems to be completely unrelated. What am I missing please?

I think the commit is an "oops, we found a regression on a different
platform than the one used when developing the series after its
development completed, and here is a fix on top" commit that is
queued as the tip of a series.  You shouldn't be using "git show" on
it to look ONLY the tip of the series.

Let me show a better way to ask Git what you want to know, with the
excellent "git when-merged" script (google for it).

$ git when-merged b738396 master
refs/heads/master                      75676c8c8b6cbeec7ccb68d97c17db230d9f2659

We merged that commit to 'master' at 75676c8c8.  What does the merge
log say?

$ git show 75676c8c
commit 75676c8c8b6cbeec7ccb68d97c17db230d9f2659
Merge: 79ed43c28f b738396cfd
Author: Junio C Hamano <gitster@pobox.com>
Date:   Thu Jul 14 10:38:57 2016 -0700

    Merge branch 'jk/upload-pack-hook'

    A hot-fix to make a test working in mingw again.

    * jk/upload-pack-hook:
      mingw: fix regression in t1308-config-set

OK, so it was a hot-fix that consists of a single commit.  What did
we need to hot-fix?  A hot-fix is typically queued as a direct
follow-up to what is needed to be fixed.  When did we merge the
parent of the fix?

$ git when-merged b738396^ master
refs/heads/master                      1e4bf907890e094f1c1c8c5086387e7d5fdb0655

And that merge commit on 'master' shows us the series that needed to
be fixed up.

$ git show 1e4bf907890
commit 1e4bf907890e094f1c1c8c5086387e7d5fdb0655
Merge: 7a738b40f6 20b20a22f8
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Jul 6 13:38:11 2016 -0700

    Merge branch 'jk/upload-pack-hook'

    "upload-pack" allows a custom "git pack-objects" replacement when
    responding to "fetch/clone" via the uploadpack.packObjectsHook.

    * jk/upload-pack-hook:
      upload-pack: provide a hook for running pack-objects
      t1308: do not get fooled by symbolic links to the source tree
      config: add a notion of "scope"
      config: return configset value for current_config_ functions
      config: set up config_source for command-line config
      git_config_parse_parameter: refactor cleanup code
      git_config_with_options: drop "found" counting

You learned from the above that the jk/upload-pack-hook topic was
developed as a 7-patch series, reviewed, tested and got merged to
'master' on Jul 6th.  Unfortunately a test in the series had a
portability issue that wasn't discovered while it was being reviewed
and tested, and a hot-fix was queued on top and merged to 'master'
about a week later.  If we wanted to merge the topic to the
maintenance track, we cannot just merge the original 7-patch series.
We need to merge the whole thing, including the 8th one that is the
hot-fix.
