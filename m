Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D80211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 19:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbeK3GK3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 01:10:29 -0500
Received: from mout.gmx.net ([212.227.17.21]:59857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbeK3GK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 01:10:29 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMTZa-1gafre0q1G-008GnV; Thu, 29
 Nov 2018 20:03:56 +0100
Date:   Thu, 29 Nov 2018 20:03:51 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] format-patch: allow for independent diff & range-diff
 options
In-Reply-To: <87tvjzyiph.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811291958500.41@tvgsbejvaqbjf.bet>
References: <xmqqk1l32jo2.fsf@gitster-ct.c.googlers.com> <20181128201852.9782-3-avarab@gmail.com> <nycvar.QRO.7.76.6.1811291103190.41@tvgsbejvaqbjf.bet> <8736rkyy4h.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1811291307070.41@tvgsbejvaqbjf.bet>
 <871s74yms3.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1811291641090.41@tvgsbejvaqbjf.bet> <87tvjzyiph.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-453655158-1543518238=:41"
X-Provags-ID: V03:K1:Bwoe1w2q0wpL6fLScM6OV/75K0O/eLKGKs1eYOymZgRGGhE80iu
 DsoG9dCAaWz8LzqYH+vkfeI6b7qi+S5WuENDcNVcJQuwyCzdg10eqE6m0WJ9CAOkLCIo9CX
 C0S/7aPfwPM85q32mFJ6zu+7EftlAvhHnH0hIQ/sgW5+xmflAY9KVAvstxa9DAXuhwTp45c
 sCwRaURElcJtkuc66lQyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mprC299pahI=:uHE1iyXVLjVviowgsWCW7M
 0wgDlShRvAJQ9nmHQsrD/3qElLaRYS4O/HDyumzw8l9zmWkgT/wTauYxhg+4sY3SLC8zLZOuj
 s+yCd06rrY2nv/97A2m/SB0UMhUwXUuOntW9MbY1SfWbhAY7wpoBbs5ObMBqtGZk0MjbxQJzH
 ZHgzNFx3Gfg1U2gULFQYTboRK6MxHoORj19mEp6MuWyHP0+lhXPpKjeRrw9FtHxsoBx+tVO4s
 0tdVW6TPM8uADdJbiJ0KERtwtrNQ2v1S3gQv0r6lvi3rPkH4w9tUNAgnY2h+g4iKpBCncgfhl
 TaWwxtqF7xW0vHiuWuRvLGTQnejHj6Whia8reTwzDI8jhJBnCPgKDP2cJxRy8KcrbVv4or5ps
 frxeB9VnJIZK9hclMAqq2ZoYYYzxq9xaz2sSjTizL5MlydSwScZFz5ViSZFFWdXUuMM+Ock75
 LTcLjS074fIa29bNNv5OzGxI9NfSi+JRGdD+HjeSGAeqZDPgnVxquzZKuI4sQlcwIq4UEUMOn
 FgTccRL019z7HWdMo6EtuxLwMHzAVJsz/LSJUzv+69urFc+B8VsZwe3YxD1UVoBtDUCwWtwTR
 /Jn4EVQoSyTrWexDGh4nikievk36vG8CjTzWHS/WEDqNZWu9fLD7c56BX+w0BHUFARJtIhX8C
 C/DKiejopeNp5E1T9FeW14HHHRxGYWDQk+o1mK0j6CS1pp5LjHF3L04ln14EwctyRIfhckmdI
 AN2mI6cQFNI/fQN8vZBXE0pTEgBADgMj8WP8WFZHF+K2VGLTqgHddAzszjq4EMaunfUMwDBsw
 TUAFMMp7VnCZX99yS5mCkLBRnsJERn8/euBa+kcT7+0W15A2mCdiGkKMHFyG99q3GFtpP8mXx
 5WEQIEkcCkN//3662lae5D2ySD8+0buGR9HSCgTkBUP0F3xco66z/B3pg6nOycYDTPEZU/5cs
 QEB0/jPkVTQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-453655158-1543518238=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Thu, 29 Nov 2018, Ævar Arnfjörð Bjarmason wrote:

