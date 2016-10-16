Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B6F81F4F8
	for <e@80x24.org>; Sun, 16 Oct 2016 08:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751601AbcJPIEO (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 04:04:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:52404 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbcJPIEK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 04:04:10 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MQeET-1cP95z3smD-00U248; Sun, 16 Oct 2016 10:03:50
 +0200
Date:   Sun, 16 Oct 2016 10:03:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v10 04/14] run-command: add clean_on_exit_handler
In-Reply-To: <9C686FFB-CB07-445E-B812-97781CAB113D@gmail.com>
Message-ID: <alpine.DEB.2.20.1610161003040.197091@virtualbox>
References: <20161008112530.15506-1-larsxschneider@gmail.com> <20161008112530.15506-5-larsxschneider@gmail.com> <alpine.DEB.2.20.1610111407080.3492@virtualbox> <9C686FFB-CB07-445E-B812-97781CAB113D@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZHxCnBcNnIgvo6jOU2jg3+XEI+3EXCng3yLeu+KW2EQOabKMac0
 FAtyh+16wrGKEUxpx0KsJMRv+Bv9LCsmuI8dSYGgGLarClDIPrD8Zr+gVZvwAG/ShaXurqj
 0HZLJ7btFUnrkxl+uONVkadHHyfD3t59NI7n72ZXyPC0nV0+cLHdouCr6e+MT6is9lCYEkX
 Sar0BiRRRiiEytAiP649g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RgNWAq0BhTw=:Sm1ptq2jnKoHfNRKi1esrm
 dk/PgezZP3IwDzocrD/KvctFf4XpfEgaRu5RWfJ3iQ5ubK4pxGjw/OgEgHYhYsCOpKsFUnI5a
 TdOMuvVSMaNQzJk7JdPfAEV5fMyjTcQAxKw0lJ6gMx+ALCKGla5p54BRqfXCpMtcVDnh+iJwD
 2nnrztu4J7dzSGyC+h6vHGCJkDOxakks4+THUYRpz4SZnlmqFfkTH2VmROxcumoVyQsBjGv5W
 vKpj/57XJh86Dcu3KjVlfnNZzQct3yKd+ke5HIWQxazmA37Bg/cYrFReemT+HQL1jgnNYcpuf
 0jgJl4l0vBCeLfy32lF+MdLn6Pkmgork//oQHmyQ29qOHM3YjkRe1z8ordjuV3YX6c9ssrP4Y
 1Ac0MCh2xHFHzrqfmYgkNO9Ou5OkZMC3Pj3jpUi9Zznyhu6jKI0AG6WRAsnCOJPGAdcfY+KMy
 Xo6a8JJAEXOfrBOSvDGQkL/7LK7eD+E3BheRTw6m6egcaWc/NC2jat9gWTXgOZFZC7M2DgerZ
 n0nLSQxZk2HP7KZ9jXzQ1coQEBK7sKTYEbIH0lQHhUM5Ji+zxFaLq4jWaUgppy/2kX17o2IYj
 HxJUAKcjsVfqO2D8WfGke4JU97hbLRzRXYewB11RaBjdHxQrN/AbzzPqy6ofxdMURxkS80exW
 U47Sf/Pl1NrQvZAMfcssBmZ7IqLx2K/kjImT04Hlps0f+7N1VgSdT50XamqYZrbwY8KkKyVS+
 datRLofWRKdIBZbcde+Pk8+AV5qbmBKw7F2emWMTyWaZOYInvYslb6EV139sP9nhBGnNeEFoI
 a6R0w7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Sat, 15 Oct 2016, Lars Schneider wrote:

> 
> > On 11 Oct 2016, at 05:12, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> > 
> > Hi Lars,
> > 
> > On Sat, 8 Oct 2016, larsxschneider@gmail.com wrote:
> > 
> >> @@ -31,6 +32,15 @@ static void cleanup_children(int sig, int in_signal)
> >> 	while (children_to_clean) {
> >> 		struct child_to_clean *p = children_to_clean;
> >> 		children_to_clean = p->next;
> >> +
> >> +		if (p->process && !in_signal) {
> >> +			struct child_process *process = p->process;
> >> +			if (process->clean_on_exit_handler) {
> >> +				trace_printf("trace: run_command: running exit handler for pid %d", p->pid);
> > 
> > On Windows, pid_t translates to long long int, resulting in this build
> > error:
> > 
> > -- snip --
> > In file included from cache.h:10:0,
> >                  from run-command.c:1:
> > run-command.c: In function 'cleanup_children':
> > run-command.c:39:18: error: format '%d' expects argument of type 'int', but argument 5 has type 'pid_t {aka long long int}' [-Werror=format=]
> >      trace_printf("trace: run_command: running exit handler for pid %d", p->pid);
> >                   ^
> > trace.h:81:53: note: in definition of macro 'trace_printf'
> >   trace_printf_key_fl(TRACE_CONTEXT, __LINE__, NULL, __VA_ARGS__)
> >                                                      ^~~~~~~~~~~
> > cc1.exe: all warnings being treated as errors
> > make: *** [Makefile:1987: run-command.o] Error 1
> > -- snap --
> > 
> > Maybe use PRIuMAX as we do elsewhere (see output of `git grep
> > printf.*pid`):
> > 
> > 	trace_printf("trace: run_command: running exit handler for pid %"
> > 		     PRIuMAX, (uintmax_t)p->pid);
> 
> Thanks for hint! I'll change it!
> 
> However, I am building on Win 8.1 with your latest SDK and I cannot
> reproduce the error. Any idea why that might be the case?

Are you building with DEVELOPER=1?

Ciao,
Dscho
