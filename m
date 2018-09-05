Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51FE31F404
	for <e@80x24.org>; Wed,  5 Sep 2018 12:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeIERJ0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 13:09:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:37961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbeIERJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 13:09:26 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWSwU-1gPYJm1yZO-00XgPL; Wed, 05
 Sep 2018 14:39:12 +0200
Date:   Wed, 5 Sep 2018 14:39:10 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Luke Diamand <luke@diamand.org>
cc:     Eric Sunshine <sunshine@sunshineco.com>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/9] tests: include detailed trace logs with --write-junit-xml
 upon failure
In-Reply-To: <CAE5ih7_GgkEaVXONy8ZY9j43PX6GD-mkD9vJ1t93upAfTkM8tw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1809051430390.71@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <942bf423a461a3b44e2ff254c90907a539d7abbe.1536009027.git.gitgitgadget@gmail.com> <CAPig+cRGHPfNqdgRr6H_D_siKCFZBDsUrcp0F+CWNCx884AJVg@mail.gmail.com> <nycvar.QRO.7.76.6.1809041304450.71@tvgsbejvaqbjf.bet>
 <CAE5ih7_GgkEaVXONy8ZY9j43PX6GD-mkD9vJ1t93upAfTkM8tw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0a+KdJN1xzCPUSm61GSYLCETcjEdWuvG1rM2tddZwiXcucyjJIs
 Wacs4BPiXxIOWPWce+iC/AmfvF0zSY185zI6eqG7z4JVixakSTuje+snL2NKxlocu6TIocl
 8I9K1iwr4fLQaLivgtITzUKl8YTxdiaCq2fEcAVW0o2SeVwyf3AEl9ptX4TvBfH/+Sm5+TZ
 JgGtp9El4MKi0eNaPgE+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pHaQii7CO8I=:8giSvvlvfmJB1E/HOTdL2y
 EdICidDLzBpqO2qIfX1+VjNxkNHjVJw9b9xteopv4aiIFp0kABxlBD4wBUcshR+3NFKY/wrER
 R4rhnmEX23MRMhnzQL6NkQ9ygigZ0vmWxyJOpdL0lbwhZnUPzK3j6bI93gPmcZHE/nV2sZMkg
 kzKuOl0ewuPimHJI6aRGd0+7x+F6mdwGN7/nNi2no+FjgHm/GYn7aaZUwhKz+wvt2LC8MByo0
 tMfyZR4F5wH3TsirvxRBTEOyMnvq57YbTd+zq1POsajYJWfXANAaSv4kvnsfHnuCcV5n1quFv
 KnRN0OEVOoSlEBCRvgLFNqiOXgkzLmOegSL50ZeWNXiL6VakGTjLFe0Qs26AOtIjJ9oC45Nry
 s16YUk7Py4NZ0RbwrmwzrbKBTGJ2hIbK7wGKyhry8H9wXnCb4cOuXT9OIfAfubayN1L9w8dn7
 vRbLbR3KWUM7dJ1gmGvkXErW2t++HkWyg2caYeIewxmhDLegnMaUWlgZq9ACTbeL+K8tE8qpf
 W5FL4sSWcnsY89uksZ9WMboLey2a+jqo4EbRttz54jzLUUbOJtrDK9RNLHSHEmofzoM/Z/hi6
 cU5j+3Dcm2ILj8EXDVzzA+53Yrhm6RAXygLptaMJ+1Fgp6vPz4WdWl7o3gwVWqxAQ/cKzac3X
 Bb5MGNKZPCjxk3f8DMzNhbEm4+SssLXl8iqEyGqrlA74EZ7E/QSF8+ZL/yldl8QqBpj4D+tWJ
 3Bc5AAG+UXPTjCSf0eI5/jWpDaPRSwuGAx3aJHNHdwnt4UiCYwjYEIzTGgfsSJtX4g0C7oRt6
 RDvu+Ub
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke,

On Wed, 5 Sep 2018, Luke Diamand wrote:

> On 4 September 2018 at 12:09, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 4 Sep 2018, Eric Sunshine wrote:
> >
> >> On Mon, Sep 3, 2018 at 5:10 PM Johannes Schindelin via GitGitGadget
> >> <gitgitgadget@gmail.com> wrote:
> >> > So let's do something different in VSTS: let's run all the tests with
> >> > `--quiet` first, and only if a failure is encountered, try to trace the
> >> > commands as they are executed. [...]
> 
> Is this re-running just an individual test on its own or all the tests
> within a single file?

Upon encountering a failed test, it is re-running the entire test script
afresh.

> The latter shouldn't need this at all.

Please do not let me die dumb. In other words, I would love for you to
explain what exactly you mean by that sentence.

