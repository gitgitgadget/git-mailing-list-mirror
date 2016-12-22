Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21B771FF76
	for <e@80x24.org>; Thu, 22 Dec 2016 09:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938913AbcLVJjS (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 04:39:18 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:35830 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765208AbcLVJjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 04:39:16 -0500
Received: by mail-io0-f195.google.com with SMTP id f73so28351967ioe.2
        for <git@vger.kernel.org>; Thu, 22 Dec 2016 01:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3koxAYQfn80kXsDv5M1Ea3v4gGS/ROOk8xHEVTXNtL4=;
        b=KosPZxAIzgvFZbUpOEg46u5GDc1UKN4vHeHPc/2BdLnFjlBjDyj4bBx4Cbd0JCjj+L
         rm4fMZuWLq3UitkLeHzYCYui1O57hEVF1NRGHhnr19W0TLh7QmvOKv/3n8uBMTMcXa8A
         8oqbgnI+r5b2pCDeivBPEyRJJI+1Qim3Eq2XYxKbSUaiK61+WZU7Xc/sYsi+tsEr9jMD
         Lnf7UBOEQ/y6/qLsGjoopmFNZ+bFRpdHw1vNC6grBygjhnaPjvbVFbjE9BCEeRGflBFa
         LvjMs/eVzuNa1upUNy23hlSIbhULeqXgn3Rtz6b8ECy+I8vWOKHISOeHZFWh9pbBai6k
         BXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3koxAYQfn80kXsDv5M1Ea3v4gGS/ROOk8xHEVTXNtL4=;
        b=tFXnAOAIHRuC+cQrMsDsB+ZE4//MhwGF79YmwjQVCqQgIzOwu8Qd1JJRSMHTAtod4z
         GbcJnYLbnmfmt/+3TwgPfZjXFkDXTNp7FQHAldGqMrkBuW/YzXDfQriN4Y+LnNtGmOfz
         tx76e7xcOXhoeYCvStjw/zqJ8D6AMIa7gGXrOuilITVS7tYHZSTjfaspcmeDNY+4MHNR
         jt952IOVjp5guCtqgp/ILDJQXdWrox/C+4KLIjuy5hOeuk4Suq4iRk0ZYt8IZB6HuLTU
         CR2d1aN8ttIGqhdpuxjsTqJ7liFu0YRJQKezZ8Q718IyxJxaySGoMdESXx64W2z52RaV
         EeIg==
X-Gm-Message-State: AIkVDXLeO+Pu08iZGqp/Dt5e1XyPCaXqY9higHZo5byGdw5GJ0DhAgJUceqZH9dAmyqLdAm4nviJZ5oD+VTuew==
X-Received: by 10.107.198.136 with SMTP id w130mr6256750iof.19.1482399555460;
 Thu, 22 Dec 2016 01:39:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 22 Dec 2016 01:38:44 -0800 (PST)
In-Reply-To: <xmqqh95yldg4.fsf@gitster.mtv.corp.google.com>
References: <20161220123929.15329-1-pclouds@gmail.com> <xmqqh95yldg4.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 22 Dec 2016 16:38:44 +0700
Message-ID: <CACsJy8A_4N9jrV7JnuHPEX5uMWQ6fojoagzpQ5TPceB+9iAipw@mail.gmail.com>
Subject: Re: [PATCH] log: support 256 colors with --graph=256colors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 21, 2016 at 12:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> diff --git a/graph.c b/graph.c
>> index d4e8519..75375a1 100644
>> --- a/graph.c
>> +++ b/graph.c
>> @@ -78,6 +78,7 @@ static void graph_show_line_prefix(const struct diff_o=
ptions *diffopt)
>>
>>  static const char **column_colors;
>>  static unsigned short column_colors_max;
>> +static int column_colors_step;
>>
>>  void graph_set_column_colors(const char **colors, unsigned short colors=
_max)
>>  {
>> @@ -234,10 +235,24 @@ void graph_setup_line_prefix(struct diff_options *=
diffopt)
>>  }
>>
>>
>> -struct git_graph *graph_init(struct rev_info *opt)
>> +struct git_graph *graph_init_with_options(struct rev_info *opt, const c=
har *arg)
>>  {
>>       struct git_graph *graph =3D xmalloc(sizeof(struct git_graph));
>>
>> +     if (arg && !strcmp(arg, "256colors")) {
>> +             int i, start =3D 17, stop =3D 232;
>> +             column_colors_max =3D stop - start;
>> +             column_colors =3D
>> +                     xmalloc((column_colors_max + 1) * sizeof(*column_c=
olors));
>> +             for (i =3D start; i < stop; i++) {
>> +                     struct strbuf sb =3D STRBUF_INIT;
>> +                     strbuf_addf(&sb, "\033[38;5;%dm", i);
>> +                     column_colors[i - start] =3D strbuf_detach(&sb, NU=
LL);
>> +             }
>> +             column_colors[column_colors_max] =3D xstrdup(GIT_COLOR_RES=
ET);
>> +             /* ignore the closet 16 colors on either side for the next=
 line */
>> +             column_colors_step =3D 16;
>> +     }
>
> So you pre-fill a table of colors with 232-17=3D215 slots.  Is the
> idea that it is a co-prime with column_colors_step which is set to
> 16 so that going over the table with wraparound will cover all its
> elements?

Originally yes (because the next color would be more or less the same,
maybe brighter or darker a bit), then I went fancy with the rand()
thing...

>
>> @@ -382,6 +397,20 @@ static unsigned short graph_get_current_column_colo=
r(const struct git_graph *gra
>>   */
>>  static void graph_increment_column_color(struct git_graph *graph)
>>  {
>> +     if (column_colors_step) {
>> +             static int random_initialized;
>> +             int v;
>> +
>> +             if (!random_initialized) {
>> +                     srand((unsigned int)getpid());
>> +                     random_initialized =3D 1;
>> +             }
>> +             v =3D rand() % (column_colors_max - column_colors_step * 2=
);
>> +             graph->default_column_color +=3D column_colors_step + v;
>> +             graph->default_column_color %=3D column_colors_max;
>> +             return;
>> +     }
>> +
>>       graph->default_column_color =3D (graph->default_column_color + 1) =
%
>>               column_colors_max;
>>  }
>
> This is too ugly to live as-is for two reasons.
>
>  - Do you really need rand()?  Doesn't this frustrate somebody who
>    runs the same "git log" in two terminals in order to view an
>    overly tall graph, expecting both commands that were started with
>    the same set of arguments to paint the same line in the same
>    color?

No we probably don't need rand(). The thinking was.. now that we have
a lot more colors to choose from, let's add some randomness, maybe
it'll reduce the chance of showing the same colors in the same line.

There was another concern with a fixed number of steps too, that we
could get into a stable jump sequence and never use all the colors
(e.g. step 3 with 6 colors total, to simplify). But I verify that
we'll use all the colors (at least until we allow people to customize
step and the number colors)
--=20
Duy
