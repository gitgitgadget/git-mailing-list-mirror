Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C1B1FC96
	for <e@80x24.org>; Thu,  8 Dec 2016 07:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbcLHH4N (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 02:56:13 -0500
Received: from mout.web.de ([212.227.15.3]:55153 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbcLHH4M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 02:56:12 -0500
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0McT8i-1bxMhp2wUa-00Hgmi; Thu, 08
 Dec 2016 08:55:57 +0100
Date:   Thu, 8 Dec 2016 07:55:55 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com
Subject: Re: [PATCH] real_path: make real_path thread-safe
Message-ID: <20161208075555.GA23595@tb-raspi>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1480964316-99305-2-git-send-email-bmwill@google.com>
 <xmqqtwagy65q.fsf@gitster.mtv.corp.google.com>
 <20161207001018.GD103573@google.com>
 <b73e61f8-0cff-b33e-118a-e530d367c94c@ramsayjones.plus.com>
 <20161207201409.GA19743@tb-raspi>
 <xmqqtwafwkdt.fsf@gitster.mtv.corp.google.com>
 <20161207221335.GA116201@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161207221335.GA116201@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:TEManvPY8JH2MHMjOENBLbi5z2kvQpazLjcW0IBJEFg6Jh+0tv1
 Pj5xSje/Kql2NAhWt0cKPZ+BjH6IrvUPzULqxa67cU2C/+slQczjCM9RCrcaEOPACQ3Xf5x
 bgFjMuGXQPKYojqoZR1QphMSNNq6nWLzkmMrC+L2yRO/wiUJbOSAA7sUDUSWj9RGUavl4OP
 3pjh96JJIExT8OIPv15Dw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2q9PTf/AhFQ=:MZAIyFqczyLYB9t77U1S6I
 bDBZzg4QZzm5GAWeBa7QlDYWKzKvqkRlT8AjOmwWu+lxvVJm1iE9cYGGQqV2Zi94s3foRS45U
 QDk6HOJicGM223/6jMfnB7cIqu2WsRaPa8injlRro6kP9RJaoSekuWcOb22RtnvTB7eMeg33v
 En5iQbST4WgCGxqus49fLSyuyTw/XfLU5L1RFqOMD+A7MtwZTQs0Gi3whnrpyHfuXzYtBu8Et
 sqCvv7CUNz+o7FLPbtgniXdI1LGlf5K/PZjUjm9BagspcT6q+xKeewKsITeZGEB5A1pvayZyK
 /ozCq/Zkb0zU01CzmhVOCU/gqK8MzLuURU49aXfXoQlHVesHfWRbtrgHdj1SChS+SH3syLiWx
 gd47KLNCvuKWp9WaQcHFsCP5dSVZFtLGosegVJ/hNvUp92417NXT1zhOGqz6Cn11M29jsOTG0
 cDZzmhtQ49C59iNYZmT0V+1MZmOau9BV/n/ljMYS+VXLwP+fW7hQqp3PJu2ad2HYbM8mURwTF
 ex/Gzi6389wNUZjGp5kB5b3Sr3FyfY2bQWK05pVcR33uMH5HJ7jAZRG7gYs+dKSRZKxKZT9oO
 tyuW86VHcGLCanGFdk7EaSwWHgIpeLVfIONdZ6stuBVYKLtDltovXZuYeyJvqiOFZpJIHb9Qp
 WkdLXorrHqAQPMcptPJcGLw6pEgyyK2qRcYHOzhONGyinFA68HyfDww2kEcA/s2SuE2BbewYU
 unvT+2N1B0zEIOMSMvOIhjnM7u5WmOd9MK8iEn//l78P8VzO64dGtcCcXuI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 07, 2016 at 02:13:35PM -0800, Brandon Williams wrote:
> On 12/07, Junio C Hamano wrote:
> > Torsten Bögershausen <tboegi@web.de> writes:
> > 
> > > But in any case it seems that e.g.
> > > //SEFVER/SHARE/DIR1/DIR2/..
> > > must be converted into
> > > //SEFVER/SHARE/DIR1
> > >
> > > and 
> > > \\SEFVER\SHARE\DIR1\DIR2\..
> > > must be converted into
> > > \\SEFVER\SHARE\DIR1
> > 
> > Additional questions that may be interesting are:
> > 
> >     //A/B/../C		is it //A/C?  is it an error?
Yes, at least under Windows.
If I have e.g. a Raspi with SAMBA, I can put a git Repository here: 

//raspi/torsten/projects/git
If I use
git push //raspi/torsten/../junio/projects/git
that should be an error.

> >     //A/B/../../C/D	is it //C/D?  is it an error?
> > 

Same for
git push /raspi/../raspi2/torsten//projects/git


> 
> 
> Also is //.. the same as //?  I would assume so since /.. is /
> 
Under Windows //.. is simply illegal, I would say.
The documentation here
https://msdn.microsoft.com/en-us/library/windows/desktop/aa365247(v=vs.85).aspx

Mentions these 2 examples, what to feed into the WIN32 file API:

a)
\\?\D:\very-long-path

b)
\\server\share\path\file"

c)
"\\?\UNC\server\share\path" 

So whatever we do, the ".." resoltion is only allowed to look at 
"very-long-path" or "path".

Some conversion may be done in mingw.c:
https://github.com/github/git-msysgit/blob/master/compat/mingw.c
So what I understand, '/' in Git are already converted into '\' if needed ?

It seams that we may wnat a function get_start_of_path(uncpath),
which returns:

get_start_of_path_win("//?/D:/very-long-path")         "/very-long-path" 
get_start_of_path_win("//server/share/path/file")      "/path/file"
get_start_of_path_win("//?/UNC/server/share/path")     "/path"
(I don't know if we need the variant with '\', but is would'n hurt):
get_start_of_path_win("\\\\?\\D:\\very-long-path")         "\\very-long-path" 
get_start_of_path_win("\\\\server\\share\\path\\file")      "\\path\\file"
get_start_of_path_win("\\\\?\\UNC\\server\\share\\path")     "\\path"

Then the non-windows version could simply return
get_start_of_path_non_win(something)     something

Does this make sense ?


 


