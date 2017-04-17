Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C80820A04
	for <e@80x24.org>; Mon, 17 Apr 2017 13:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753362AbdDQNAV (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 09:00:21 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36460 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbdDQNAT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 09:00:19 -0400
Received: by mail-oi0-f43.google.com with SMTP id r203so140621369oib.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 06:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SbT1UFbRz+ljknVHfQ3WFSeZBg+Ak24/sP4DPW4SZHU=;
        b=psZDKaxyS1j7VDtHtbasUtEY/IQ9fiFCgxdnjex+AZla9GAyZauikDXUeL5+30fSQ3
         VtiOlewf7hL004xljH00KqGc/JajQKBAMgTpYNJQ+4+cVHTLq+TCTqbMBNyvYjTg+ows
         aI1UiDqQqLrzSgAxaUg/yZ1bamuZI4pF7sskRhAR7U1SoX+vlfYF61h6jK9kjTWBHSqZ
         WEjC/XDNi4npVjrcBZ7PskBubHfce04fTVK+YLIuhsq0LtWuRFEZ0s90PVTecTsJkfrv
         zh9Y0G06AJLAamL8Q6uA6E6hjOV2AVUYPUnVkRNI8vDiTlS7T3I1s17avCvt56iwnPhS
         We5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SbT1UFbRz+ljknVHfQ3WFSeZBg+Ak24/sP4DPW4SZHU=;
        b=W/JYe+d1N8zHRDsplZH3PlnLYQQ8SIhN4yc2HgfqMwhhG0DsrmYD2YoHlH+Z2MyTup
         qTBC0lxNkxvM3zstsj2fJ/2IgnpI9TEgwe/oaVXeZrE/RB5VxiTCEMov5k0/F9D404i4
         MXKEfdnFUP4YV76N7WutGpUr5MRbzFjy4hxbfqDE30luxD9/vDPWk4B6iWqysqV6Hij1
         fvzOBy7KVxkbfGiSgewgWgoCxLQnOuJ7qe8HC4Nj09MTKRQUievSSyvMrRNRBa88QIcy
         BJ9/jr64D0z/A5o0mGWUv1djrvepkTpvQokDUkTe06d3WrbEOr6qUUfW+11re/UR1nLW
         NGsg==
X-Gm-Message-State: AN3rC/5vlRnqfgfbpfPcBgNa2QhhWmPFlYvOdi8BgT2V400UVTU3h243
        KSqZ877Q9b397JcpYuArUmRJXVnalg==
X-Received: by 10.157.46.246 with SMTP id w109mr5361222ota.225.1492434018717;
 Mon, 17 Apr 2017 06:00:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Mon, 17 Apr 2017 05:59:48 -0700 (PDT)
In-Reply-To: <CAJgfmqWf9j=R1=qy-kGTL4+y_40O+8S5q=VZuD3A-DbfRJer2Q@mail.gmail.com>
References: <CAJgfmqU+1Ex1YkP94H2amXV+oqscbQwvb-CueuCiM7-n0AAP8Q@mail.gmail.com>
 <CACBZZX4fDu-o+ERiTyjVq2rWkXK6rjErU4KyW33qMx1_6vjMCQ@mail.gmail.com>
 <xmqqpogblvfr.fsf@gitster.mtv.corp.google.com> <CAJgfmqWf9j=R1=qy-kGTL4+y_40O+8S5q=VZuD3A-DbfRJer2Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 17 Apr 2017 19:59:48 +0700
Message-ID: <CACsJy8BASVSxJ4RzNKVpj9MyD=fMR-fpspMdET1bT45yMrf_0w@mail.gmail.com>
Subject: Re: Feature request: --format=json
To:     "Fred .Flintstone" <eldmannen@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2017 at 7:44 PM, Fred .Flintstone <eldmannen@gmail.com> wrote:
> So I did "git rev-list --all --pretty" and it looks like "git log".
> Which outputs a human-readable format.
>
> However, if I want something more suitable for machine parsing, is
> there any way to get that output?
>
> Example maybe I want another date format like ISO dates, or maybe a
> serializable format like JSON or CSV or something. Maybe I want more
> data than commit, auhor, date, subject and body?

"git cat-file commit <commit-id>" should give you a machine-readable
format of everything (it's the same thing that git-log parses and
shows you; not counting options like --diff, --stat...). <commit-id>
is from rev-list output (without --pretty, that's not for machine
processing). You probably can use "git cat-file --batch" too, just
pipe the whole rev-list output through it. You don't get to choose a
convenient format this way though.
-- 
Duy
