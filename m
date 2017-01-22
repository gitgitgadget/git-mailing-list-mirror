Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41E12092F
	for <e@80x24.org>; Sun, 22 Jan 2017 22:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750734AbdAVW7O (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 17:59:14 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36596 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdAVW7O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 17:59:14 -0500
Received: by mail-qt0-f171.google.com with SMTP id k15so95606025qtg.3
        for <git@vger.kernel.org>; Sun, 22 Jan 2017 14:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DKnJNQXwFp34eSOBm52nQKn28zbjcxLlQX0OWrjGCUM=;
        b=E/cDAaPmh+e6SU+GL2VyC90bC2sq5uvzk4t/fRxcxf+U7zFNSB+EAWM888tcmh085G
         cfdqlWxoWzt2VliOjFx8CkTZ4CXXs94T9z2uopb2P4gT2xnSeTlpHQMo8bVAaAiJ0V0P
         ydd870eb5SWy8iTSr60bXAzAjcYPPpnyS8P9GFId40qCr8km6m9vaxFpLjNJghdc5IIE
         IkbqPPcfzIpLlRYVgVtrkN6ejNDLh1iLSlARYZcxgZWxBKvldrf9t4tAzagPsDkDVoT9
         h3ZMDxqnIMa1qzpxY6HLVN/xZXRnYVvGaUWIP/WvEFVHNwUGjwJFLtuXw0lQBo1cKQYD
         UYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DKnJNQXwFp34eSOBm52nQKn28zbjcxLlQX0OWrjGCUM=;
        b=TgFUWpjVEAcHRQujHDcWpXVjbZfadBLQpBrpSWReqTiivSHsADmc5luLweX0EJKhCV
         OYEKj93M9H0vneifOTZeFyx14fx0peucn3Xtx0gv+we/3v7W+Qu1GZkfeVrKsebIJbRH
         qETwLBDGJK1ejb6S5hX0tU0ENtVNAmTwyyIrTkbLPFOWC10sPpGCHvNvxDr0ufvRY6UM
         rdOssY5JT+qyrVVtm+iRMWs3SVsD4j/hevB6EsfoIuF+dnGHRScvjOHRPr3O8oKa+k3G
         niN+hksdKuiD5oEXPnz1uFc8ztt6D+aRuu+PDiPaPBmX1ZIPMohxL8ctGUwugr+Z5VgD
         LbMA==
X-Gm-Message-State: AIkVDXIka32h9VlJhOF0pmhLdz3JFLahlE2kiq2x3aeOy4YHHoT318ThQDLuuyoE9rLB75i0mtiTAby15l2LGg==
X-Received: by 10.55.10.131 with SMTP id 125mr24174859qkk.257.1485125953177;
 Sun, 22 Jan 2017 14:59:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.45.132 with HTTP; Sun, 22 Jan 2017 14:59:12 -0800 (PST)
In-Reply-To: <xmqqefzuvijl.fsf@gitster.mtv.corp.google.com>
References: <CAOc6etZ9QeJAf1CKh9Eraigwy45yR6eO-7Th+bZRnTa71BoPew@mail.gmail.com>
 <xmqqefzuvijl.fsf@gitster.mtv.corp.google.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sun, 22 Jan 2017 16:59:12 -0600
Message-ID: <CAOc6etbCLju8nUcU5SMOJwzAcjk_LM041Tak897XrXUpFWtCiA@mail.gmail.com>
Subject: Re: Does it make sense to show tips on blame?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 22, 2017 at 4:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:
>
> What does the word "tip" mean in this context?  The word is often
> used to mean the commits directly pointed at by branches (i.e. the
> tip of history), but I do not think that is what you are interested
> in showing in this butchered "diff" output.

>
> Do you mean the one-line summary for the commit?  The commits that
> are shown will not be at the tip most of the time (the "+" ones may
> be if you happen to be running "git show" on the tip of a branch,
> but that is minority if you also want to do "git log -p"), so I am
> not sure it makes sense to call them "tips" in the above output.
>

Yeah, it would be the 1-line summary for the revision that is related
to the lines that
will be printed right after the summary, as a way to provide
additional context about
those lines without having to resort to an additional git show
--summary command.
Perhaps a name more appropriate name than "tips" in the context of git would be
better suited to avoid confusion.

> If I were doing the above, I would probably do them as footnotes to
> keep the body of the patch text (slightly) more readable.  E.g.
>
>         @@ -l,k +m,n @@
>          2a113aee9b
>         +405d7f4af6   if (!root-tree)
>         +405d7f4af6       load_tree(root)
>          ...
>         #2a113aee9b "fast-import: Proper notes tree manipulation", 2009-12-07
>         #405d7f4af6 "fast-import: properly fanout notes when tree is imported", 2016-12-21
>

Now, this is a different topic altogether (difflame related) and I
think it was raised from the fact that I
included output from difflame (which starts from diff output) as my
example. When talking about
blame it would be no-patches, just plain blame output writing the
1-line summary for blocks of lines
related to the same revision. I already sent a patch today with the
changes needed to see what I mean in action.
Could you give it a test drive? Consider it's a rough draft (and I
also raise the question of "aggregating" output
on the mail thread)

Something like this, hope this doesn't get butchered (at least not
that hard, i'm truncating the lines):

        3d426842: README.txt
3d426842 (Edmundo Carmona Antoranz 2017-01-17 22:26:18 -0600   1) difflame
3d426842 (Edmundo Carmona Antoranz 2017-01-17 22:26:18 -0600   2)
3d426842 (Edmundo Carmona Antoranz 2017-01-17 22:26:18 -0600   3) Copyright 2017
3d426842 (Edmundo Carmona Antoranz 2017-01-17 22:26:18 -0600   4) Released unde
3d426842 (Edmundo Carmona Antoranz 2017-01-17 22:26:18 -0600   5)
       0660083e: Add params to blame and diff, adjust README.txt
0660083e (Edmundo Carmona Antoranz 2017-01-18 20:51:12 -0600   6) Show the outp
0660083e (Edmundo Carmona Antoranz 2017-01-18 20:51:12 -0600   7)
       c869edc9: README.txt - stick (or at least, at least try) to 80 columns
c869edc9 (Edmundo Carmona Antoranz 2017-01-20 23:39:51 -0600   8) Example outp
c869edc9 (Edmundo Carmona Antoranz 2017-01-20 23:39:51 -0600   9) params to cha

>> The question is if you think it makes sense to add this option to
>> git-blame itself.
>>
>> Something like:
>> git blame --tips README.txt
>
> I do not think I would use it personally, as it would make it hard
> to pipe the output of "git blame" to less and then /search things,
> as extra cruft added by the option will get in the way.  IOW, I do
> not think we want it for human-oriented output.

Doing a search through less, it would make sense to leave the 1-line summary out
but when looking at blame output through OSI layer 8, I'd definitely
like to get that 1-line summary "as an option" every so often (more
often than not
in my case, probably).
