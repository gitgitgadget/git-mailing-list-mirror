Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 184061F597
	for <e@80x24.org>; Thu, 26 Jul 2018 10:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbeGZMMQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 08:12:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:50699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729097AbeGZMMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 08:12:16 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LcSAg-1gS7kz0TLS-00jrvb; Thu, 26
 Jul 2018 12:55:55 +0200
Date:   Thu, 26 Jul 2018 12:55:53 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 2/5] format-patch: add --range-diff option to embed
 diff in cover letter
In-Reply-To: <CAPig+cTKGd8N78XvW-rmBEZC7ykcJsE+na1V_vCVXTUhGrFe4Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807261249490.71@tvgsbejvaqbjf.bet>
References: <20180530080325.37520-1-sunshine@sunshineco.com> <20180530080325.37520-3-sunshine@sunshineco.com> <nycvar.QRO.7.76.6.1807171219480.71@tvgsbejvaqbjf.bet> <CAPig+cTKGd8N78XvW-rmBEZC7ykcJsE+na1V_vCVXTUhGrFe4Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:grgON8WoQwxnQTajiLd7mh6wqSeVDXQP8pNN2+gKXtzSZ3b8B9e
 ZXJ37G6LkdsUvHChcyYa3xoapcXaLj2Vm3aTYXxMXxCmAf6e5qs4Q4ooxvB9jp37dsSL/8q
 RCCToaxuyrDzDOBdxb9GQ7ENv/UzpQK6NqDFljgpq87NchA5M/1RfDUlKpaNdWjNb8J+JX2
 Pg5qk+a21+e9cLfQVsnjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0+UaB1+4ifE=:Je6X0QwGbadDP3G/feow7a
 M7mof+nCTw9ZI7Ij2jlm1EFO8Oh1B4N8+p4TGaNw0ErtGT+sZTR9zJC5gGcJe0URqsJEMIRQL
 0XLMbp9fxAxO/Tkvl/gD3HWsxy8ZWE0h5iDGFAN5KYZ3Gea+3o/PPL/QmJIJGPL/nGuhGMSAW
 JJXH43e4FTUG11BCcalnjz1o9Nla9Xms0NiuAAdXc8rozSfrCDbxAOd/R2kFRHIOMAtmUCw9G
 xcbPi6IAtTml7UrHoVftyJz/mHiZ+Hu1jNqV+xl8HiBi2FEMgbsuKEEDaRppT6hEhFbxJJWhv
 uXS2mh+mr91M7G4gJlmPLRSnc8Io7qpy5KoIK/+lgk4OEn+xCR/NlSTOJdnmjbInqaQUWMYny
 +BT3oqUgZ5fOR5nOYmOyBqUTVL/Alfn7cCosPn25VBdZ+cFGQwe3YwhY7fIYe7N+btntnMQCy
 hYHUBgOiNZEBPsTQ2piavUP4O3i3oIeZ0uEwMCwdalYRSMUtasdh1vq3w4cwpLNVFmiOEHN5F
 rjaM6KcZEqmhpy+c/OfO9T3wAd6xumKPsW9ygR7k7j0Nj51KlbvBeHxX83gYKDEWToZHpXqNG
 KZX9oeyjq38l5u+HgsBHPMArz1YAG8Gi3jSKbF8Tr62uZgINcpHpmJ9fgOPOHjc/uMtzU7sK6
 HHtC3yEExs53wwuyp9lpRdCOJIE0DiRzrQJ764w+a6+rnWh5FxbJroOs9LMVbEL3WFFxTzwb9
 WyWaKvU6DBwx1RkNGfwf8yHyAF/vXm0nbKTLdaGJ/0N7M1hlF4VM1exVKtwcaZAaGEio7fr2r
 RYCrf4M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, 17 Jul 2018, Eric Sunshine wrote:

> On Tue, Jul 17, 2018 at 6:31 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Wed, 30 May 2018, Eric Sunshine wrote:
> 
> > > +     if (range_diff) {
> > > +             struct argv_array ranges = ARGV_ARRAY_INIT;
> > > +             infer_diff_ranges(&ranges, range_diff, head);
> > > +             if (get_range_diff(&diff, &ranges))
> > > +                     die(_("failed to generate range-diff"));
> >
> > BTW I like to have an extra space in front of all the range-diff lines, to
> > make it easier to discern them from the rest.
> 
> I'm not sure what you mean. Perhaps I'm misreading your comment.

Sorry, I was really unclear.

In the cover letters sent out by GitGitGadget (or earlier, my
mail-patch-series.sh command), I took pains to indent the entire
range-diff (or interdiff) with a single space. That is, the footer
"Range-diff vs v<n>:" is not indented at all, but all subsequent lines of
the range-diff have a leading space.

The original reason was to stop confusing `git apply` when sending an
interdiff as part of a single patch without a cover letter (in which case
mail-patch-series.sh inserted the interdiff below the `---` marker, and
the interdiff would have looked like the start of the real diff
otherwise).

In the meantime, I got used to this indentation so much that I do not want
to miss it, it is a relatively easy and intuitive visual marker.

This, however, will be harder to achieve now that you are using the
libified range-diff.

> > > @@ -1438,6 +1480,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> > > +     const char *range_diff = NULL;
> >
> > Maybe `range_diff_opt`? It's not exactly the range diff that is contained
> > in this variable.
> 
> I could, though I was trying to keep it shorter rather than longer.
> This is still the same in the re-roll, but I can rename it if you
> insist.

I think it will confuse me in the future if I read `range_diff` and even
the data type suggests that it could hold the output of a `git range-diff
<options>` run.

So I would like to insist.

> > > +format_patch () {
> > > +     title=$1 &&
> > > +     range=$2 &&
> > > +     test_expect_success "format-patch --range-diff ($title)" '
> > > +             git format-patch --stdout --cover-letter --range-diff=$range \
> > > +                     master..unmodified >actual &&
> > > +             grep "= 1: .* s/5/A" actual &&
> > > +             grep "= 2: .* s/4/A" actual &&
> > > +             grep "= 3: .* s/11/B" actual &&
> > > +             grep "= 4: .* s/12/B" actual
> >
> > I guess this might make sense if `format_patch` was not a function, but it
> > is specifically marked as a function... so... shouldn't these `grep`s also
> > be using function parameters?
> 
> A later patch adds a second test which specifies the same ranges but
> in a different way, so the result will be the same, hence the
> hard-coded grep'ing. The function avoids repetition across the two
> tests. I suppose I could do this a bit differently, though, to avoid
> pretending it's a general-purpose function.

If you can think of a way that would make this easier to read for, say,
myself if I ever find myself debugging a regression caught by this test, I
would appreciate that.

Ciao,
Dscho
