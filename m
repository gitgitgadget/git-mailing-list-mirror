Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96A3620281
	for <e@80x24.org>; Wed, 20 Sep 2017 21:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbdITVQd (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 17:16:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:59355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751396AbdITVQb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 17:16:31 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lu7a2-1dDA4w2DFW-011W1U; Wed, 20
 Sep 2017 23:16:20 +0200
Date:   Wed, 20 Sep 2017 23:16:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     git@vger.kernel.org, Ben Peart <Ben.Peart@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH] Win32: simplify loading of DLL functions
In-Reply-To: <20170919180742.GC75068@aiede.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1709202235300.219280@virtualbox>
References: <f5a3add27206df3e7f39efeac8a3c3b47f2b79f2.1505834586.git.johannes.schindelin@gmx.de> <20170919180742.GC75068@aiede.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pGniOkCqnZeasLLSdhH3Mt0jb/8tC0I0PnqaKcH4bem+lNZSlQa
 c1cHqDo71rLd32ssPn1I+N0dYz2VYSWtQJvWeg6DOvUCQaOMOVhFB+ZFStx52XgnGC7dJxe
 EqvhQbsbt8OOCWnuUwcQYa01IHmbxf0gQmuVaqNPId/eifHBBOJJU8R9fb6i08UKbuPEaza
 x/uApN6wk9tsjIodSn+/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CmaUv7oqfkk=:WkJ6sR9yArzyiuFOdJlK1I
 mq2HZbGnbYHIXXhPAq550uzHPyJoF2xP1hbNW1kBP6/vz+Dl/R8o+8v4ZUCPGeA9/Vo/HYNgn
 9uFxtU7pmdq2ZuN+J/1y6Xo94V6oowale077yfR74UhVauUHdElTckdKxV7xBrhDXw3tfwJm6
 lmSu2VaWQqRkA7kDCfqAsHs2+TjvZHo1dQ9GecqncAyksJ9u5CHR56RHk0sffc7F8fmVqqqD2
 wRWVAeAJJ3lwsUvE9WFQJ375NcTrmOJMCzw37y0iLUR5fVrx4FfEv2ucCnWHzoy2oF3uCiv7c
 YowkhA9Kn6GH3PlBamKZplSfO5VBjDhS1Tt3AtHtM6YszAk2M1hfMNLTOfbjQu8UdKshv4kBs
 DeGRWvIRYogE7Cs2PVzr6NV1E2SilLOMbhBImn1OTt5ylyYBL0Z1r6WFo/t203vovLXVJMoxX
 5yuzgqGl4GRbXdv7AC4e25fnCcvj034pUlSwt/o9zsKXgUYy93+uXv8NDicAEH62wO6KHTCYq
 1Qp2OsOrSr3AC8APDQwavX/jtc1VVrayKKspK3aflGKq3feoOi2HQTqth+K+KLnXnC35fIuTF
 W0/hI3MLh0WyCoCvBnaFVMG97npk1J8Q3nK3tCneF8RESjaH+3lsHDJPGTA8B8Uhhy/P0xce1
 Fa5n6nznyq8WilFWVj1ohsQvEV3W48mxr6j4bwn+unzb8wXEtbc453tfUjS+cgHP3JvzzF47W
 EpQp2bfeXgUpwJcUuhydq/4eQf0nWVrjq/eIyrcf7brDg2niP8Yc3OnUsHMJ8395vWSDSN4VJ
 NcxNVa+Yp/2NDwjrjhSqKZYGBQ0rbr4YTGRNAmEkQHI8/rkVdw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Tue, 19 Sep 2017, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> 
