Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16E271F453
	for <e@80x24.org>; Fri,  1 Feb 2019 14:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfBAOeH (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 09:34:07 -0500
Received: from mout.gmx.net ([212.227.17.21]:51427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbfBAOeH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 09:34:07 -0500
Received: from [10.200.98.186] ([151.248.50.113]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnPnu-1hM8x02jb4-00hbVS; Fri, 01
 Feb 2019 15:33:56 +0100
Date:   Fri, 1 Feb 2019 15:33:55 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Michal Nowak <mnowak@startmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: Broken interactive rebase text after some UTF-8 characters
In-Reply-To: <747726ae27ff52509f831c9615f2b102.startmail@startmail.com>
Message-ID: <nycvar.QRO.7.76.6.1902011530440.41@tvgsbejvaqbjf.bet>
References: <a50734d9-4d30-5847-b5df-67a8458a36cb@startmail.com>    <339d4dbd-b1bd-cf88-12b0-2af42f35ded7@talktalk.net>    <23c60f2f-43ff-94ec-6100-861c655ec80b@startmail.com>    <8c43e31b-01d8-a1c5-d19c-8efd0e5c1714@talktalk.net>   
 <505c2e2e-c9bc-aa57-c498-2acced0b8afa@gmail.com>    <2cbb5818-643d-bafd-6721-91e0d291a5fd@talktalk.net>    <xmqqimy41pdu.fsf@gitster-ct.c.googlers.com>    <nycvar.QRO.7.76.6.1902010835210.41@tvgsbejvaqbjf.bet>
 <747726ae27ff52509f831c9615f2b102.startmail@startmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7Z3Q9zIEbbNNNz/dEqMyBlT1DLvyIRn2kWoip+hdkVwAA3FhfKM
 NTO4AYjT+q3klWHPc8ptVgIAqokbGyebQw+gzwGI0n8fx/55HtLYeISgeoSWcSsKcyzYDA7
 1xKQb8z5JSkUXyYLVUgqo2Ga4hnboYRZsotLFbgRHxi3aXTQhX1E7T5akHoRegU3ivTy3Jm
 kpYv0wbYnpn1DcaIB9m9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1GawshBJBMo=:OniOmvHSq5wdd3D68u6lyN
 ePJrHnlcrGfjck/iJ0tsCo9DZddxJ6QqHVMo3TVjoSoGZeVpVxnj56ZC1jNZvDUrUmh7/e2Hw
 JUP6qnHsxwxL5WjpoXqQ7fnzloC3bcagY2WfgRqRmylBaj1tN7tGQuxIf3usHF226IspDN/wX
 gWT2bEsqmJSxUmrIZT2QI6qt5zophaXXSLYGITAwhC4BI/q7uOy2dGYf1fgWddc2iRlF348nA
 NGGQcbmUCQTWdDCzKBPEKAIR+tCsw0srf9Eg187ocGyYvvzIaTBT2sds/GwtRsxltdwhPqa1w
 SGXfiiMYqUWJxlh6ii1BwLX2715+RpFh0trKCiUL1tspg1IyfLX0laWLG4fLOoDNi0INcD84R
 /GZj7GuuZ5rm0+kJjdMv4PwMrLNKfpKe67S58Ck1jkA8ZD2W3VeL3weKTP98TSWMRjczbhyjG
 YfZhdbAgE9ECTzp9L6jmBZOCY0GJBtYmO8Ec5Vzuoz9G+jrGlPIh5BytSLW9kOD+ehGCVSa4L
 ZJLRGwwHGizwYuTbBBxAVWSgWzWQpAFr/NVNB7sVGD8sFoSAUGrvNpXdtSjw2HgVj6I+aZNoa
 MvWsCjOurCiJ91OXk4oEzmDS2CeHHq3P+N4+12Re40MuEoYCvfHjhjntVpLdJ0kMDkVifcc3z
 mkqKjwPq6WEeoEw6y4AXSIyhvilkAUnR714lJt7oNqi/iE2tnmqRfSwtdJA9ALIA5EQOAMGPm
 vldjhEQVcxPZTb21LoPGe5Cph5Xoaml/nqu5EBa0L3dkusPC6ojW37hXHDeKo0tkI+ushdgA7
 Wn2G7ST82bI5p0UaYDv7ue+B3O8Y3e8zEr+QQn9SqvMop/aVN3DhItxlodVdvt3HBSs1m07zo
 MITPSz/o0D3uthXAxxIbrV9vPsjHLQ+Bt/Iu6PScgRR5RFGTRpE1QZB72pHwxl4Exm7qD0RL7
 UTYG7wmTb7g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michal,

On Fri, 1 Feb 2019, Michal Nowak wrote:

> On Friday, February 1, 2019 at 8:38 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > On Thu, 31 Jan 2019, Junio C Hamano wrote:
> > 
> >> Phillip Wood <phillip.wood@talktalk.net> writes:
> >>
> >> >> Are we misusing C formats?
> >> >
> >> > The C standard and POSIX both say that the * refers to the maximum
> >> > number of bytes to print but it looks like it is being treated as the
> >> > maximum number of characters on OpenIndiana.
> >> >
> >> > Johannes - Perhaps we should change it to use fwrite() unless
> >> printf()
> >> > gets fixed and we're sure no other operating systems are affected?
> >>
> >> Avoid such a rewrite, as "%*.s" that takes (int, char *) are used in
> >> many other places in our codebase, if you can.
> > 
> > Yes, this would be painful in particular in cases like
> > 
> > 	master:advice.c:101:           fprintf(stderr, _("%shint: %.*s%s\n"),
> > 
> > where we want to write more than just a variable-length buffer.
> > 
> > I am curious: is libintl (gettext) used on OpenIndiana? I ask because
> > AFAIR fprintf() is overridden in that case, and the bug might be a lot
> > easier to fix if it is in libintl rather than in libc.
> 
> here you can see the full output of the OpenIndiana git build: https://hipster.openindiana.org/logs/oi-userland/latest/git.publish.log.
> 
> From what I see there, libintl was found.
> 
> If you believe this is illumos libc bug, it would be cool if someone created an simple testcase, which I can forward to the illumos developers.

You already have that example. Just take the UTF-8 text in your original
bug report, put it into something like

	int main(int argc, char **argv)
	{
		char utf8[] = "... your text here...";

		printf("%.*s", (int)(sizeof(utf8) - 1), utf8);

		return 0;
	}

You should first verify, though, that this replicate the problem, and if
it does not, use libintl (I think you have to `#include <gettext.h>` and
`-lintl` or some such) and see whether that reproduces your problem.

Ciao,
Johannes

> 
> Thanks,
> Michal
> 
> > 
> > Of course, it might *still* be a bug in libc by virtue of handing '%.*s'
> > through to libc's implementation.
> > 
> > Alban, can you test this with NO_GETTEXT?
> > 
> > Thanks,
> > Johannes
> 
