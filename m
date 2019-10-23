Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB35E1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 07:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbfJWHWN (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 03:22:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42855 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731524AbfJWHWN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 03:22:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id s20so8933241edq.9
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 00:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMdA3rZMbp1D3LZsht6ndj6AX2Awa34IDWpnpPT0fP4=;
        b=oLQDtR3cpT9SNxX3h+fMFtEjgKn/iZMfmzemFDkTzKHeXkkINtqtC8Kbt87VZOJ3Jj
         7vazHtgiLcA8/3wu3E7osmUnAh41XHP2HqxIyZGdo1LHlF2bpgt5m71NQ1JP0R8+A/mT
         BTiu5fncl2z6A6vUNHmftctfjt1lpG1au9qfDMiRnBHnjCS49xO/N4hqr/1/0HpXpHNZ
         tMcJ6IB4xNXLDdgzPdZ4LM56zm7Pn61G7cRnHFfZ89aOqED5+cMEvoF+ieJlb5Szlz2B
         PzrTNrI8ZNcgPxpNg2oQeY7VyvL0Mk9Dzz1+1pD1+h9TOvhK5tsE8SH+1NCHkzwkJJB6
         3/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMdA3rZMbp1D3LZsht6ndj6AX2Awa34IDWpnpPT0fP4=;
        b=X5GZfdqZvmGkhjzVjdP8CVrWt7rZfieekAMW1M9M7Swjewn81pyJjgTgwoJBJMLFz5
         wl1LWInfbINaLa4Vm9d2Z5/9tVTCtM7HxqUm3/YCqN8jOmtEkI5JN4nl9BYmQaRQendl
         rd2UmrYaYrl0IiV+6EuDHd1rPpCAgZzr91qji1PHVNs27r+uSXjyAvokKJ7rzG96f4SA
         hoInn39lzYEE/jNDLG3AhrRJ4StWL/Yxjz9tf9uVyX7LGEjp14fQw47pCnozdIWXRePY
         fON4MLreMmIZTwEyLDcTa76rHBcIjvKz7h2TIjBsiOFp+w8OcYdV++tXM3PkabmBWRMx
         9tRw==
X-Gm-Message-State: APjAAAV8ob+/0HUaplbBdq/UC/uMUWzdbz+GXXVeZ8mUOvTh2MGfmluP
        WA+USiXLuzC7fi+He2p/aujr5YU3Qxcw/47c4Gk=
X-Google-Smtp-Source: APXvYqw8f3s5Y1B5h+GlN0LGWdi6jQ6seVFS1kHKBFphpmAn4ZweY2uywatDvni9eBpZvrmeZzrrH0HxD+6bUh/zNzg=
X-Received: by 2002:a17:906:a884:: with SMTP id ha4mr20100493ejb.192.1571815331396;
 Wed, 23 Oct 2019 00:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.412.git.1571768375.gitgitgadget@gmail.com>
 <ffdde613d8ea2dc57719594aa0f89b6d6177b636.1571768375.git.gitgitgadget@gmail.com>
 <20191022210458.GE9323@google.com>
In-Reply-To: <20191022210458.GE9323@google.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Wed, 23 Oct 2019 20:22:00 +1300
Message-ID: <CACg5j24wn_rq5YgctLu-LAhXTk_pTkhmo6jkFL655dynN-zyLQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] documentation: remove empty doc files
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 10:05 AM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Tue, Oct 22, 2019 at 06:19:35PM +0000, Heba Waly via GitGitGadget wrote:
> > From: Heba Waly <heba.waly@gmail.com>
> >
> > Remove empty and redundant documentation files from the
> > Documentation/technical/ directory.
> >
> > As part of moving the documentation from Documentation/technical/api-* to
> > header files, the following files are deleted because they include only
> > TODO messages with no documentation to be moved:
> > Documentation/technical/api-grep.txt
> > Documentation/technical/api-object-access.txt
> > Documentation/technical/api-quote.txt
> > Documentation/technical/api-xdiff-interface.txt
>
> Same thing as I mentioned in your other review; what you've added to
> your commit message now doesn't say anything you didn't say with the
> diff. I can see that you removed empty documentation files; I can see
> that those files include only TODO.
>
> Maybe you can explain why it's a bad developer experience to stumble
> across these, and that those files sat untouched for years in the
> TODO(contributor-name) state.
you're right!
> >
> > Signed-off-by: Heba Waly <heba.waly@gmail.com>
> > ---
> >  Documentation/technical/api-grep.txt            |  8 --------
> >  Documentation/technical/api-object-access.txt   | 15 ---------------
> >  Documentation/technical/api-quote.txt           | 10 ----------
> >  Documentation/technical/api-xdiff-interface.txt |  7 -------
> >  4 files changed, 40 deletions(-)
> >  delete mode 100644 Documentation/technical/api-grep.txt
> >  delete mode 100644 Documentation/technical/api-object-access.txt
> >  delete mode 100644 Documentation/technical/api-quote.txt
> >  delete mode 100644 Documentation/technical/api-xdiff-interface.txt
>
> As for the content of this change, I absolutely approve. I've stumbled
> across some of these empty docs while looking for answers before and
> found it really demoralizing - the community is so interested in
> teaching me how to contribute that they've sat on a TODO for 12 years?
> :( I even held up api-grep.txt as a (bad) example in a talk I gave this
> year. I'm happy to see these files go.
>
>  - Emily
