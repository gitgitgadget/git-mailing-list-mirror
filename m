Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 929E71F404
	for <e@80x24.org>; Fri, 31 Aug 2018 10:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeHaOSu (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 10:18:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:36259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbeHaOSu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 10:18:50 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBIAz-1g5L2Z0Nz3-00AGkR; Fri, 31
 Aug 2018 12:11:58 +0200
Date:   Fri, 31 Aug 2018 12:11:56 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        corrmage@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: A rebase regression in Git 2.18.0
In-Reply-To: <CABPp-BH8-1YQ49aaM-dXkT9ukKO92MF-FZ2kLwd=KHe4TVbjqQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808311158540.71@tvgsbejvaqbjf.bet>
References: <679370A8-E477-450D-96E5-6B1869D27576@gmail.com> <87in3ueiks.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1808281532220.16620@tvgsbejvaqbjf.bet> <CABPp-BENB=mqfFU4FGb2OS9VDV=9VdT71HhFLZwtyxD8MpdTMQ@mail.gmail.com> <xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com>
 <CABPp-BH8-1YQ49aaM-dXkT9ukKO92MF-FZ2kLwd=KHe4TVbjqQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fT/m9uev9CnLdxL5sGQPJ0XJYFqdk0FztddjCvAtpzH91LIl4Zz
 V0VjSjNxPmrEatUOD+0mrBM8Riomg61BPpL9zEKFklvziGYkUH6moXM5VSJArQbykNDfSiB
 y0p5CIOO0w5hSmE1vbjkWkIOkMt1tOK3C3E+t6JuU0yvD0A967uNclsgv9ESlD/YnKNYD6h
 sWO64gGN5jk4QrnydtX8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UhXJW4d9Lpw=:oBnkOeIljx//DuJWzF70Uw
 /LJjS6x1i202f54eOmDriwkeovGIlHIgEbi1ZEX3LxghDIa+f93XoSjiqZhW8s5iDzR6Lp+4+
 V7mZs8QmcR2XHiT1WBfP70y3npVDr3u8iFL1IJRNUjmsOxHG4ngda/vbrzio2QpWHq4ULKGcD
 On/3WpaEsAG3leA6VOSMjnLH0ZbiKLFFVFwf9GJAvM+eYxZa4rOeYb0r/Aj3ZNGbiELABzyTI
 TjY+/Ll8MihtC7SKagAv3zYbhCo8UtiLNbsqm3+4fltcRL+xuc3o7mHFdkoC04I/RIGkxKU3H
 XCg0JHfo8Li7N3DWv8pzoEa4nkIVG82XmTwajRTQi/9Sa/IVYI+WM2Q42e8GNH/d029KoZShI
 xVAqBv6Zm6sN6kuJPLDtNM/w/KZblTe24Ntlj0voRXQYnlrL7IuRzUuuD3IfLDBrHpjWueGYB
 5COcVJfhtLDLxek+gmf0VGDTrsHkeGtP0ACxwO+1cXzdhr7+qm6HGtr4R5GnU8pzJF8XJn0zV
 cdiyqpFUl1hzNzjhvVigZ64xnWfcGa7lWimd7RdhRoORyx6qdehUVgwbrkE1aBMaFIHxqpzjF
 0UgDQugcOx8XbKbvz18QQNobBhftKV6AkwIu2T6j0Y8254X8grD3dv6XxuOHO+M1FphX4uWZg
 f0pm96G8Ta1jufJF32ffCXYFgi7jcuzMMS2XH6gUx2yKdOS+rx+LbwComEq5bf1ymMAAAR261
 S58xu5qGF0aKfLogvSdyfynv+cAOhmgE0tAwJ3LASVs+gHJgaaX19J2hFGgDoEoxC5ujzfaij
 oJVX2D/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 30 Aug 2018, Elijah Newren wrote:

> On Tue, Aug 28, 2018 at 9:58 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Elijah Newren <newren@gmail.com> writes:
> >
> > >   - Add a flag to turn off directory rename detection, and set the
> > > flag for every call from am.c in order to avoid problems like this.
> >
> > I'd say this is the only practical solution, before you deprecate
> > the "pipe format-patch output to am -3" style of "git rebase" (and
> > optionally replace with something else).
> 
> I posted a patch a while back to add an --am flag to "git rebase",
> make "--am" be implied by options which are still am-specific
> (--whitespace, --committer-date-is-author-date, and -C), and change
> --merge to be the default.

Didn't you also post a patch to fold --merge into the --interactive
backend? What's your current state of thinking about this?

As to switching from --am as the default: I still think that --am has
serious speed advantages over --merge (or for that matter, --interactive).
I have no numbers to back that up, though, and I am currently really busy
with working on the CI, so I won't be able to measure these numbers,
either...

Also please note: I converted the `am` backend to pure C (it is waiting at
https://github.com/gitgitgadget/git/pull/24, to be submitted after the
v2.19.0 RC period). Switching to `--merge` as the default would force me
to convert that backend, too ;-)

> I'll post it as an RFC again after the various rebase-rewrite series
> have settled and merged down...along with my other rebase cleanups
> that I was waiting on to avoid conflicts with GSoC stuff.

Thanks for waiting! Please note that I am interested, yet I will be on
vacation for a couple of weeks in September. Don't let that stop you,
though!

> > The whole point of "am -3" is to do _better_ than just "patch" with
> > minimum amount of information available on the pre- and post- image
> > blobs, without knowing the remainder of the tree that the patch did
> > not touch.  It is not surprising that the heuristics that look at
> > the unchanging part of the tree to infer renames that may or may not
> > exist guesses incorrectly, either with false positive or negative.
> > In the context of "rebase", we always have all the trees that are
> > involved.  We should be able to do better than "am -3".

Right. I think that Elijah's right, and --merge is that "do better"
solution.

Ciao,
Dscho
