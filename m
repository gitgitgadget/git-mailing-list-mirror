Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D44261F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 15:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbeGLPMY (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 11:12:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:51545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732362AbeGLPMY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 11:12:24 -0400
Received: from [192.168.0.129] ([37.201.195.126]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNqfr-1fjPk90EOJ-007Xwc; Thu, 12
 Jul 2018 17:02:26 +0200
Date:   Thu, 12 Jul 2018 17:02:10 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Vitali Lovich <vlovich@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: rev-parse --show-toplevel broken during exec'ed rebase?
In-Reply-To: <nycvar.QRO.7.76.6.1807121647310.75@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1807121657120.75@tvgsbejvaqbjf.bet>
References: <CAF8PYMjub1KK_ZK0hijTNBACSa6SaFyu1dJgrXd5fJU5Hc_dhg@mail.gmail.com> <CAF8PYMikJZF4Qk4VHhAUPB80LG=gjZBVNBu0yGKCLLPpdG_3sg@mail.gmail.com> <nycvar.QRO.7.76.6.1807121647310.75@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SOdRMChbq068kzReFqGRfYfapUbNbGtNphXpWB4oP/q+Qj9SAtV
 uVkD5tXl8cszy6d9ZKqrcR6pUsZqYP8V5afj9hF9RxI03K6JSFFX2e7N26C4m8IyAlqISAk
 0FSDVhqTkXG9W+txhXL9I0Rbk7iwQYHe8PKCFgmP2pVXyKubDx+tbU74cHSCDjW9aBgjOdC
 w0ikc5J8Ppe/LX1h0SK4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OtlztETGtdI=:GeudrPdXCC9PsCkL3Kr7zV
 hEZS8n6emgN6vfAD1xmkGEyEf0ic/gxMhUF7DxXrQ27bUqY+vU6kFA1JNgKjOvBEr22XFfZKo
 nWTJrMKK9BePpSccJo0LjOGiyZeUdfm2CgID27KZuRMQThkJZXEQdZIUtFvkD7Dh/CDBFB4J5
 uhvr8Q3gPShCSUbDtH7qL6s2IPq3iIHBQGwmlg3DVMG51jAi02ehr5R/4p81uVDW+8jT5+GJk
 E44svJ8FTlzU2MgmxMlmp5hITG3TZfcLWxfcBmpaCUk7tGh/TCRTsSHUdzpyTRVwrf39iGxK1
 Jm2ZsXAjqhBMZ78UtOSI7i2BzHlQH5CAeHGm0QQlVeNmzu/4Sw9e27FTyQxv869kcwhLMOgV/
 +loPXcpfEpqKMCoasAhCgghCvUL29iCSgsxsADhw9P7DkZVhVExXdX8NJ8ajFHt4qhKNLhLu1
 /cn9ijv5cvWQ5ba0FPQnB5lXDb7gHgloJrnlFDE5ZhVe64rWO8Z2QnZmkUzbfENx90mClHzt9
 iwAvMcKlxLDPjnZEWihfO4LCd7JxVPS2RTlbyYIM33d4ZMVqOR5Od0EUmhPE6xp1v9ExMhZCl
 0KAUhG2d7U8GAl5aPEwMQ37dWomrtfSBGTxk5LgWyYwzZdUOe3WjPQnXd7DWEsFWdRmshpIoI
 cuoXti/gpFAqPLQOLyQ7oIWy9vpRbxm72tNsGdd3fLHVmXmx/CGVBgscSeO/Lk1Vgn5vqHLbd
 teWEJ8SJSqyUpT4GD3BS3rz1l5g1ZThKKw3O3+qUm8uO3GbSQeipPH/oQyqSDIaDxYB6jBmWW
 xVHikYb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 12 Jul 2018, Johannes Schindelin wrote:

> On Wed, 11 Jul 2018, Vitali Lovich wrote:
> 
> > On Wed, Jul 11, 2018 at 7:50 PM Vitali Lovich <vlovich@gmail.com> wrote:
> > >
> > > Typically git rev-parse --show-toplevel prints the folder containing
> > > the .git folder regardless what subdirectory one is in.  One exception
> > > I have found is that if one is within the context of git rebase --exec
> > > then show-toplevel always just prints the current directory it's
> > > running from.
> > >
> > > Repro (starting with cwd within git project):
> > > > (cd xdiff; git rev-parse --show-toplevel)
> > > ... path to git repository
> > > > git rebase -i 18404434bf406f6a6f892ed73320c5cf9cc187dd
> > > # Stop at some commit for editing
> > > > (cd xdiff; git rev-parse --show-toplevel)
> > > ... path to git repository
> > > > git rebase 18404434bf406f6a6f892ed73320c5cf9cc187dd -x "(cd xdiff; git rev-parse --show-toplevel)"
> > > ... path to git repository/xdiff !!!
> > >
> > > This seems like incorrect behaviour to me since it's a weird
> > > inconsistency (even with other rebase contexts) & the documentation
> > > says "Show the absolute path of the top-level directory." with no
> > > caveats.
> >
> > Sorry.  Forgot to include the git versions I tested with (2.13.1,
> > 2.17.0, 2.18.0)
> 
> This is actually not so much a bug in `rebase` as in `rev-parse
> --show-top-level`:
> 
> 	$ GIT_DIR=$PWD/.git git -C xdiff rev-parse --show-toplevel
> 	C:/git-sdk-64/usr/src/git/xdiff

And the reason for this behavior is that setting `GIT_DIR` explicitly
makes Git *always* consider the current working directory to be the
top-level directory:

	https://github.com/git/git/blob/v2.18.0/setup.c#L1061-L1063

I wonder whether changing the line
(https://github.com/git/git/blob/v2.18.0/sequencer.c#L2635)

   argv_array_pushf(&child_env, "GIT_DIR=%s", absolute_path(get_git_dir()));

to

   argv_array_push(&child_env, "GIT_DIR");

breaks anything (and whether it fixes the bug you demonstrated via
`rev-parse --show-toplevel`).

Ciao,
Johannes
