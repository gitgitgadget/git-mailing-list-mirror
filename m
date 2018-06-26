Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02EEB1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 14:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934686AbeFZOKQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 10:10:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:55337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933990AbeFZOKP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 10:10:15 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3zT0-1gO8PE16iA-00rZ8f; Tue, 26
 Jun 2018 16:10:06 +0200
Date:   Tue, 26 Jun 2018 16:10:05 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Tiago Botelho <tiagonbotelho@gmail.com>,
        git <git@vger.kernel.org>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [RFC PATCH v5] Implement --first-parent for git rev-list
 --bisect
In-Reply-To: <CAP8UFD3oEjW75qsk4d_wqo2V8PmzMvZLshutw20CD7AU4b4ocg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806261540340.21419@tvgsbejvaqbjf.bet>
References: <20180622123945.68852-1-tiagonbotelho@hotmail.com> <xmqq4lhqpy80.fsf@gitster-ct.c.googlers.com> <CAP8UFD3oEjW75qsk4d_wqo2V8PmzMvZLshutw20CD7AU4b4ocg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dnV0qna5dC0PwQlQSb00MyGY8tNmAvab22y6EAzj4uH7OOopVNY
 1mCWcJ/CiKiciu0IKDRzFeFpfd6ZaF8jndYw586dZIulUCizQmZNQ8SZqoYUKL5yeeJdMmy
 jqDJACJHEM7fBA5GXapBHI7mxNqb0iyFFNIYM5YHzwlE5e2cQCK5AyWz4BAKpUiYT8WAxF7
 C533WeNc5Bp0nDRgZHR+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XhtFdpj7+YA=:0hITH0kc8XLuiS7NUq/lfn
 FWgrJq23+YHSXGzqynkBF6HesjJPm4ktGoiZ0DFdIBKuD8Q7RnRM+lSfXLCBxjIHGTA+Qd/oE
 Rd1lQjunqoXDnBEWoVUhx+KX1u+LwfV8PekgXg26UMkUB89YtL5joVrzs+ZgNelm1J7rRXDiU
 PpLFc+EZavBM8G0F4ZwJTfwhtTHBtN0+4lJRbGdg80iWqd5dDeWYlI6R0GmGXe/Tz3B7ox3LF
 ylyAIHF2AI4ri+IGKgOIoa8yUZoxpShZjClEJnkKBcYCtSXyzI4PTswksdNkvB+1gYet56I9r
 X4TDAQkgAmr84Ecyvpug+ujwVRlVJpeOIAtt1wRDXYKORGoV1VRIwX3/wxdhx8TMyqfV7XeB+
 haL4yRUCp1xkviQzDJr5yhlX8htrIu/JIR6bk5rvMsj3UyUWS6+3VPfzEGhvvdniYrQZcwcYe
 q1fSm+vzi68HtcbrwvrGBYDVGzTWwf84Jpep9SiWtVrWX3GZETTniusjsuRx09XY+yHXANCzZ
 9gNMFRjQ7UxcHtIEmc8RajM8IzE2NJQyzPxJN90Ryph0GmtKIx4N/CXZ/RjXuOvRKJx3FwYiZ
 js16Gr0LrSatuI0P1IURCbHMiAQAKiA97g5nYRLG1Ouw6amazTYkrUWBTQTfyWMQ6tm5JU5z7
 cCYsIJbir984pKTBFwYPlrXQF11uRm2M8i26N/grBOYf+cSevrWKKSzxc6Kg9FONGpd0lUcbK
 Rsic39X09yRrUDbfsc8midaYkPspF4Ksd6M+5XoaMR67QS1w2nD+9KJSr3ElbxVq078vMtyXq
 nrbqUsi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

On Tue, 26 Jun 2018, Christian Couder wrote:

> On Mon, Jun 25, 2018 at 7:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Tiago Botelho <tiagonbotelho@gmail.com> writes:
> >
> >> +test_expect_success "--bisect-all --first-parent" '
> >> +cat >expect1 <<EOF &&
> >> +$(git rev-parse CC) (dist=2)
> >> +$(git rev-parse EX) (dist=1)
> >> +$(git rev-parse D) (dist=1)
> >> +$(git rev-parse FX) (dist=0)
> >> +EOF
> >> +
> >> +cat >expect2 <<EOF &&
> >> +$(git rev-parse CC) (dist=2)
> >> +$(git rev-parse D) (dist=1)
> >> +$(git rev-parse EX) (dist=1)
> >> +$(git rev-parse FX) (dist=0)
> >> +EOF
> >> +
> >> +git rev-list --bisect-all --first-parent FX ^A >actual &&
> >> +  ( test_cmp expect1 actual || test_cmp expect2 actual )
> >> +'
> >
> > I hate to say this, but the above looks like a typical
> > unmaintainable mess.
> >
> > What happens when you or somebody else later needs to update the
> > graph to be tested to add one more commit (or even more)?  Would it
> > be enough to add another "rev-parse" plus "dist=X" line in both
> > expects?  Or do we see a trap for combinatorial explosion that
> > requires us to add new expect$N?
> 
> What about the following then:
> 
> test_dist_order () {
>     file="$1"
>     n="$2"
>     while read -r hash dist
>     do
>         d=$(echo "$dist" | sed -e "s/(dist=\(.*\))/\1/")
>         case "$d" in
>             ''|*[!0-9]*) return 1 ;;
>             *) ;;
>         esac
>         test "$d" -le "$n" || return 1
>         n="$d"
>     done <"$file"
> }
> 
> test_expect_success "--bisect-all --first-parent" '
>     cat >expect <<EOF &&
> $(git rev-parse CC) (dist=2)
> $(git rev-parse EX) (dist=1)
> $(git rev-parse D) (dist=1)
> $(git rev-parse FX) (dist=0)
> EOF
>     sort expect >expect_sorted &&
>     git rev-list --bisect-all --first-parent FX ^A >actual &&
>     sort actual >actual_sorted &&
>     test_cmp expect_sorted actual_sorted &&
>     test_dist_order actual 2
> '
> 
> This feels overkill to me, but it should scale if we ever make more
> complex tests.

I *think* that you misunderstand Junio. At least when I read this:

> $(git rev-parse CC) (dist=2)
> $(git rev-parse EX) (dist=1)
> $(git rev-parse D) (dist=1)
> $(git rev-parse FX) (dist=0)

I go: Huh?!?!?!?!?!

What's CC? Is it Christian Couder? Creative Commons? Crudely Complex?

The point, for me, is: if this test fails, at some stage in the future,
for any reason, it will be a major pain to even dissect what the test is
supposed to do. This is no good. And you can do better. A lot better. You
can write the test in a way that the head of a reader does not hurt, and
at the same time it is still obvious what it does, and obvious that it
does the right thing.

One thing that makes the brain stumble for certain is when you deviate
from the conventions, especially when it is for no good reason at all. In
this case (and I am not sure why you, as a long-time contributor, did not
spot this before public review):

- the titles of the test cases leave a lot of room for improvement,

- the lines are too long,

- the convention to end the `test_expect_success` line with an opening
  single quote is not heeded,

- the graph is definitely written in an unnecessarily different format
  than in the same test script!!!

- speaking of the graph: there is a perfectly fine commit graph already.
  Why on earth is it not reused?

In this particular case it even feels as if this test is not even testing
what it should test at all:

- it should verify that all of the commits in the first parent lineage are
  part of the list

- it should verify that none of the other commits are in the list

And that is really all there is to test. You can even write that in a much
easier way:

-- snip --
test_expect_success '--first-parent --bisect-all lists correct revs' '
	git rev-list --first-parent --bisect-all F..E >revs &&
        # E and e1..e8 need to be shown, F and f1..f4 not
	test_line_count = 9 revs &&
	for rev in E e1 e2 e3 e4 e5 e6 e7 e8
	do
		grep "^$(git rev-parse $rev) " revs || {
			echo "$rev not shown" >&2 &&
			return 1
		}
	done
'
-- snap --

To test more precisely for the order or the distance would be both
overkill and likely to be unreadable.

To test `--bisect-vars` here would be excessive, as the part that handles
that particular option is not even touched. All that is touched is the
logic in the bisect algorithm in conjunction with --first-parent. And that
is all that should be tested here.

With a test like the one I outlined above, I only have one more gripe
about the patch: the commit message does nothing to explain this part of
the diff:

+                               if ((bisect_flags & BISECT_FIRST_PARENT)) {
+                                       if (weight(q) < 0)
+                                               q = NULL;
+                                       break;
+                               }

And I would really, really like that to be explained in the commit
message. Because to me, it is completely opaque why this needs to be here.
The rest of the diff is pretty obvious, though.

Ciao,
Johannes
