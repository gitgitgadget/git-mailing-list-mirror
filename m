Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 891551F97E
	for <e@80x24.org>; Fri, 23 Nov 2018 10:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393859AbeKWU5X (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 15:57:23 -0500
Received: from mout.gmx.net ([212.227.15.15]:60043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390102AbeKWU5X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 15:57:23 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTSKd-1fxmUK2u2R-00SM2C; Fri, 23
 Nov 2018 11:13:43 +0100
Date:   Fri, 23 Nov 2018 11:13:44 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pranit Bauva <pranit.bauva@gmail.com>
cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v16 Part II 2/8] bisect--helper: `bisect_write` shell
 function in C
In-Reply-To: <CAFZEwPP7dkWwRJD2ohDfnV_Phb0ga7YPZoVC920JPrQXLAGekw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811231111030.41@tvgsbejvaqbjf.bet>
References: <0102015f5e5ee22c-ea9c3a38-5d42-4dce-a54b-45c59768a70b-000000@eu-west-1.amazonses.com> <20171027172845.15437-1-martin.agren@gmail.com> <CAFZEwPP7dkWwRJD2ohDfnV_Phb0ga7YPZoVC920JPrQXLAGekw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1806073205-1542968025=:41"
X-Provags-ID: V03:K1:WmVp1LysUDeFV/8YjLcIgV3Kt3idMpWIk58apN07K6jcUQSaoGh
 U94TwY92FcuqwAQTlQ0IMgirP0OVjT+IN3lAwQ03AI7eDQVOtu/d7aXkDSz7kbS7t6fXINi
 je5W9KDbK+R7diH5qJ+cIT96YpE8U9+WzQnliLnCoGVg+S2sYYi/qy43UWMZwzHM5fDqzxJ
 69Fw5rFpEw0eXsP+4ZILQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k7UoSMxuT+M=:XsFdS1EpbGWqOPYwo1pdnB
 yyAumCxKp/o36Krq5z/BD9pj0+8xZw398+0nRjU1RZ+ofdTDPqXr6zAOut+5EfaZglQpRFUcv
 Ut8ffWYzrNtJ0xu7kXI5RhFh9MwpkG6Wo0LKYZDOZ4DYrUAjlkLu9Xl+tFbbuGlVBNYdJLpBG
 LFq2zD2wjtpIWjzpUB1BwMgWn8+URsCwBTKUXyWeWzzR56DB36DZtpU8vd+oyrv9GSqkmkiGz
 oIY/OXgZhQXj2tHbKHc9a3uCbsnYjyTKtORVPxZWhDswaeh6AxQO7C3aDiJSw41YVBtHrQ94k
 x91GnlnukLVU8jqedJ1fxzaB+yuAgQhkpe3TQeivUHJcjhAdpMelwiiwYVaTo+YtghBER8yOb
 VTjRcNIfpmkb49J32Wciume/f+SV+TC+7rZKeUpcQC9KSQhAEh15lUdxz909JFHTibt+qwBLN
 nc3rd9MJIA+eyWeAe6VpJ5wWt9w0yo4JV1jRPtpV8g/ltu7RkroDUP7f1K4H3/h39+6zXlJ4q
 upMJI7QA7H6SjaVzC+mFWRgp2b9L7b8q7Q6kJLGeQS7q5hyBTkIDnpojFR2+IPQRGYV6BilsA
 SuLgre79FbAsKnEFQSa139jHJO1Qvey+vFYUY17XrH2iLtwxvMzA+emDHCSc6ikvEoi5KpaFf
 cj68tlwZZXS6WLj2mQ+6HK92xkjlEyj4keZEm4P+KurIQ1Y9pGi68CtmOnCvnga5jEIlokUK4
 ojOUVvwXzNv7iNiXmPqUpNLlthfor1Gr/G7oGhfFo3ZkTnTnEZHWkP9pecRe8USU4gUqQhSwF
 CjSqEpPYDWzBWNwUx2sKmF+UtNNJc7q5JRp84JKBYdayH9e2BfHnFXCyz0bLlOd7EF4GTSUAI
 nk2VAULJ6SnIuMLVPELo2NzhXIvlhWVMbhPHKRZEtASUf8caAh3lT14IIPTs/z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1806073205-1542968025=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Pranit,

(Cc:ing Tanushree because they will try to pick up this patch series as
part of the Outreachy program.)

On Mon, 30 Oct 2017, Pranit Bauva wrote:

> On Fri, Oct 27, 2017 at 10:58 PM, Martin Ågren <martin.agren@gmail.com> wrote:
> > On 27 October 2017 at 17:06, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> >> +static void free_terms(struct bisect_terms *terms)
> >> +{
> >> +       if (!terms->term_good)
> >> +               free((void *) terms->term_good);
> >> +       if (!terms->term_bad)
> >> +               free((void *) terms->term_bad);
> >> +}
> >
> > These look like no-ops. Remove `!` for correctness, or `if (...)` for
> > simplicity, since `free()` can handle NULL.
> 
> I probably forgot to do this here. I will make the change.
> 
> > You leave the pointers dangling, but you're ok for now since this is the
> > last thing that happens in `cmd_bisect__helper()`. Your later patches
> > add more users, but they're also ok, since they immediately assign new
> > values.
> >
> > In case you (and others) find it useful, the below is a patch I've been
> > sitting on for a while as part of a series to plug various memory-leaks.
> > `FREE_AND_NULL_CONST()` would be useful in precisely these situations.
> 
> Honestly, I wouldn't be the best person to judge this.

Git's source code implicitly assumes that any `const` pointer refers to
memory owned by another code path. It is therefore probably not a good
idea to encourage `free()`ing a `const` pointer.

Which brings me back to the question: who really owns that allocated
memory to which `term_good` and `term_bad` refer?

Ciao,
Johannes
--8323328-1806073205-1542968025=:41--
