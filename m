Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4146320A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 10:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbeLKKb2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 05:31:28 -0500
Received: from mout.gmx.net ([212.227.15.15]:36267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbeLKKb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 05:31:27 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LsChr-1hS7De2AFr-013tkD; Tue, 11
 Dec 2018 11:31:17 +0100
Date:   Tue, 11 Dec 2018 11:31:16 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     Johannes Sixt <j6t@kdbg.org>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] rebase: offer to reschedule failed exec commands
 automatically
In-Reply-To: <CAGZ79kY18SCaCBvkWyeVd+oeJ4EhoJK4=QxGhJ9a77iX2sR8ew@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1812111119560.43@tvgsbejvaqbjf.bet>
References: <pull.90.git.gitgitgadget@gmail.com> <d2c317fd-d10a-19c1-8b4f-a7311c69a52f@kdbg.org> <CAGZ79kY18SCaCBvkWyeVd+oeJ4EhoJK4=QxGhJ9a77iX2sR8ew@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:x+yxJtlkemX5ain7e/rcRW4wuZxJFe0yjHodrwJOZYfu3uoP2qz
 /FEBCCkGJJ+OJnqI1gB2P2QtoNweIlW3RuxIlR2PGc8cSBaocE8quevkDuYL0GWschZ8poW
 TyMMuBfTmFiUdAfyoMJIJLIN1diJioaNViv+5phxWHKRTiUQsZZotTS9CQfohenv4DRTlzh
 Wibz5mmR46+J6tnWg+PwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:70rrwxjccEk=:DRcCSbFSOg07nQkf5ysBPL
 7MN2PM+ng1Rjh/cl80iHVC2Unf/Ov0iOH9FkU01C4+tlaJ6fonQKXm8HqCatwRW7WcS+etV6E
 n3z6BAGS3x8LXIyeknx1WTHksPuWFcdz+mCzCmoVEWYjo0pJ7FZiqAO2YcxYy/AHsb+M+ZVqg
 5fW551MQMrXH5QKuJ4vHbRLVoEUXTRqcFCBmzPXHF8W7aXR8F1rnXVMwM1l59h9S8EuL9HQs3
 2T8F6OiZhuSKXiYIb2AS8auX7Ntv6mgq6s+IVt5Kw6JOZk+abnYmk2TNN9b7TLiquZ1dUji2U
 LSfFy7njKQLOisI9WlzjtuMBWQGBBrbkekNDgSMOvkFdgw4Po2v1+Q0rgg+NgchV9642JJ7nC
 4PSkOPRCoNMPOVtkkgXbcRIXSgt8JfbhLHC99CchiUYmLlMu9hqr6AXIeT/NOFjpUGZpF7con
 Os/neEQlnm7+XJoxJDXupNsBwdSws8a8erpmpbHokpzZZend4fDYNB3LOPk3lKoQIoPw9Zpjl
 oKJKqoL/zhbt2jevpLlenWjtlRbk3fpk7mvGllwlXYcgex89a15IscSn5+AwjKwOsiLpY4g+P
 3o2uloDZ9V0kzvs7zK/3E4AOFPSzZzBK+ryQtuSRV9l4GErWxYwuuirBV2+vz2dv81Ne4ekPG
 V724VX4IMUdxI3sFDmroK6worEllGymIQfTav8+j5y5YmOdTXG6uxxsNUNl/ze9aUPdSFVLsw
 aKhGJrl+O8ySX5+M74V0SKaPr6UZNdE/TNQj3AeiLBtLqnWUurKz823FfxgRSSGL4NnUfwepl
 SQ6Tnpt2bOap0EUzLYlTwxnWJn7u7K3clAONW6OQvDyhKWp+Zq/yLf/IpDIfViJckNsi/y19F
 A+rIMFm91IFVD7MqkJUOnxjnq1He2MnPIPMRrHcoe8x8bA72kyR5Ukhzfxyun2lnfaBbQlzLf
 xFBA09hcEbA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Mon, 10 Dec 2018, Stefan Beller wrote:

> On Mon, Dec 10, 2018 at 2:08 PM Johannes Sixt <j6t@kdbg.org> wrote:
> >
> > Am 10.12.18 um 20:04 schrieb Johannes Schindelin via GitGitGadget:
> > > The idea was brought up by Paul Morelle.
> > >
> > > To be honest, this idea of rescheduling a failed exec makes so much sense
> > > that I wish we had done this from the get-go.
> >
> > The status quo was actually not that bad a decision, because it made 'x
> > false' as a substitute for 'break' very convenient.
> >
> > But now that we have a real 'break', I'm very much in favor of flipping
> > the behavior over to rescheduling. (I'm actually not a user of the
> > feature, but the proposed behavior is so compellingly logical.)
> 
> In rare cases I had commands that may be dangerous if rerun,
> but I'd just not run them with -y but with -x.

Please note that 3/3 (i.e. the `-y` option) is *really* only intended as a
"I could do this if anybody *really* wanted to" patch. I actually would
strongly prefer not to have this patch in git.git at all.

> That brings me to some confusion I had in the last patch:
> To catch a flaky test I surely would be tempted to
>     git rebase -x make -y "make test"
> but that might reschedule a compile failure as well,
> as a single -y has implications on all other -x's.
> 
> I wonder if it might be better to push this mechanism
> one layer down: Instead of having a flag that changes
> the behavior of the "exec" instructions and having a
> handy '-y' short cut for the new mode, we'd rather have
> a new type of command that executes&retries a command
> ("exnrt", 'n'), which can still get the '-y' command line flag,
> but more importantly by having 2 separate sets of
> commands we'd have one set that is a one-shot, and the
> other that is retried. Then we can teach the user which
> is safe and which isn't for rescheduling.
> 
> By having two classes, I would anticipate fewer compatibility
> issues ('"Exec" behaves differently, and I forgot I had turned
> on the rescheduling').

As Junio points out, this brings us back to the proposal to have two
different `exec` commands.

I am really unenthusiastic about this idea, as I find it "hard to sell":
what little benefit it would bring to have two commands that pretty much
do the same thing almost all the time would be outweighed *by far* by the
confusion we would sow by that.

It is amazing to me how much my perspective changed when I actually had to
teach Git to new users. Things that I live with easily all of a sudden
become these unnecessarily confusing road blocks that make it *so hard* to
actually use Git.

> Talking about rescheduling: In the above example the flaky
> test can flake more than once, so I'd be stuck with keeping
> 'git rebase --continue'ing after I see the test flaked once again.

No, you would not be stuck with that.

You would read the error message carefully (we do that all the time, yes?)
and then run `git rebase --edit-todo` to remove that line before
continuing.

:-)

If you feel very strongly about this, we could introduce a new option for
`git rebase --skip`, say, `git rebase --skip --skip-next-commands-too=1`.
(I specifically used a too-long option name, as you and I are both
Germans, known to use too-long names for everything. I do not really
intend to use such an awkward option name, if we decide that such an
option would be a good idea. Probably more like `git rebase
--skip-next[=<N>]`.)

> My workflow with interactive rebase and fixing up things as I go
> always involves a manual final "make test" to check "for real",
> which I could lose now, which is nice.

My workflow with `git rebase -r --exec "make test"` is pretty similar to
yours. With the difference that I would want those commands to be
rescheduled *even if* the command is flakey. Actually, *in particular*
when it is flakey.

I really see myself calling

	git config --global rebase.rescheduleFailedExec true

in all my setups.

Ciao,
Dscho
