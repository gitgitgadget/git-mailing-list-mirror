Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1B621F404
	for <e@80x24.org>; Fri, 24 Aug 2018 16:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeHXTmS (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 15:42:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:47669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbeHXTmS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 15:42:18 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaXmV-1fX3L548dz-00mMpU; Fri, 24
 Aug 2018 18:06:57 +0200
Date:   Fri, 24 Aug 2018 18:06:56 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Pratik Karki <predatoramigo@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>, alban.gruin@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/18] builtin rebase: support `--autostash` option
In-Reply-To: <CACsJy8CS5aABuQrqWxdfLOTbFRhQDQ+tFO+wOCLTdeJG8mH0hw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808241805550.73@tvgsbejvaqbjf.bet>
References: <20180808152140.14585-1-predatoramigo@gmail.com> <20180808152140.14585-12-predatoramigo@gmail.com> <CACsJy8CS5aABuQrqWxdfLOTbFRhQDQ+tFO+wOCLTdeJG8mH0hw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iUQDPF1i69+Nwx4XdXGmmkeGbwQdmHYdkVEf7N+zWIofB26OZxh
 Tmr2rkfZ//BrHlCitLvSvNADuqEmSe1u9V+vTo/1aKOMujSvAU/eM4mjvpXpYFmx9y533P5
 ImrakDLfS4miWBwjW152b2c0e1tC9eUu2gJOm06X0eP6f8v0Ja+xE0KmDu/cxzfr6zUM1KD
 qauRJq4gNiKprmpvGQ0NQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o9kJREGQoMk=:ZQ9JoTtSppM+6GdIWYIzQ5
 XPV6HRy1rrcPvswVCT+/ECkCe/6h4neeZ4qb1NzWjGsoaMViCAeSzNlGJ6FhXsKlO6/50nEpv
 RT9aMKgSzKm6oyQHB8KS+t84BNwoqF2hUFyhjwU41DsL6GzN36iV0jwixtijB88WdPTzLubrr
 +GTCu9iaeyFC1WnTG95IJZUEJ2KKjcf4H7qt8WVLv/805IQJXZ11Xixp+N/p+36FXG3dB8xcX
 Wy9xQVCS44fOhyj4TZ03a0ejJZKe0/c2/O7riKHyhBH/4zS4VIBQLLwItchAQrRgmQsBAL2S9
 kZlni4If4WTiluXnVlDsz8a/FnMxF7fMQ5T0e948WO9d+DGSULUWbzL6vUTewCrT01JOk8zQj
 D6CxW8e+DUv7ah5wh9SzcS/9ky7NQBU/AZCAUidnKkH7/KuIxiVesgbdAB95L9jj9TJ2cv2al
 dRmSxoTKqoQDQbxXoYy5JaiHvDHky7zOq6+SH/fZ0d+f43zxygFAEhOqjhTXrkE/7fWtpnjLt
 3/bo4k9WIARc/F/Mv+yepatUlrYRfV4Vxnzd2SYH9Buo7iBjVKV5/AodedfVPddbTl7TeqOBS
 AbjyhEonL+fr7/lrpttN17GtAOEsgNP7rNFVXhSlsED3LpeeQdA+ZR3gMPb+0I2ZbOicPNX2r
 G6AmBT0DQ4ANCQJgA07J4OtJsibolz2dWLSrtDvjo2cNE0gj2zPFxTRVWE4cFr00IsixScciZ
 KKMEbfF/CglnKCGpf/vzVNQXBUvS78vs/RhFlcAGl8AKzd9vQiW7Fpy7X0RZgBWBwxoLgegXS
 +nKQKi0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Sat, 18 Aug 2018, Duy Nguyen wrote:

> On Wed, Aug 8, 2018 at 5:26 PM Pratik Karki <predatoramigo@gmail.com> wrote:
> > @@ -224,13 +219,56 @@ static int read_basic_state(struct rebase_options *opts)
> >         return 0;
> >  }
> >
> > +static int apply_autostash(struct rebase_options *opts)
> > +{
> > +       const char *path = state_dir_path("autostash", opts);
> > +       struct strbuf autostash = STRBUF_INIT;
> > +       struct child_process stash_apply = CHILD_PROCESS_INIT;
> > +
> > +       if (!file_exists(path))
> > +               return 0;
> > +
> > +       if (read_one(state_dir_path("autostash", opts), &autostash))
> > +               return error(_("Could not read '%s'"), path);
> > +       argv_array_pushl(&stash_apply.args,
> > +                        "stash", "apply", autostash.buf, NULL);
> > +       stash_apply.git_cmd = 1;
> > +       stash_apply.no_stderr = stash_apply.no_stdout =
> > +               stash_apply.no_stdin = 1;
> > +       if (!run_command(&stash_apply))
> > +               printf("Applied autostash.\n");
> 
> I think you need _() here.

Good catch.

Will fix before sending v2,
Dscho

> 
> > +       else {
> > +               struct argv_array args = ARGV_ARRAY_INIT;
> > +               int res = 0;
> > +
> > +               argv_array_pushl(&args,
> > +                                "stash", "store", "-m", "autostash", "-q",
> > +                                autostash.buf, NULL);
> > +               if (run_command_v_opt(args.argv, RUN_GIT_CMD))
> > +                       res = error(_("Cannot store %s"), autostash.buf);
> > +               argv_array_clear(&args);
> > +               strbuf_release(&autostash);
> > +               if (res)
> > +                       return res;
> > +
> > +               fprintf(stderr,
> > +                       _("Applying autostash resulted in conflicts.\n"
> > +                         "Your changes are safe in the stash.\n"
> > +                         "You can run \"git stash pop\" or \"git stash drop\" "
> > +                         "at any time.\n"));
> > +       }
> > +
> > +       strbuf_release(&autostash);
> > +       return 0;
> > +}
> > +
> >  static int finish_rebase(struct rebase_options *opts)
> >  {
> >         struct strbuf dir = STRBUF_INIT;
> >         const char *argv_gc_auto[] = { "gc", "--auto", NULL };
> >
> >         delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
> > -       apply_autostash();
> > +       apply_autostash(opts);
> >         close_all_packs(the_repository->objects);
> >         /*
> >          * We ignore errors in 'gc --auto', since the
> -- 
> Duy
> 
