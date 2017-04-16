Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08AE220D09
	for <e@80x24.org>; Sun, 16 Apr 2017 22:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756873AbdDPW0A (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 18:26:00 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33609 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756674AbdDPWZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 18:25:59 -0400
Received: by mail-io0-f193.google.com with SMTP id k87so23655977ioi.0
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 15:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mvFU6N/fbcg7tY2Q2Q9jpHxA+Sx9ik5wcm3bPUx1ARw=;
        b=ATFumpbPlsA03fGaAyMOVvedw21uQ0l9tHlMlt2fc+6pOrifgOYJo9fm80SEQWp/Oo
         SUShdlZBP6l+sZpmoqP4i4DOgAZUD7VL27ph0rvwH1h+daxOTKjsj1Zso9I/O7lGehZe
         MA0AlLvYGVe+LRDSlsF6FjTmb5lT2nEo1klKpU8QZomaq1VeJzqjpev37mQ2YA2X7Wk8
         znOGXbXUpOUTf5im7o1vASN+TPJRS42ZxAdGzKwQORTOQ1iUl8KCMwPBxy6gxqHtUKAK
         1jGWFJ+uHAej/iihVtTbz8B0v2lLVlgTsrulpCg6YA/4kYLh12hPTYl5KdYrgaqkdx9b
         50jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mvFU6N/fbcg7tY2Q2Q9jpHxA+Sx9ik5wcm3bPUx1ARw=;
        b=eZAA/kbDktfaWiks9pCr1vbTqYAYpULu5cDFf+oLFEKtNo4EKC66T8YDQLns4uFH2V
         KWIQq32SPtsOACTFWHj5LyGF0VSMvc8PWsyrfZHjjS5pcxSMPAeq9UZ0ya+rRM/tNp6d
         mmx0UWOaWeTpSTl5CZpWcPxY4TOruQeKdmu2AJ6lPO2IKF4Kzt7Gd469Ry0z/hSp/Cv/
         QFjwAP3C9W5s4sT7ehJicEVU1jnVjmpNtzwVOZjdcx10h7oX3t+KMKO1ZYynqI8DUIEf
         mP8Ksx2nABq/qNiu9BF/mtDr2inoz2fbxqt23M0BybUFBleeH/nsslXyxy94bEcBDBjV
         K0Kw==
X-Gm-Message-State: AN3rC/6+TK1bHMlX5Vs1Nqc5c/P1fti5B5FW1HZL5Zpoc0m6vMt4VEqI
        xx7KcKzqZgK8ivMbzT4t9DE5SM58Eg==
X-Received: by 10.36.82.144 with SMTP id d138mr7800221itb.24.1492381558172;
 Sun, 16 Apr 2017 15:25:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Sun, 16 Apr 2017 15:25:37 -0700 (PDT)
In-Reply-To: <20170414212325.fefrl3qdjigwyitd@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com> <20170408132506.5415-2-avarab@gmail.com>
 <20170411100656.5bptxdaptc4zznan@sigill.intra.peff.net> <CACBZZX7vEQ5jUzX3GsD6JXe50TnRUtGmSVi7zBxwOmAQGABQ4Q@mail.gmail.com>
 <20170411203434.iiupo2oovzviqju5@sigill.intra.peff.net> <CACBZZX7Xi2OWqHQd7jTGBEZyqcWk59oXbPJOjuYrYAFzd5huCA@mail.gmail.com>
 <20170414212325.fefrl3qdjigwyitd@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 17 Apr 2017 00:25:37 +0200
Message-ID: <CACBZZX76hbERU5-_BQQ-swN_wxDfphS=qM7GOo_svyxQQG+Lgg@mail.gmail.com>
Subject: Re: [PATCH 01/12] grep: add ability to disable threading with
 --threads=0 or grep.threads=0
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Thomas Rast <trast@student.ethz.ch>,
        Fredrik Kuivinen <frekui@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2017 at 11:23 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 11, 2017 at 10:56:01PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > Right, my suggestion was to teach "grep" to treat --threads=3D1 as "do=
 not
>> > spawn any other threads". I.e., to make it like the "0" case you were
>> > proposing, and then leave "0" as "auto-detect". There would be no way =
to
>> > spawn a _single_ thread and feed it. But why would you want to do that=
?
>> > It's always going to be strictly worse than not threading at all.
>>
>> I understand, but given the two profiles we've posted it seems clear
>> that there's cases where if we did that, we'd be locking people out of
>> their optimal thread configuration, which would be --thread=3D1 with my
>> patch, but wouldn't exist with this proposed change.
>
> Maybe I don't understand your profiles. For a single-core machine you
> probably want fewer threads, right? There is no such thing as "0"
> threads, as you always have the original main thread in which we would
> do the work.  So the lowest you can go is "1" (it's a separate question
> of what --threads=3D0 should "mean"; I think we should keep it as
> "auto-detect" for compatibility).
>
> We could implement the single-thread case by spawning off one worker
> thread (and effectively having 2 threads, but one is just sitting in
> pthread_join()). And I think that's how it's implemented now in
> git-grep. But we can optimize out the creation of the second thread
> entirely, and just do the work in the main thread.
>
> That saves a little bit of thread-spawning overhead, and it also makes
> debugging much more pleasant.  For --threads=3D2, you'd always have to
> kick in the thread-spawning code, and you'd spawn two worker threads
> (and the main thread just sits there).
>
> IOW, I am just proposing something like this:
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 65070c52f..76ce38404 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -326,7 +326,7 @@ static int grep_oid(struct grep_opt *opt, const struc=
t object_id *oid,
>         }
>
>  #ifndef NO_PTHREADS
> -       if (num_threads) {
> +       if (num_threads > 1) {
>                 add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, path, oid);
>                 strbuf_release(&pathbuf);
>                 return 0;
> @@ -360,7 +360,7 @@ static int grep_file(struct grep_opt *opt, const char=
 *filename)
>         }
>
>  #ifndef NO_PTHREADS
> -       if (num_threads) {
> +       if (num_threads > 1) {
>                 add_work(opt, GREP_SOURCE_FILE, buf.buf, filename, filena=
me);
>                 strbuf_release(&buf);
>                 return 0;
>
> where we fall back to the same code that NO_PTHREADS uses when there is
> only a single thread requested.
>
>> Anyway, I really don't care about this feature much, I just wanted a
>> way to disable threading, but looking at the perf profiles I wonder if
>> doing your proposed change would cause a regression in some cases
>> where someone really wanted /one/ thread.
>
> I'm not sure what would regress. Right now --threads=3D1 only does
> work in a single worker thread. And --threads=3D2 does it in 2, and so on=
.
> In all cases, the original main-thread is just farming out work and
> waiting on pthread_join() (let's call that the controller thread).  So
> why would you ever want the "controller plus one worker" setup? It's
> strictly worse than "controller just does the work".
>
>> But of course my patch breaks the long documented grep.threads=3D0 for
>> "give me threads that you auto detect" to now mean "you get none".
>
> Right, that's what I'm concerned about.
>
>> Also doesn't --thread=3D1 right now mean "one thread, but two workers?".
>> I haven't dug into the grep worker/thread code, but it compiles the
>> the pattern twice, so isn't both the non-thread main process & the
>> sole thread it spawns on --thread=3D1 doing work, so in some other
>> universe it's synonymous with --workers=3D2?
>
> I think --threads=3D1 right now means "one worker thread". I think the
> main program calls compile_grep_patterns() to make sure they are sane,
> before it even considers whether and how to thread.  And then each
> worker thread duplicates them and re-compiles them itself (IIRC, this is
> because the regex code may not be thread-safe).
>
>> If so do pack-objects & index-pack also behave like that? If so this
>> whole thing is very confusing for users, because some will read 1
>> thread and think "one worker", whereas it really means "two workers,
>> one using a thread, if you want three workers spawn two threads".
>
> No, I think --threads is "this many workers". If you have more than one
> worker, you may have an extra thread farming out work to them, but that
> isn't counted (and is mostly dormant).

I submitted a v2 of this patch series, see "[PATCH v2 0/8] grep
threading cleanup & tests", as noted there this whole confusing v1 +
thread is me misunderstanding how grep actually worked. Thanks for
being patient with me, that patch series fixes the odd handling of
grep patterns which led me down the garden path of thinking that
workers !=3D threads in the case of grep (which in retrospect couldn't
have made any sense either, my mental model of C threading was wrong).