> > Dynamic loading of DLL functions is duplicated in several places in Git
> > for Windows' source code.
> >
> > This patch adds a pair of macros to simplify the process: the
> > DECLARE_PROC_ADDR(<dll>, <return-type>, <function-name>,
> > ...<function-parameter-types>...) macro to be used at the beginning of a
> > code block, and the INIT_PROC_ADDR(<function-name>) macro to call before
> > using the declared function. The return value of the INIT_PROC_ADDR()
> > call has to be checked; If it is NULL, the function was not found in the
> > specified DLL.
> >
> > Example:
> >
> >         DECLARE_PROC_ADDR(kernel32.dll, BOOL, CreateHardLinkW,
> >                           LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);
> >
> >         if (!INIT_PROC_ADDR(CreateHardLinkW))
> >                 return error("Could not find CreateHardLinkW() function";
> >
> > 	if (!CreateHardLinkW(source, target, NULL))
> > 		return error("could not create hardlink from %S to %S",
> > 			     source, target);
> > 	return 0;
> 
> nit: whitespace is a bit strange here (mixture of tabs and spaces).

Heh, I never thought that this would be a problem in *commit messages*.
TBH I simply copy-edited the code from Git for Windows' source code.

> Could this example go near the top of the header instead?  That way,
> it's easier for people reading the header to see how to use it.

Funny, I am *so* used to examples being at the very end, from tutorials to
man pages.

If my experience is any indication, I would rather keep this order.

> > Signed-off-by: Karsten Blees <blees@dcon.de>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> Just curious: what was Karsten's contribution?

Essentially all of the code. I just moved it around, separated it out from
the patch introducing it, used it elsewhere (e.g. in compat/poll/, not yet
contributed to git/git) and replaced the LoadLibrary() call by
LoadLibraryEx() for more precise control over the operation.

> (I ask mostly because I'm interested in kinds of collaboration git
> metadata is failing to capture correctly --- e.g. pair programming.)

Well, then I have this challenge for you: make use of the history of Git
for Windows' master branch. It is rebased to git/git's maint (or for .0
versions, master) using the "merging rebase" strategy (i.e. first merging
the to-be-rebased history using the "ours" strategy, then applying the
patches on top, so that the previous commit history is part of the new
history, yet there are still rebased patches ready to be prepared for
submission to git/git). This strategy means that multiple versions of the
same patches exist.

> >         So far, there are no users (except in Git for Windows). Ben
> >         promised to make use of it in his fsmonitor patch series.
> >
> >  compat/win32/lazyload.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 compat/win32/lazyload.h
> 
> Are any of the Git for Windows users something that could go upstream
> along with this patch?  That would help illustrate what a good caller
> looks like, which should help with reviewing future patches that use
> this code.

I do not currently have the time to do that, that's why I did not
accompany the patch by any user.

However, having said that, Ben's patch series will make for an *excellent*
user, fulfilling your wish.

> > --- /dev/null
> > +++ b/compat/win32/lazyload.h
> > @@ -0,0 +1,44 @@
> [...]
> > +/* Declares a function to be loaded dynamically from a DLL. */
> > +#define DECLARE_PROC_ADDR(dll, rettype, function, ...) \
> > +	static struct proc_addr proc_addr_##function = \
> > +	{ #dll, #function, NULL, 0 }; \
> > +	static rettype (WINAPI *function)(__VA_ARGS__)
> > +
> > +/*
> > + * Loads a function from a DLL (once-only).
> > + * Returns non-NULL function pointer on success.
> > + * Returns NULL + errno == ENOSYS on failure.
> > + */
> > +#define INIT_PROC_ADDR(function) \
> > +	(function = get_proc_addr(&proc_addr_##function))
> 
> Probably worth mentioning in the doc comment that this is not thread
> safe, so a caller that wants to lazy-init in a threaded context is
> responsible for doing their own locking.

True.

> > +static inline void *get_proc_addr(struct proc_addr *proc)
> > +{
> > +	/* only do this once */
> > +	if (!proc->initialized) {
> > +		HANDLE hnd;
> > +		proc->initialized = 1;
> > +		hnd = LoadLibraryExA(proc->dll, NULL,
> > +				     LOAD_LIBRARY_SEARCH_SYSTEM32);
> > +		if (hnd)
> > +			proc->pfunction = GetProcAddress(hnd, proc->function);
> > +	}
> > +	/* set ENOSYS if DLL or function was not found */
> > +	if (!proc->pfunction)
> > +		errno = ENOSYS;
> > +	return proc->pfunction;
> > +}
> 
> strerror(ENOSYS) is "Function not implemented".  Cute.
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Okay, I'll add that for v2. Will wait a couple of days in case more stuff
crops up.

Ciao,
Dscho
