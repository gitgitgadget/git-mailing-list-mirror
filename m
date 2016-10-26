Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78FDE2022A
	for <e@80x24.org>; Wed, 26 Oct 2016 21:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933497AbcJZVEX (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 17:04:23 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33870 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbcJZVEX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 17:04:23 -0400
Received: by mail-qt0-f176.google.com with SMTP id q7so10222337qtq.1
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 14:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xnltOiqixOxDpLC4Y53W0lSnyOBmfTMPXaa+OUAzx/o=;
        b=X7Sgbc1zXTiRhqeotZqGA4Tr3SXyOoqHJ5LGbyyXit7rw0Ee59IIJoVuZjfLujr6/w
         EMoZ9r0VcqcxHszloMBcaZEicbBq4kW5KZruW0qPeNTtfhISDQD7dnaQyXNCfPg88t6G
         wjJug+DwuVDGzK206KQkFNF2GVqngL4KgQ8Th40n/cYCaoJ+D8173y4bPQS3E8EO5+YF
         OkT74s5lgAhvmwIqxsTp0eAvuyAc7NV6kOPyvEIU5jEt0ghN6DGBwTM+xbmi5VOZ0FfM
         +6XFGyB2Xgpqz0AoP9TsOYusN/MKvw2Hu72G/stz909YtBcMMugIKyvAq5H1yr7WqxFc
         uhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xnltOiqixOxDpLC4Y53W0lSnyOBmfTMPXaa+OUAzx/o=;
        b=Pujpux1JVUZbqDVdjdWKu18b+DYQTj9TZvldTE6sT3Gc7D9jrbDitqsioWSN5d5G7J
         170t6xk8cRp1EfSaH9+hesiNbPUAiyH0bOYQckzaV+iXinxSASoSB6d5Qd5VTG1sD4rs
         2CBaLJEcX3qcfbmqNhgyvtnylf7+YZNInVNgXM5meNG3c29dRLCDZIcQ6qOvXHTTgIS3
         6Zl38S9zwCFopKZgD9b/B2yOCFlKs9nR+/BObd/e6Hc5Z3NziC7pvejI+Akz1uCk9Y0I
         7kSyK5iwknqgRrAmp+L8stbRqTQYWcXyaa2GJOwuc8runH+jUE7oAEX9XYTcYgUL309c
         1Qew==
X-Gm-Message-State: ABUngvdM1eNmL0bltPiBzbL0nJeHUn93ToNfeXEU9Rye71Pae0SudIIJsE5HSy4CQYd/yetBZmEnC8YXFK7a0Frn
X-Received: by 10.237.33.225 with SMTP id m30mr3469792qtc.61.1477515861974;
 Wed, 26 Oct 2016 14:04:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 26 Oct 2016 14:04:21 -0700 (PDT)
In-Reply-To: <nur45i$e9b$1@blaine.gmane.org>
References: <nur45i$e9b$1@blaine.gmane.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Oct 2016 14:04:21 -0700
Message-ID: <CAGZ79kYb8D+RRNqwJ4iHrdBFMvJCt4xhY_A0HFhhxZRCKSsZcg@mail.gmail.com>
Subject: Re: git-archive and submodules
To:     Anatoly Borodin <anatoly.borodin@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 1:37 PM, Anatoly Borodin
<anatoly.borodin@gmail.com> wrote:
> are there plans to add submodules support to git-archive?

plans by whom?

Git is a project with contributors from all over the place. (different
time zones,
people motivated by different means, i.e. we have the hobbiest that
scratches their
itch, we have paid people working on Git because their employer wants
them to work on Git,
there are other people (who like to) use Git in their work environment
and hack on it
in their spare time to make it awesome.)

AFAICT there are currently not a lot of people actively working on
submodule features,
though there is some history, e.g. Jens Lehmann maintains a wiki
specialised on submodules
https://github.com/jlehmann/git-submod-enhancements/wiki
and archive is mentioned there as one of the many "Issues still to be tackled".

Maybe you want to give it a try as you need it? I'd be happy to review any
submodule related code.

How to get started:

 * git clone https://github.com/git/git
 * Read (at least skim) Documentation/SubmittingPatches)
 * Look at builtin/archive.c as a starting point (cmd_archive is called
    when you call "git archive ...")
 * That leads to archive.c:write_archive, which calls parse_archive_args
  There we'd want to add an option there for recursing into submodules.
 * See write_archive_entry (still in archive.c) that mentions S_ISGITLINK
   Somewhere there you need to add code. :)

Thanks,
Stefan
