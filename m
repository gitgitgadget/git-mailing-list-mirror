Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2CFB1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 18:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeIOAHf (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 20:07:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:37437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbeIOAHf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 20:07:35 -0400
Received: from MININT-6BKU6QN.attlocal.net ([108.198.118.51]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M1BMy-1fhJ2K3JEm-00tCbZ; Fri, 14 Sep 2018 20:51:41 +0200
Date:   Fri, 14 Sep 2018 13:51:36 -0500 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Luke Diamand <luke@diamand.org>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/9] tests: include detailed trace logs with --write-junit-xml
 upon failure
In-Reply-To: <CAPig+cQkC4-6DyQdJHc8QUfBx+L6o1SK4ODy4MoP44+VHHk96Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1809141346340.73@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <942bf423a461a3b44e2ff254c90907a539d7abbe.1536009027.git.gitgitgadget@gmail.com> <CAPig+cRGHPfNqdgRr6H_D_siKCFZBDsUrcp0F+CWNCx884AJVg@mail.gmail.com> <nycvar.QRO.7.76.6.1809041304450.71@tvgsbejvaqbjf.bet>
 <CAE5ih7_GgkEaVXONy8ZY9j43PX6GD-mkD9vJ1t93upAfTkM8tw@mail.gmail.com> <nycvar.QRO.7.76.6.1809051430390.71@tvgsbejvaqbjf.bet> <CAPig+cQkC4-6DyQdJHc8QUfBx+L6o1SK4ODy4MoP44+VHHk96Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JegwNRR2NiBuNCPxBBAL9Wx79hbFnma6ghT/lYCtAs+XS8IsF5U
 yGyx/g2TQETZ3PzCFl12oV2Uo/OaEz9q2W0JsgdkU7vjJLisLGF24Z5TEzJAPXdD+ApcCv/
 6PWffhuEhZJUsJePUN/A5bPrgQFd85RmijZiXKy4ocoV0tZ6MKNit3hZeTfClk76DbKy5iY
 2Wik4VKxLtSgdQZyPsnlQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2+ogaHuz2uI=:7g85QBsOpZhvxbTBdG78kw
 XR6FBeaVm7eTUkKDQSmm9mLRYFWV0/xIJCoGceUEHa9+NWAcIjcAoqAfywE5EAtVOKRNuiC4w
 1J93bbVuwHQVkHfn326KvTwkk+nkxWC9Z//uDDphwWhrIfeEvKoYBLHKi9LrwcIJVLCvkmSEm
 wRYCMpqk2bYv0SddstFwtyMSvsIS+m9zefbBwUjgn6GKesofUT4dTudH9K6Uwq64HvgtvA0qg
 UZZzcZEH8gJdHkXBWXY6twyg3yOZPwO8igfQ+RLd34gABCSdaJPRUTC941iLqLUaizkeDWed8
 c0YVFDu0dXnYE73qMDbCVnbVOtI2jOuIKkGvJXC13yJdatabBw8C8SNFMUe0ubqY93mDzd7a1
 Uc5DAZTJ9AbnUcdOqBWGtChT9ncdooifN2uAVGw9VvDV21GP9HBWZKe+uxTzSBU5dh4cdGa6F
 6SqApGupyfwf624HOnTWbOtrtpgUkmHVUbUctcHBopspIfJKCo9dbZvo+3nOR5zrIMspU6Le6
 6F9/LXhTXr7vTDbZVbZwRXdlthPvDM2N2zqQ4hvEAU9BPyPqFVDJ7HS2kdV5jp0GOMgLxWfC5
 FjXU9SqrE2m9inR4yqSvURF14If/g7P8v//vfvxxpE43kLIG437VQmXtZEFKD/uSrMbi+jAf4
 afdzL2Td7yskoG4Fk1JHjuOVsZ0lY385Jnju/xlpJOHaHFsRl1IENFmIqSgtmmq4Y+icKg/Eh
 CxKkImjVG7/Whj0MJO5SDPzI2DHoY4Kba+x21Sxiz1UjNo+4ApNUIQ7K5XKzjyyV1gxGdeyyC
 dEqrR5kVtr3X+ulMGwkDWesmm7uLqKu5pvIlnBOSy8Sho+Q5fU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 5 Sep 2018, Eric Sunshine wrote:

> On Wed, Sep 5, 2018 at 8:39 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > So let's hear some ideas how to improve the situation, m'kay?  Just as
> > a reminder, this is the problem I want to solve: I want to run the
> > tests in a light-weight manner, with minimal output, and only in case
> > of an error do I want to crank up the verbosity. Instead of wasting
> > most of the effort to log everything and then throwing it away in most
> > of the common cases, I suggest to re-run the entire test.
> 
> What about the very different approach of capturing the full "verbose"
> output the executed tests in addition to whatever is actually output
> to the terminal?

I fear it is not really possible to do a "verbose but not really" mode. I
want the console output to be quiet, there is no use in chatting up the
build log with these messages, as we have to run the tests in parallel, so
the output would be utterly hard to interpret anyway. At the same time, I
want verbose output for use in the test results. It is not really possible
to `tee` all output, then "quiet down" the part that makes it into the
log.

> If a test fails, then (and only then) you can insert the captured
> verbose output into the JUnit XML file.

Yep. That's what my patch series does.

If a test fails, then (and only then) I re-run the script with verbose
output that is immediately moved into that JUnit XML file.

> This way (if we always have the full verbose output at hand), you don't
> need to re-run the test at all.

But that way, if we always have the full verbose output, the build log
will be unnecessarily verbose and confusing.

> I've cc:'d Peff and Jonathan since I believe they are more familiar
> with how all the capturing / output-redirection works in the test
> suite.

Okay.

Ciao,
Dscho

P.S.: An unintended side effect of re-running the tests is to identify
flakey tests. I do not yet have a way to represent this outcome in the
test result, but I deem this an additional benefit in favor of keeping my
current strategy.