> On Thu, Nov 29 2018, Johannes Schindelin wrote:
> 
> > On Thu, 29 Nov 2018, Ævar Arnfjörð Bjarmason wrote:
> >
> >> On Thu, Nov 29 2018, Johannes Schindelin wrote:
> >>
> >> > On Thu, 29 Nov 2018, Ævar Arnfjörð Bjarmason wrote:
> >> >
> >> >> On Thu, Nov 29 2018, Johannes Schindelin wrote:
> >> >>
> >> >> > On Wed, 28 Nov 2018, Ævar Arnfjörð Bjarmason wrote:
> >> >> >
> >> >> >> Change the semantics of the "--range-diff" option so that the regular
> >> >> >> diff options can be provided separately for the range-diff and the
> >> >> >> patch. This allows for supplying e.g. --range-diff-U0 and -U1 to
> >> >> >> "format-patch" to provide different context for the range-diff and the
> >> >> >> patch. This wasn't possible before.
> >> >> >
> >> >> > I really, really dislike the `--range-diff-<random-thing>`. We have
> >> >> > precedent for passing optional arguments that are passed to some other
> >> >> > command, so a much more logical and consistent convention would be to use
> >> >> > `--range-diff[=<diff-option>..]`, allowing all of the diff options that
> >> >> > you might want to pass to the outer diff in one go rather than having a
> >> >> > lengthy string of `--range-diff-this` and `--range-diff-that` options.
> >> >>
> >> >> Where do we pass those sorts of arguments?
> >> >>
> >> >> Reasons I did it this way:
> >> >>
> >> >>  a) Passing it as one option will require the user to double-quote those
> >> >>     options that take quoted arguments (e.g. --word-diff-regex), which I
> >> >>     thought sucked more than the prefix. On the implementation side we
> >> >>     couldn't leave the parsing of the command-line to the shell anymore.
> >> >>
> >> >>  b) I think people will want to tweak this very rarely, much more rarely
> >> >>     than e.g. -U10 in format-patch itself, so having something long-ish
> >> >>     doesn't sound bad.
> >> >
> >> > Hmm. I still don't like it. It sets a precedent, and we simply do not do
> >> > it that way in other circumstances (most obvious would be the -X merge
> >> > options). The more divergent user interfaces for the same sort of thing
> >> > are, the more brain cycles you force users to spend on navigating said
> >> > interfaces.
> >>
> >> Yeah it sucks, I just think it sucks less than the alternative :)
> >> I.e. I'm not picky about --range-diff-* prefix the name, but I think
> >> doing our own shell parsing would be nasty.
> >
> > What prevents you from using `sq_dequote_to_argv()`?
> 
> I mean not just nasty in terms of implementation, yeah we could do it,
> but also a nasty UX for things like --word-diff-regex. I.e. instead of:
> 
>     --range-diff-word-diff-regex='[0-9"]'
> 
> You need:
> 
>     --range-diff-opts="--word-diff-regex='[0-9\"]'"

Really? I think that would not work. It would pass the single quotes as
part of the regex to the diff machinery.

Or maybe not. But the extra quotes do not strike me as necessary, as there
is no shell script involved (thank deity!) after `git range-diff` parsed
the options.

> Now admittedly that in itself isn't very painful *in this case*, but in
> terms of precedent I really dislike that option, i.e. git having some
> mode where I need to work to escape input to pass to another command.
> 
> Not saying that this --range-diff-* thing is what we should go for, but
> surely we can find some way to do deal with this that doesn't involve
> the user needing to escape stuff like this.
> 
> It also has other downstream effects in the UI, e.g. it's presumably
> easy to teach the bash completion that a --foo=XYZ option is also called
> --some-prefix--foo=XYZ and to enable completion for that, less so for
> making it smart enough to complete "--some-prefix-opts="--foo=<TAB>".

These are all good points, and need proper discussion.

Sadly, all that time needed for a proper discussion is not left before
v2.20.0 is supposed to come out.

Quite honestly, I think what we will have to do is to describe in the
documentation of `format-patch`'s `--range-diff` option that the exact
user interface how to pass diff options down to `range-diff` is in flux
and not final.

That way, we can give your design the proper treatment, and work together
on making a user interface we all can be happy with.

Ciao,
Dscho
--8323328-453655158-1543518238=:41--
