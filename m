Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9085C1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 11:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeIDPd7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 11:33:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:58995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbeIDPd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 11:33:59 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWQSM-1gP7Fm3lBi-00XYEf; Tue, 04
 Sep 2018 13:09:17 +0200
Date:   Tue, 4 Sep 2018 13:09:15 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/9] tests: include detailed trace logs with --write-junit-xml
 upon failure
In-Reply-To: <CAPig+cRGHPfNqdgRr6H_D_siKCFZBDsUrcp0F+CWNCx884AJVg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1809041304450.71@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <942bf423a461a3b44e2ff254c90907a539d7abbe.1536009027.git.gitgitgadget@gmail.com> <CAPig+cRGHPfNqdgRr6H_D_siKCFZBDsUrcp0F+CWNCx884AJVg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pBhLwKFJfDulU0/DfIbKzD7tE+rjX3e3cmpfbTZIDE/ok5G5dS5
 P5T8O1fEzKRitzMwCOX5oLT1pqfcYLeEeIWZkT9tH1lhHAH7tIrXYieeLJkjX6zXFmNRX7o
 Lc67YbkRQHs4c5+BarUxoak/J7m1gw1iDmZm7uGuAemiuPZ5ZpICkOjMhbTFMmDzm/MQkpc
 0Jx2VtGhkPIeDDu3nUonA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EQSmcs9A1kY=:2ZS0eTJiAusdLH34KUIAlp
 X6Bfv3CvZWiTOTJUZEf+2ADt57H/JVQ3js9YvPno1ZEBXDiR1KYk1nehPaEwKSDXjXmAoDX90
 sLZp1w73bCGdcS6y+zkgZ3Pdef2NQwBPpLaV/MCpIrxFGtr+j5/awRsmVy1nZufIo5h9qLVir
 MzzuI+gbeAsMyHt4bW4CyrcViG8ELQRGoCzfybxK+sqZi9hbMPrnV17lvPFq021IQan9lCZk0
 a/0SdATpQ9TmD73fTKnqeK/EquDxeNSN//1/i2ST2Mc6g1OgOvq4p8wCbt/NvV/PaMj9ZWiDr
 2qxIJjobwD4PQdOcTRbn+j5pBJPr/JKHBiS2+AOiMxLPftMC79QretrM2Fyzta45PPOuUTY2g
 QydcC0fS58L0EZRicfi4yJjE7FMB2h+Vo7elW70ABDRQH+J9yqjxCjYHn7KsbsQoPSRnFNVju
 4tVLVyoqhjSnDJYZj10Z+TRGvR2bVZ5DA45SPnXxiujKew9eZ8+QGSM1TfG9CQ2a6/xOlUpRF
 XHFjcHXq37ZC0u8g8enbI3lk5TCqLvXzLpEO+sweILh3EmgrCKi/6sPBNwaTZZZMrD1pqe/0I
 3oOSU4sX9wEbz6Uz2/WXiyxlVV8ptXqI4eBoewtSKs4Lsak1jMhAXm+cvYjwNn65vcWormCb1
 LlLkgACFerv8k5U/uNP9uskoTYfgSJVJ63jU9ovafERpL9jYGrlJhbPeRGxGoez6M7Zn0kpK+
 1yWPWAsletoJlIT22r9NKxQvFVA9w/TM3mFMlWiGultgyS/Wg50MS4GJ2mOPS9loed1mIEImG
 1FFOA0/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, 4 Sep 2018, Eric Sunshine wrote:

> On Mon, Sep 3, 2018 at 5:10 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > So let's do something different in VSTS: let's run all the tests with
> > `--quiet` first, and only if a failure is encountered, try to trace the
> > commands as they are executed. [...]
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > @@ -445,10 +452,37 @@ test_ok_ () {
> >  test_failure_ () {
> >         if test -n "$write_junit_xml"
> >         then
> > +               if test -z "$GIT_TEST_TEE_OUTPUT_FILE"
> > +               then
> > +                       case "$(type kill_p4d 2>/dev/null | head -n 1)" in
> > +                       *function*) kill_p4d;;
> > +                       esac
> > +
> > +                       case "$(type stop_git_daemon 2>/dev/null |
> > +                               head -n 1)" in
> > +                       *function*) stop_git_daemon;;
> > +                       esac
> 
> In the long run, it might make more sense, and be more scalable, to
> have those scripts define a "prepare_for_rerun" variable or function
> which this code then runs generically rather than having special
> knowledge of those facilities.
> 
> I could imagine, for instance, test-lib.sh defining a no-op:
> 
>     test_failure_prepare_rerun () {}
> 
> and then each of those scripts overriding the function:
> 
>     # in lib-git-p4.sh
>     test_failure_prepare_rerun () {
>         kill_p4d
>     }
> 
>     # in lib-git-daemon.sh
>     test_failure_prepare_rerun () {
>         stop_git_daemon
>     }

Or we could implement `test_atexit` (similar to `test_when_finished`, but
to be executed at `test_done` time). I guess that's what the p4 and daemon
tests really needed to begin with (and probably also the apache2-using
tests).

> 
> > +                       # re-run with --verbose-log
> > +                       echo "# Re-running: $junit_rerun_options_sq" >&2
> > +
> > +                       cd "$TEST_DIRECTORY" &&
> > +                       eval "${TEST_SHELL_PATH}" "$junit_rerun_options_sq" \
> > +                               >/dev/null 2>&1
> > +                       status=$?
> > +
> > +                       say_color "" "$(test 0 = $status ||
> > +                               echo "not ")ok $test_count - (re-ran with trace)"
> > +                       say "1..$test_count"
> > +                       GIT_EXIT_OK=t
> > +                       exit $status
> > +               fi
> > +
> >                 junit_insert="<failure message=\"not ok $test_count -"
> >                 junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
> >                 junit_insert="$junit_insert $(xml_attr_encode \
> > -                       "$(printf '%s\n' "$@" | sed 1d)")"
> > +                       "$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")"
> > +               >"$GIT_TEST_TEE_OUTPUT_FILE"
> >                 junit_insert="$junit_insert</failure>"
> >                 write_junit_xml_testcase "$1" "      $junit_insert"
> >         fi
> 
> This junit-related stuff is getting pretty lengthy. I wonder if it
> would make sense to pull it out to its own function at some point
> (again, in the long run).

Now that you mention it... I agree. This is getting long.

In the short run, I have two things to consider, though: I want to make
this work first, then think about introducing a layer of abstraction, and
I want to go on vacation tomorrow.

So I agree that this is something to be considered in the long run, i.e.
not right now ;-)

Thanks,
Dscho
