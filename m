Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7499B20357
	for <e@80x24.org>; Mon, 10 Jul 2017 17:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932640AbdGJR20 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 13:28:26 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36044 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932484AbdGJR16 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 13:27:58 -0400
Received: by mail-pg0-f50.google.com with SMTP id u62so52729534pgb.3
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 10:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NqWupW3NIGB09E0Vp6BvKoG1Pyv/e5y1/c+0jimIJlQ=;
        b=EXwrC4UllYEhT2iL0ENBWyfRQz00kQdciwxb5rGcyfAFQFr4gWr+OziajUoU95Up2t
         2z9KoLA4pit7jIlmsEI2v6DH0Fd9bfr7sKhKOjM6qnqQQGwTTE2QezH2fOeY8BuU4DgL
         1UU1L88FaLYvqmSRRk2NA3/zRNTFfttSWGcqyVXO+TUaE5C44qvBEKbivY+3T6yik8Gl
         M/4spHpTereCdQY2JXN/WxvKIef22kIf0VwCRbwCrtH90/XbqNH/WhxT/aDJ6KbLBfBQ
         m5GwFrMJweMt2d2mkxUCcjMKHBYYILuP2uIjAoNfTgF7sWLBZcUgcJrnwqNOnvfxOslo
         3DZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NqWupW3NIGB09E0Vp6BvKoG1Pyv/e5y1/c+0jimIJlQ=;
        b=CGTgSYgyf2zjNF0GX8ht74Rjd8bg5tHTI6xut0gUNRUxwDshIVIytrV2SFC1Tul687
         w+dOQu/feZJfLZhH3P66A2Z5zsUcBhZiy7te3TAm5kgtmqQbVWlgi8yEL16wjTzCXdoB
         eJvOMiU6Tes5fKxQs0TGlsknj77ZGij/6L5J4O0iuMbvNGVi3HSeutwM8ulm+16wSBP5
         RyRASKuLOkHT3XZa8P6PZaOjg+whsK4U9br64FG7XF+v33etmkAkQid19wUE8DNduF8D
         lPNktcjOGhL0el9oWquN9/7j2AaRjiAnxVv0TGExeaR4c48gqKkPN9WsM2SEg+qQzpW7
         oaXw==
X-Gm-Message-State: AIVw111hGPk7mbjD04FvXp2NL3UWcA3tbyb3d220Ui1aT/JaW7zBI0+G
        eHxz+KR9QyoGjq1jOHzjPtxkjgHgOiAc
X-Received: by 10.99.44.206 with SMTP id s197mr15769785pgs.116.1499707667374;
 Mon, 10 Jul 2017 10:27:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Mon, 10 Jul 2017 10:27:46 -0700 (PDT)
In-Reply-To: <xmqqbmoxdmea.fsf@gitster.mtv.corp.google.com>
References: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com> <CAGZ79kamhPAQrE3GBC=fG=PNNtdHj7iStsqjOojkVMpNy_VEWw@mail.gmail.com>
 <xmqqbmoxdmea.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Jul 2017 10:27:46 -0700
Message-ID: <CAGZ79kZMC4DcnF-6nT49uZT8NtiWWkKyUm44BHRBPt98idj_Pw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2017, #01; Wed, 5)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 6, 2017 at 7:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Speaking of submodules, It's not just features, but I also send bug fixes. ;)
>> https://public-inbox.org/git/20170630003851.17288-1-sbeller@google.com/
>> (That patch is not related to this series, except for working in the submodule
>> area, but I consider that patch more important than e.g. this series.)
>
> I did not see the patch as fixing a bug, though.
>
> I do agree that overwriting the branch tips in the submodule
> repositories, possibly rewinding and discarding user's work done on
> the local branches, is indeed a problem.  It however is unclear why
> detaching HEAD is a good solution to solve that problem.

I am not saying detaching a HEAD is a good solution, but I am saying
it is a better solution than corrupting the submodule branch, such
that commits are lost in the submodule, only to be recorvered via the
reflog.

> After all, there must have been a reason why the user had checked
> out a branch and had pointed it at a specific commit (presumably,
> so that further work would be done while on the branch, to make it
> easier and safer to eventually push the result back to the upstream
> of the submodule's project).  So another solution that seems equally
> viable, if not even more so, could be to fail the recursive checkout
> saying why the checkout cannot be done, just like we fail a checkout
> when a local change interferes with updating the contents in the
> working tree and the index with an error message explaining which
> paths are problematic.

That seems like a better model to me for now.

> I am *not* saying which one among the above two is better; I am not
> even saying that there could be only these two possible solutions.
> I just found the posted patch unsatisfactory because it did not make
> it clear why the chosen solution is a good one.

ok. My long term plan is to introduce another type of symbolic ref,
which references a gitlink in another repository, such that the submodule
can have a clear distinction between "follows the superproject",
"has its own authoritative branch" and "its detached HEAD can mean
anything, e.g. historical submodule behavior"

> Perhaps I misread the description; but that would mean the
> description was prone to be misread and has room for improvement ;-)

ok.
