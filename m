Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D3AE207B3
	for <e@80x24.org>; Fri,  5 May 2017 22:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbdEEWKA (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 18:10:00 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33152 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbdEEWJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 18:09:59 -0400
Received: by mail-io0-f194.google.com with SMTP id l196so4116427ioe.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 15:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nxsCiqYwj+5QLb8jpRm8FbL01iL4tqMtIWSS8MeMEMU=;
        b=pgSYtHVbQ0U2OrtjtHC/alZi8x/8P1QS6E4ryuZjHzi5OAYwXS/l8Gqf/xcDOg2Y6W
         2FD0EbkW1MUOMtbb3ylV5SGAjixTUFGfZV+a9y3CiGcY6LMpNaE/qM9J+7uoE6iah7Ql
         NspiLojnOWKbQA+daBYmJHdubDN1sBYjLXo2dSI5g8Rn5lGSwjTjcIjQardZyIn7xpxV
         PCAvibMmBOhfRcbnnSQbn+CrTfC5qtplfl9MH2dxdVGuPXXx7e83s6oJWFcnSUjOby3F
         LwNS7QLZC560nUvhFHwMwM8q3qKxX1oj1gKYGgCuRw+LSZTh7FHwZPG54ChVXhjAyHwn
         x/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nxsCiqYwj+5QLb8jpRm8FbL01iL4tqMtIWSS8MeMEMU=;
        b=olXN3WnVsj99IYJMw4GPGxmyU/Tu62/C6R/q/DfaCaJXr7Sz4Ke//o+TC6G5IaRE4C
         GAJ/MHAZvPe66F+U9NbDY1VG29Lu3gtbldJCCpzZ81SlqI49DpZ8XWYCf8JOI6SaMX9I
         wmhGgIv3QmVrLSwXnjNARQ0JEY/O676fEoRa4btn13d2Nb8UnhmDpmueQ/ucMXgfSRdB
         YJEdMeu7iTl0OTk2Q4YU0MKXr4odzHBTRlxdRbgtjo+0fjN/Dae6U5uYbgqmk3ZeiyLH
         zJaFVQMCZo5Owde/n1j4cPRLcHgOjSi1dP4hBh79wJCpNjMyVhE87PpYw1MO3/vRjjYf
         uIOg==
X-Gm-Message-State: AN3rC/6SjNkKj5PDqkyXNT0Nr4/Vy+FiFaZ/RNuB+3EqoBZocBqfxOKq
        M9FZ6/oyx0SkaNTChoXCkljFdx1b2w==
X-Received: by 10.107.178.129 with SMTP id b123mr45829308iof.50.1494022198954;
 Fri, 05 May 2017 15:09:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 5 May 2017 15:09:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1705052320270.146734@virtualbox>
References: <1494009820-2090-3-git-send-email-bnmvco@gmail.com>
 <20170505201621.25560-1-avarab@gmail.com> <alpine.DEB.2.21.1.1705052320270.146734@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 6 May 2017 00:09:38 +0200
Message-ID: <CACBZZX7LgTLHprSoc5ng47GO8vv+HLJXcu7a+bTkR5kB=NfUjg@mail.gmail.com>
Subject: Re: [PATCH 2/3] add--interactive: add builtin helper for interactive add
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniel Ferreira <bnmvco@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 5, 2017 at 11:21 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 5 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>  int cmd_add_interactive__helper(int argc, const char **argv, const char=
 *prefix)
>>  {
>> -     int i, found_opt =3D 0;
>> -
>> -     git_config(git_add_interactive_config, NULL);
>> +     int opt_status =3D 0;
>>
>> -     for (i =3D 1; i < argc; i++) {
>> -             const char *arg =3D argv[i];
>> +     struct option options[] =3D {
>> +             OPT_BOOL(0, "status", &opt_status,
>> +                      N_("print status information with diffstat")),
>
> Please use OPT_CMDMODE() instead; it was invented exactly for this kind o=
f
> scenario.

Indeed. Forgot about that. That's much better.

>> --
>> 2.11.0
>
> Really? ;-)

CC-ing the Debian stretch release team with your complaint [not really].

I don't bother to 'make install' the git I'm hacking on, so E-Mail
gets sent with whatever's in Debian testing.
