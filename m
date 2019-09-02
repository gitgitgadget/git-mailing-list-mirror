Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 504EB1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 19:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfIBTma (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 15:42:30 -0400
Received: from mout.gmx.net ([212.227.17.20]:53115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfIBTma (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 15:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567453339;
        bh=ZX2MIJ8C/yFXEVG3QCD7y+xbam08xGJymB5VgIuO3Yo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eNdO0cI/TauY7kBX5QzLV5P9g7lYRA6EPwTLDZPQkEVrnDWge4I9vwsSCaaiB4/d+
         1dfiKuEU2JobXzJZ9n6d3zeBToJUSGTnVbh1G7v9SyexuWW7/FZJfNV0taG0qZl6XW
         EMnNDWFT0MFwr7dYU/M/3sjxQaFBNXYMtV4dLAY8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOiHf-1hoa0q1Lnr-00QFB1; Mon, 02
 Sep 2019 21:42:19 +0200
Date:   Mon, 2 Sep 2019 21:42:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Matt R via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matt R <mattr94@gmail.com>
Subject: Re: [PATCH 1/1] rebase -r: let `label` generate safer labels
In-Reply-To: <444f3ec4-abdf-1aa9-e8a8-8b5346b939e8@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909022124350.46@tvgsbejvaqbjf.bet>
References: <pull.327.git.gitgitgadget@gmail.com> <4a02c38442dd8a4c0381adc8db0dce81c253da09.1567432900.git.gitgitgadget@gmail.com> <444f3ec4-abdf-1aa9-e8a8-8b5346b939e8@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2091281358-1567453340=:46"
X-Provags-ID: V03:K1:dbJeyYiyt0XFmhAFPl45JNjK+5AGv+yZK6rZ3cOhhWhJ9yWZYu9
 CkW8I8cxqGSzQVPPGvnK7IGvCk4xI0HUP0ul3Cg6XoAUEQy4E1v6reDIFVJlRnhutceaWOV
 QTjigEumsY16wMJuGR56rACTcqPWQtC8TorjfajzbEdOqC98LloFMgG9tlglBeLoWjuFAeU
 jdM0/WC8eHSrZNXeFsR+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:slXyjPFdbk8=:Plp+l/qbHIDYMkPK4yikvW
 fcvqMfw8wsLii2nVrPy1x3MIvmvO9YWDc1zbVYphT8eiPMMJiw+luACwPjXK22Izff7SxIcX5
 qG9Tvuvte4SXICKEATVtwCDdJGQPRiA4xWxgLSQZvPmA5OlVOM5tPNonjxi4DKshzYl5p5Kt0
 Luir2lYgULOuncLncVWrHq9mTV11Ag5DulDhLBh62EU4fq393EwKjjV0/AxDVAOnU9RvBiLBy
 ka5rkTWyYsrgY87EJzwZ52odK4gzSJ7zLxdITlJVE/dq0tRag0ze5o94Fbjfzs3OloAJWr8kJ
 CQmE3wIUZYeCW9KBYuKqIJjOwMQwBvNLQqz+wGH/ELmMkQO0L6kJJq5/7sAuJP7QAPQjsYTqf
 +LWjKRUdUG09HbpJgXIxePaEVDJMeltTQozrEYMr3QEnH5IHllEAin78X6iGZQk1N4zD9L5Z2
 xFBFXp7gjUKPR4IBAKLW08VEXK4n/xc34AWxKwDpzuoAEv4FB+V4hiq4tfpLrk9cHsr9etDRW
 mwgjWJFwANj40SsgnFcM2Z8RFG064QOg//ud5aVSNIpvKos1jyzIiUQ0FqxME5ze//8yfyMVc
 gQAoFE6PeIZ4bKAuRXD5pX1qRiI7PrLlJizVYl+y1ucgnF+lt44TetcZURQBkEnCZX6VataEP
 ysK00+Fkwfdm+UNai1BE/E0bT3VMgrRh2onvgByZIok1A766IW2e91ZEgN2iodT2frWTrGGMI
 07jHr2ZvBcnaXgfPAKoUi9EWtYcSdIqKN1faFYmTqNe16tjyKjpNkhEXbQl8PPiKVFTnla05P
 MPJohd2QcNTaq5s73hVlwVE0yrOxGBzvZS6MI3CjygzquwZNZ55TnRRwnobMG8zDTzXNUYIVM
 8pfLsny0e8pAcMJlIflZY8+asAFEJhz7x73g/Pw31GrigNtdR0ksqIB8yqlv5KYCP83HCcvSr
 TigikfLWH+nVnlRTILy01O4A1F6hPr0PdQtvlvLFw2UPYd+eUINzVOERrwRoae9cgkCYnQGVB
 vf4weFRB76x1/AEYNP05z9KXpT+OfiplQPJQp3ezvde3sGPCvTeoIzJp9gFGndNCRiZLMHsqu
 tSFNfxyXHMl8lBikz1/YCcoriUtT1v79s11wnXcXMgtZAWmgwNuBTZYfcMwHkjX9Mn1N/V5Cl
 Vw7bW8vHx/cq1e10PNgwZAn78EBRdG6nGcL8xrXMGfAh+21voQZxUNkx4FgTt1TmzlmOA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2091281358-1567453340=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Mon, 2 Sep 2019, Phillip Wood wrote:

> This is definitely worth fixing, I've got a couple of comments below
>
> On 02/09/2019 15:01, Matt R via GitGitGadget wrote:
> > From: Matt R <mattr94@gmail.com>

I just noticed that the surname is abbreviated. The full name of the
author is "Matt Rogers". (Matt, Git uses the Signed-off-by: lines as
some sort of legally-binding assurance that you are free to submit these
changes under the GPLv2, so your full name is kinda required.)

> > The `label` todo command in interactive rebases creates temporary refs
> > in the `refs/rewritten/` namespace. These refs are stored as loose ref=
s,
> > i.e. as files in `.git/refs/rewritten/`, therefore they have to confor=
m
> > with file name limitations on the current filesystem.
> >
> > This poses a problem in particular on NTFS/FAT, where e.g. the colon
> > character is not a valid part of a file name.
>
> Being picking I'll point out that ':' is not a valid in refs either.

True, but that was not the primary concern here ;-)

> Looking at
> https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file I
> think only " and | are not allowed on NTFS/FAT but are valid in refs
> (see the man page for git check-ref-format for all the details). So
> the main limitation is actually what git allows in refs.

Right. And this example shows that we really need to be a bit more
conservative than just disallowing characters that would not be allowed
in refs.

I think it is more important to keep in mind the vagaries of various
current and future filesystems to justify the change in this patch.

> > Let's safeguard against this by replacing not only white-space
> > characters by dashes, but all non-alpha-numeric ones.
> >
> > However, we exempt non-ASCII UTF-8 characters from that, as it should =
be
> > quite possible to reflect branch names such as `=E2=86=AF=E2=86=AF=E2=
=86=AF` in refs/file names.
> >
> > Signed-off-by: Matthew Rogers <mattr94@gmail.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >   sequencer.c              | 12 +++++++++++-
> >   t/t3430-rebase-merges.sh |  5 +++++
> >   2 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index 34ebf8ed94..23f4a0876a 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -4635,8 +4635,18 @@ static int make_script_with_merges(struct
> > pretty_print_context *pp,
> >     else
> >      strbuf_addbuf(&label, &oneline);
> >   +		/*
> > +		 * Sanitize labels by replacing non-alpha-numeric characters
> > +		 * (including white-space ones) by dashes, as they might be
> > +		 * illegal in file names (and hence in ref names).
> > +		 *
> > +		 * Note that we retain non-ASCII UTF-8 characters (identified
> > +		 * via the most significant bit). They should be all
> > acceptable
> > +		 * in file names. We do not validate the UTF-8 here, that's
> > not
> > +		 * the job of this function.
> > +		 */
> >   		for (p1 =3D label.buf; *p1; p1++)
> > -			if (isspace(*p1))
> > +			if (!(*p1 & 0x80) && !isalnum(*p1))
> >       *(char *)p1 =3D '-';
>
> I'm sightly concerned that this opens the possibility for unexpected eff=
ects
> if two different labels get sanitized to the same string. I suspect it's
> unlikely to happen in practice but doing something like percent encoding
> non-alphanumeric characters would avoid the problem entirely.

Oh, but we make sure that the labels are unique, via the `label_oid()`
function! Otherwise, we would not be able to label more than one merge
parent ;-)

Ciao,
Dscho

--8323328-2091281358-1567453340=:46--