> And the former, I'm not sure will actually work - most of the tests
> assume some particular p4 state. But perhaps I'm missing something?

No, the former would not work at all. Not only for the p4 tests: Git's
tests frequently commit the deadly sin of relying on output of one another
(wreaking havoc e.g. when test cases are skipped due to missing
prerequisites, and latter test cases relying on their output). It is not
the only thing that is wrong with the test suite, of course.

> I also think it does look kind of ugly. And if there's one thing I've
> learned, it's that the ugly hack you write today with the words "we'll
> tidy this up later" goes on to live with you forever!

Okay.

(And having read lib-git-p4.sh, I kind of see where you learned that.)

But maybe you also have some splendid idea what to do instead? Because
doing something about it, that we need. We can't just say "oh, the only
solution we found is ugly, so let's not do it at all".

I am even going so far as to say: unless you have a better idea, it is
pretty detrimental to criticize the current approach. It is the opposite
of constructive.

So let's hear some ideas how to improve the situation, m'kay?

Just as a reminder, this is the problem I want to solve: I want to run the
tests in a light-weight manner, with minimal output, and only in case of
an error do I want to crank up the verbosity. Instead of wasting most of the
effort to log everything and then throwing it away in most of the common
cases, I suggest to re-run the entire test.

What do you suggest to solve this?

Ciao,
Johannes

> >> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >> > ---
> >> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> >> > @@ -445,10 +452,37 @@ test_ok_ () {
> >> >  test_failure_ () {
> >> >         if test -n "$write_junit_xml"
> >> >         then
> >> > +               if test -z "$GIT_TEST_TEE_OUTPUT_FILE"
> >> > +               then
> >> > +                       case "$(type kill_p4d 2>/dev/null | head -n 1)" in
> >> > +                       *function*) kill_p4d;;
> >> > +                       esac
> >> > +
> >> > +                       case "$(type stop_git_daemon 2>/dev/null |
> >> > +                               head -n 1)" in
> >> > +                       *function*) stop_git_daemon;;
> >> > +                       esac
> >>
> >> In the long run, it might make more sense, and be more scalable, to
> >> have those scripts define a "prepare_for_rerun" variable or function
> >> which this code then runs generically rather than having special
> >> knowledge of those facilities.
> >>
> >> I could imagine, for instance, test-lib.sh defining a no-op:
> >>
> >>     test_failure_prepare_rerun () {}
> >>
> >> and then each of those scripts overriding the function:
> >>
> >>     # in lib-git-p4.sh
> >>     test_failure_prepare_rerun () {
> >>         kill_p4d
> >>     }
> >>
> >>     # in lib-git-daemon.sh
> >>     test_failure_prepare_rerun () {
> >>         stop_git_daemon
> >>     }
> >
> > Or we could implement `test_atexit` (similar to `test_when_finished`, but
> > to be executed at `test_done` time). I guess that's what the p4 and daemon
> > tests really needed to begin with (and probably also the apache2-using
> > tests).
> >
> >>
> >> > +                       # re-run with --verbose-log
> >> > +                       echo "# Re-running: $junit_rerun_options_sq" >&2
> >> > +
> >> > +                       cd "$TEST_DIRECTORY" &&
> >> > +                       eval "${TEST_SHELL_PATH}" "$junit_rerun_options_sq" \
> >> > +                               >/dev/null 2>&1
> >> > +                       status=$?
> >> > +
> >> > +                       say_color "" "$(test 0 = $status ||
> >> > +                               echo "not ")ok $test_count - (re-ran with trace)"
> >> > +                       say "1..$test_count"
> >> > +                       GIT_EXIT_OK=t
> >> > +                       exit $status
> >> > +               fi
> >> > +
> >> >                 junit_insert="<failure message=\"not ok $test_count -"
> >> >                 junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
> >> >                 junit_insert="$junit_insert $(xml_attr_encode \
> >> > -                       "$(printf '%s\n' "$@" | sed 1d)")"
> >> > +                       "$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")"
> >> > +               >"$GIT_TEST_TEE_OUTPUT_FILE"
> >> >                 junit_insert="$junit_insert</failure>"
> >> >                 write_junit_xml_testcase "$1" "      $junit_insert"
> >> >         fi
> >>
> >> This junit-related stuff is getting pretty lengthy. I wonder if it
> >> would make sense to pull it out to its own function at some point
> >> (again, in the long run).
> >
> > Now that you mention it... I agree. This is getting long.
> >
> > In the short run, I have two things to consider, though: I want to make
> > this work first, then think about introducing a layer of abstraction, and
> > I want to go on vacation tomorrow.
> >
> > So I agree that this is something to be considered in the long run, i.e.
> > not right now ;-)
> >
> > Thanks,
> > Dscho
> 
