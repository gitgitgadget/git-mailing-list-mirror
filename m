Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35F1D1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 09:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeDUJjX (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 05:39:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:54065 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbeDUJjW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 05:39:22 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M96Jd-1fHHmY03PJ-00CRft; Sat, 21
 Apr 2018 11:39:15 +0200
Date:   Sat, 21 Apr 2018 11:39:12 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 01/11] argv_array: offer to split a string by
 whitespace
In-Reply-To: <CAGZ79kaH9RWJ=bK=6tEOt2nXjXopC=uxasH6NUUASieRHL7giA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804211138230.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524125760.git.johannes.schindelin@gmx.de> <cover.1524262793.git.johannes.schindelin@gmx.de> <8171fd3920846e37c9f1cab6f1ac658dbfb01bfe.1524262793.git.johannes.schindelin@gmx.de>
 <CAGZ79kaH9RWJ=bK=6tEOt2nXjXopC=uxasH6NUUASieRHL7giA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eSBEv8C+IYqCN3pQAxs0UcLJ41aYfuG3aMvMaHIEJU1fkIeFB5m
 8SLSHVPOxrNpXgDQw1BQ3bOjL58jnQUG7emCtDVf21gZlPE0j2ThyQilPrzuVdGBAkAJjw9
 nVaKgyyOUL7lgGLGIPmxvuOTxwFKRG61llzj2lUYZZwhUuOTYMHeC0XcQXPGvrQkmWWIq2Y
 FbfAKP0v6QxA42xSuujMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5Hi4f7DYXRg=:1PfeRp3MOe0lq2bDUb3Wvf
 ABzHz9d2REsiA9ka0jpg500r0MTy6bybN6hJwk231SDlXnnkIEFyYCs9c3PROUmllWIKO1ibh
 BdspPbfg58IJgoImXFeD0O5nsuUYU8D8zLdwB2aQzZCwWSHXtiT0Bov5s+XGq0AuwC33ixAOh
 iI9nqZ1DKbgRv47ZChzgk+OtdMWUiR9WFPAixuoacfOEPYdeLameFWcJZZjAf9ulF2aBR5x68
 fmLKkH/ELwFrk+rIZ2zohoQm5AWQmKiKW/tB0eirqf0kARX5wxHHMDodOOip00DQz1+DGPwOt
 wm721+tqupD8/xyJFeSHs7AsiN+x8pDnAlMS/sXdz4rEROk2/N3wV9X5GDwtdNnmTL0jdJVKG
 bGAYGv38AT4bqm8OivZpG9LamcFsIsdZ/DzAyNl7t8aSi5XQ8zVL8cXeRCiZNr+FYHN4QyMAy
 Cb6RgtHrYmssJTF//nlv7ZnGfe/18+SYmVeW5Amz1xHBwZG4jhVesTiBTx9xb43xR5xwZShAC
 1RicYHCmuF/2lOF4HCf659WcrLKggbm5wd/Wn7OzSShjXQQgKXIT8sLKQWh3dcaH1ZD7R+dZK
 b8vPJr0JcCQV5Vi90YXh3GGqbxYZWKCZdiorQJqnVoUKKTR1nYurzQIJ4uRHl9vFEaVkkjVSc
 DJxH8A1548JroWRBwygA0XuPsRgeNrHBHsPZd3FrAYVRVRx0I5K06zMK85iXfcpGXrRhGRmtW
 ninVV4g5IHgq1M2Kysntp+e4bc0qo8tKhdgsCx58ZBIt3wo+arOzrUt60K/A5/caZsuj7TpvK
 LF1c3RWTwtW7byMszQW3gOvVbSMTCHACDzFkZ+cWk0Y3EZiHhc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 20 Apr 2018, Stefan Beller wrote:

