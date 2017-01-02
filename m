Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63E2D205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 19:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756164AbdABTFY (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 14:05:24 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:37895 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755844AbdABTFM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 14:05:12 -0500
Received: by mail-it0-f41.google.com with SMTP id x2so282219437itf.1
        for <git@vger.kernel.org>; Mon, 02 Jan 2017 11:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/YR+aOl5vZEd/NF/++S2kKNTmQ0XEgodohdSG7lSBRw=;
        b=U0ybI01VauIuiGqAsq1Msh3rw/WGQSDmw6hemZc5bjxVEbLvV2Qoy+TfuH0h7StOZK
         klaHrtiIEK2LNdu9tM5A/gqVQAJQg2Z9GFPemu+98GjLZ4+Wb+jaKgFEku1FWl6Bj9LC
         OwBJ1IiIhot96O75Zh8RIahXCdOsJhjtiH6hYLhqOETyr6VKsjmzFb9sFOv1n5UvPH7i
         iljZSwVkmFen0KNeo2hQYVyQtOdVj/q2bFaSBpTpM6iLAPE150SRg3xbzKcXBlDE7N4U
         CC0Zk4RVx1iyPw3X2yqL/2lcRjBCeGjX45gD9DDSMa/dcT4PUINmxWBepBfpQCIqWs1E
         Urog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/YR+aOl5vZEd/NF/++S2kKNTmQ0XEgodohdSG7lSBRw=;
        b=U4Z68wVAA/UDpag5dHrFMK/B7pfZ4pBAM5WJrzCnApg1hHwKZ7UvlxiqO4UGlal9L8
         wh2ckx/4JmlINm3073XYPLt2iwwNwp9Y7ljEFGfqVEBUJUwvyZcjrc3E3ylFYypzs7bn
         X+MpsQAtMFu8+U4x+ZOmHTxcOkL7j04/7bN6eltu4Ki5EgJe6BkVmkHaRc2F+mOaaeD7
         /lR2ymyj5Ulti970qCyMf9ZUGx4KiMbRT6bgRh/Fz1NqYpFOFw0p9wSblOKbyx/jOruR
         xmn48/oFt/TWxDxCYtW9WWPXR2sCvt1M9fCij2sGPij5ZGBzyr2iAEdwT02A40aD/LYM
         FPpA==
X-Gm-Message-State: AIkVDXJMshy7pz9+aBw8+gkRoYah1gvACj6fHiR2n8XEpNZHjvkH3qK2xo21pqqxhYuzgBxernCZXX/s52lSXQ==
X-Received: by 10.36.213.4 with SMTP id a4mr52652499itg.0.1483383912099; Mon,
 02 Jan 2017 11:05:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.181.197 with HTTP; Mon, 2 Jan 2017 11:05:11 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1701021712010.3469@virtualbox>
References: <CAGf+dShpkPvsC8wQN6mWmYeMZ3=i-ZOzDNSM1aa0rinKW6+-+g@mail.gmail.com>
 <alpine.DEB.2.20.1701021712010.3469@virtualbox>
From:   Paul Sbarra <sbarra.paul@gmail.com>
Date:   Mon, 2 Jan 2017 13:05:11 -0600
Message-ID: <CAGf+dSjM9nuroeSM9mkQmO3ho4XcZhLo1CR76q-jbeQ-WNGG+Q@mail.gmail.com>
Subject: Re: builtin difftool parsing issue
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I would have expected `git difftool --submodule=diff ...` to work... What
> are the problems?

The docs for difftool state...
"git difftool is a frontend to git diff and accepts the same options
and arguments."
which could lead a user to expect passing --submodule=diff to have a
similar behavior for difftool.  It would be especially useful when
combined with --dir-diff.

Unfortunately, due to the way the left/right directories are built up,
difftool needs to handle this option itself.  Currently a file
representing the submodule directory is created that contains the
hash.

if (S_ISGITLINK(lmode) || S_ISGITLINK(rmode)) {
   strbuf_reset(&buf);
   strbuf_addf(&buf, "Subproject commit %s", oid_to_hex(&loid));
   add_left_or_right(&submodules, src_path, buf.buf, 0);
   strbuf_reset(&buf);
   strbuf_addf(&buf, "Subproject commit %s", oid_to_hex(&roid));
   if (!oidcmp(&loid, &roid))
      strbuf_addstr(&buf, "-dirty");
   add_left_or_right(&submodules, dst_path, buf.buf, 1);
   continue;
}

To achieve the desired behavior a diff command would need to be run
within the submodule.  A further complication is whether submodules
should be processed recursively.  I'm not sure whether or not diff
handles them recursively.  I believe the logic to parse and build up
the files would need to be factored out such that it could be called
for the super-project as well as each submodule change.

This is all out of scope for your effort as the existing (perl-based)
difftool doesn't do this either.  However, it's a feature that would
provide a significant simplification to the workflow used at the
office to review changes.
