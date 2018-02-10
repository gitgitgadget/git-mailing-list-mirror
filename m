Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07E751F404
	for <e@80x24.org>; Sat, 10 Feb 2018 20:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeBJU6T (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 15:58:19 -0500
Received: from mout.gmx.net ([212.227.17.22]:37767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752446AbeBJU6S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 15:58:18 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx101 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0Lg5kl-1f3jop3h4l-00pYmh; Sat, 10 Feb 2018 21:58:09 +0100
Date:   Sat, 10 Feb 2018 21:58:07 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 02/10] sequencer: introduce new commands to reset the
 revision
In-Reply-To: <CAPig+cSkzetewFio+4ECnXiizH_KFGEZPZVdzHYGcKL_yvLcSg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1802102034280.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <cover.1517266437.git.johannes.schindelin@gmx.de> <36281a14bc9f9a53e6c1bead561e3c93744047a8.1517266437.git.johannes.schindelin@gmx.de>
 <CAPig+cSkzetewFio+4ECnXiizH_KFGEZPZVdzHYGcKL_yvLcSg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lpL3tGZURrv/l23KtkNdWjqeGDvoiQMe1rpI1dT1lRFaR/WMV74
 coCOyIjy7cC8NzfZX5RtF7gQ53+ureWowMqUdghcaG4Oghn7tUZt8GT9eyyv9L2Dkf3rMAP
 iwmFsipoXXTTR/lBVLFDY4qLtd3B4cmGomKNT/jZMbOvO2e8JMK/MSAVAQ55JnO9dNEXD0C
 pxg1smKAX+4fI+5RalXgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gNexLJ9lGIA=:DPetBZLEnF3NVDWcDXcSfP
 itnNfzfm3IZj2HybQGn5+jhYf0ZLeyGLp9fnqVQ1p4LdyZ0wZ7NwIPlctSulpOy4dxw5H1q7g
 lTK1hjg2Gwx7LjzIDzTJXc4vQ2i890lwYptKERn6aksw2LdO5c0FBuj20GWOshEZK0jJDqQ/E
 EEsgQ53JjItpVQ2OycjxowWggaJDpEHWtWQWtCZMuce0qJ4/EoPLujf4oiOeQ6r1xjYkYH4FV
 ziyHimzf5ZJNHET8NiqNOlKrG9jPoegibjAjup75gN3OelJbCP7wy+oBa+TEt3LLFcMJOR5b0
 s+Vi2ccE3kZkx2Who7B0/8KPFd0v1DGN+OtBGo7gys66ttRj/WJXCpNX+JjtNhUW5UVNviJpQ
 kaI7U/nW2ifgJMGqwouZiCgbD2Fm8de0MkbIqp5eLtajtT9+vDEZ43GOa2gd40TaSV5+GOWYa
 0LeZUZfjc9uPNIqt3s1FyPxvVb38dxq2RTo/ZR7UbcGuW37WJOetE6pzm7qLsaBZtok/Y5Uof
 LQejZWvOmGR6RANhKiR/1IWnHHWZejPjE5o5FqnDKyeGhOSln1xMX8/3wroAhNVCuKSQHBaei
 muPwf0GbCY5jdaYYOuWtkijylhA/87+Zp/tOprjzrIVvQKKGJC/NXacl9VoVjSxgkajuURkJw
 W5YsgkrKN8VvrjESj6jK/nno9VcAVlPdVsVNJNUFttLCIVJxHib5+05ZaYckGalZsXV6UQ5aE
 4D+zItqZ5fGUG4T2FMj28P91TNdqNr+mk9N4gRu906NGBAkgTMnRnjy5B/ea1yEKMrh63cTw5
 2aA3e7h7Zpm1ljluSPPAaJDPusc1tscnNLn50M0yJdHrdMlcp4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, 30 Jan 2018, Eric Sunshine wrote:

> On Mon, Jan 29, 2018 at 5:54 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > [...]
> > This commit implements the commands to label, and to reset to, given
> > revisions. The syntax is:
> >
> >         label <name>
> >         reset <name>
> > [...]
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/sequencer.c b/sequencer.c
> > @@ -1253,7 +1266,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
> >                 if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
> >                         item->command = i;
> >                         break;
> > -               } else if (bol[1] == ' ' && *bol == todo_command_info[i].c) {
> > +               } else if ((bol + 1 == eol || bol[1] == ' ') &&
> > +                          *bol == todo_command_info[i].c) {
> 
> This adds support for commands which have no arguments, however, now
> that the "bud" command has been retired, this can go away too, right?

Good point. Fixed.

> >                         bol++;
> >                         item->command = i;
> >                         break;
> > @@ -1919,6 +1934,144 @@ static int do_exec(const char *command_line)
> > +static int safe_append(const char *filename, const char *fmt, ...)
> > +{
> > +       va_list ap;
> > +       struct lock_file lock = LOCK_INIT;
> > +       int fd = hold_lock_file_for_update(&lock, filename, 0);
> > +       struct strbuf buf = STRBUF_INIT;
> > +
> > +       if (fd < 0)
> > +               return error_errno(_("could not lock '%s'"), filename);
> 
> Minor: unable_to_lock_message() can provide a more detailed
> explanation of the failure.

That is true. Due to its awkward signature (returning void, using a
strbuf), it would add a whopping 4 lines, too.

There is a better solution, though, adding only one line: passing
LOCK_REPORT_ON_ERROR as flag to hold_lock_file_for_update().

> > +
> > +       if (strbuf_read_file(&buf, filename, 0) < 0 && errno != ENOENT)
> > +               return error_errno(_("could not read '%s'"), filename);
> > +       strbuf_complete(&buf, '\n');
> > +       va_start(ap, fmt);
> > +       strbuf_vaddf(&buf, fmt, ap);
> > +       va_end(ap);
> 
> Would it make sense to also
> 
>     strbuf_complete(&buf, '\n')
> 
> here, as well, to be a bit more robust against lazy callers?

I'd rather not make that assumption. It *may* be true that the current
sole user wants the last line of the file to end in a newline. I try to
design my code for maximum reusability, though. And who is to say whether
my next use case for the safe_append() function wants the semantics you
suggest, if it wants to append less than entire lines at a time, maybe?
Let's not optimize prematurely, okay?

> > +
> > +       if (write_in_full(fd, buf.buf, buf.len) < 0) {
> > +               rollback_lock_file(&lock);
> > +               return error_errno(_("could not write to '%s'"), filename);
> 
> Reading lockfile.h & tempfile.c, I see that rollback_lock_file()
> clobbers write_in_full()'s errno before error_errno() is called.

True. Fixed.

I also fixed the code from where I copy-edited this pattern (increasing
the patch series by yet another patch).

> > +       }
> > +       if (commit_lock_file(&lock) < 0) {
> > +               rollback_lock_file(&lock);
> > +               return error(_("failed to finalize '%s'"), filename);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int do_reset(const char *name, int len)
> > +{
> > +       [...]
> > +       strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
> > +       if (get_oid(ref_name.buf, &oid) &&
> > +           get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
> > +               error(_("could not read '%s'"), ref_name.buf);
> 
> Checking my understanding: The two get_oid() calls allow the argument
> to 'reset' to be a label created with the 'label' command or any other
> way to name an object, right? If so, then I wonder if the error
> invocation should instead be:
> 
>     error(_("could not read '%.*s'"), len, name);

I would rather give the preferred form: refs/rewritten/<label>.

The main reason this code falls back to getting the OID of `<label>`
directly is to support the `no-rebase-cousins` code: in that mode, topic
branches may be based on commits other than the one labeled `onto`, but
the original, unchanged one. In this case, we have no way of labeling the
base commit, and therefore use a unique abbreviation of that base commit's
OID.

But this is really a very special use case, and the more common use case
should be the one using refs/rewritten/<label>.

Ciao,
Dscho