> On Fri, Apr 20, 2018 at 3:20 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > This is a simple function that will interpret a string as a whitespace
> > delimited list of values, and add those values into the array.
> >
> > Note: this function does not (yet) offer to split by arbitrary delimiters,
> > or keep empty values in case of runs of whitespace, or de-quote Unix shell
> > style. All fo this functionality can be added later, when and if needed.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  argv-array.c | 20 ++++++++++++++++++++
> >  argv-array.h |  1 +
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/argv-array.c b/argv-array.c
> > index 5d370fa3366..cb5bcd2c064 100644
> > --- a/argv-array.c
> > +++ b/argv-array.c
> > @@ -64,6 +64,26 @@ void argv_array_pop(struct argv_array *array)
> >         array->argc--;
> >  }
> >
> > +void argv_array_split(struct argv_array *array, const char *to_split)
> > +{
> > +       while (isspace(*to_split))
> > +               to_split++;
> > +       for (;;) {
> > +               const char *p = to_split;
> > +
> > +               if (!*p)
> > +                       break;
> > +
> > +               while (*p && !isspace(*p))
> > +                       p++;
> > +               argv_array_push_nodup(array, xstrndup(to_split, p - to_split));
> > +
> > +               while (isspace(*p))
> > +                       p++;
> > +               to_split = p;
> > +       }
> > +}
> 
> The code looks correct to me.
> 
> Though this seems so low level, that I find it hard to accept
> to implement yet another low level split function.
> Would reuse of strbuf_split or string_list_split make sense?
> 
> Looking at the user in patch 5 you really want to have the
> argv array, though, so it cannot be pushed to an even higher
> abstraction layer and be solved there. You really want a
> string -> argv array split, which would mean we'd have to
> do the split via string -> {strbufs, stringlist} and then perform
> a conversion from that to argv array and both conversions
> look ugly as we'd need to iterate their specific data structure
> and push each element itself again.

Maybe we could reconcile all of this by introducing yet another layer of
indirection? I am wary of this, as I tend to think that layers of
indirection make things tedious to debug.

But I could imagine that we could introduce something like

    typedef int (*split_string_fn)(const char *item, size_t len, void *data);
    int split_string(const char *string, int delimiter, int maxsplit,
		     split_string_fn fn, void *fn_data);

And then argv_array_split() would be implemented like this:

    struct argv_array_split_data {
	struct argv_array *array;
    };

    static int argv_array_split_fn(const char *item, size_t len, void *data)
    {
	struct argv_array *array =
	    ((struct argv_array_split_data *)data)->array;
	argv_array_push_nodup(array, xstrndup(item, len));
	return 0;
    }

    void argv_array_split(struct argv_array *array, const char *string,
			  int delimiter, int maxsplit)
    {
	struct argv_array_split_data data;
	data.array = array;
	split_string(string, delimiter, maxsplit, argv_array_split_fn, &data);
    }

Possible? Yes. Desirable? Dunno. Looks like a lot of effort for little
gain so far.

> So I guess we rather implement it yet another time.
> 
> Looking at their function declarations:
> 
> /*
>  * lots of very good comments for string list splitting
>  */
> int string_list_split(struct string_list *list, const char *string,
>           int delim, int maxsplit);
> 
> /*
>  * lots of very good comments for strbuf splitting
>  */
> static inline struct strbuf **strbuf_split(const struct strbuf *sb,
>            int terminator)
> 
> I find they have comments in common as well as the
> terminator. In the commit message you defer the
> implementation of a terminating symbol, as we
> can do it later. Also the isspace takes more than one
> delimiter, which the others do not.
> 
> I am debating myself if I want to ask for a comment, as
> argv-array.h is very short for now and it would be consistent
> not to add a comment.

That was my thinking.

And I thought further: once argv_array_split() becomes more complex, we
would need to consider again whether we want that level of indirection
(and consolidation), and then also whether we need a comment.

On the other hand, argv_array's name suggests that it handles
command-lines, so I think you are correct that at least a little comment
is needed to state that this does not handle quoted arguments.

Ciao,
Dscho
