Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B42F20229
	for <e@80x24.org>; Fri, 21 Oct 2016 13:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755265AbcJUNJA (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 09:09:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:54913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933306AbcJUNI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 09:08:56 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MKKaI-1by7n8434Y-001h50; Fri, 21 Oct 2016 15:08:37
 +0200
Date:   Fri, 21 Oct 2016 15:08:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #05; Thu, 20)
In-Reply-To: <xmqqk2d2ein7.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610211457030.3264@virtualbox>
References: <xmqqk2d2ein7.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JMGtvPM4Kii2wH5qELA6h9OTF5S/SRZfq++mqOHhvvFFmJW48a4
 BAhPvg5VnyoWtUk0ti/zsjHWYVumh1asbRJjLPuwB0k1yceOlAMfO7DQbK8YPlVh7pqrPmr
 rX3lu00qsAgm3G5A492MiuoQq2AGevjJh3m13aUhhbfJpgsi4XOXnaRnw4xdgEj44T+RrcC
 wdjQr92qOTnhHYVk1SNmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:veDb8hhcELM=:KtmlqUEPOq9xdCDg8u24Ek
 njFMYC0tNEJ/fmjFraGfPLai3GqtTCYsZZtTLJM2ExwGGQe0SPfrSuowh6TekXKz8/5l7kOnF
 9QEcq7x7kePnekzq8Zqcb/Lrpu0E9YkPNGOsvWtVy/XrfVe85OhHbAu+ezG2ZOO8lXjqtkWSr
 53HMSYmx0rch95S+MqDL+qJp2x3tYiI0RQndyKBGOVZq2OLOJ4ZqSSYVg2XtrQFGuDzLKulr7
 kwV4gYO9y64YOTbkEU3vhlsvUWkx5hwH1FnRNJwcc4/X65hCo6JntPGBtOZz44W1qTnPiO+bx
 Ppm0kSl7/sADcZmPMA0+HTGYCyqFE7lL72qU2Az4uZTvZ5rtg+bCAc749LmsUwJJZyaVEp1yU
 bpSnf2/qVeZPJpUaSeFfHNiI3kGo3n/vKJ8p5EXhf3htzErF+gba8k13xu0b5InjymTNH2rkt
 moEQaiMudly/GGAYBvAbmqL0zltocENjzScWxrmpQ9SLRLv3Hd226THsG7ZVztSiSpi6as3XK
 RQVR5PheHx+60jilrMR4MVxgmVnCHv54cRoqfW2JvsSqcT/+4TaRa3dK6OmPKaTWxsHghcY9+
 8uiGHrymocU7Fo6gSwB9j/9VYe4dNREmOrF7pb0mCgjo5blbrjmsIa0y4G43+zA5qhm4S+88f
 gOgcZlMwBUeJIG/k42g4pAq2hy+bKEd06EcOoZtZ5lGWKepsYnY8Cu+Ute0TSy9VHWTdMJoLh
 vvSIgd6iS6v8dgixRisenDehGZKq8htxZfq06OGkLz+jJ+rWwV/0f6JcJkSBJx84DdfDz8vIt
 Cmn1ZK1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Lars,

On Thu, 20 Oct 2016, Junio C Hamano wrote:

> * ls/filter-process (2016-10-17) 14 commits
>   (merged to 'next' on 2016-10-19 at ffd0de042c)
>  + contrib/long-running-filter: add long running filter example
>  + convert: add filter.<driver>.process option
>  + convert: prepare filter.<driver>.process option
>  + convert: make apply_filter() adhere to standard Git error handling
>  + pkt-line: add functions to read/write flush terminated packet streams
>  + pkt-line: add packet_write_gently()
>  + pkt-line: add packet_flush_gently()
>  + pkt-line: add packet_write_fmt_gently()
>  + pkt-line: extract set_packet_header()
>  + pkt-line: rename packet_write() to packet_write_fmt()
>  + run-command: add clean_on_exit_handler
>  + run-command: move check_pipe() from write_or_die to run_command
>  + convert: modernize tests
>  + convert: quote filter names in error messages
> 
>  The smudge/clean filter API expect an external process is spawned
>  to filter the contents for each path that has a filter defined.  A
>  new type of "process" filter API has been added to allow the first
>  request to run the filter for a path to spawn a single process, and
>  all filtering need is served by this single process for multiple
>  paths, reducing the process creation overhead.
> 
>  Will merge to 'master'.

This breaks in Git for Windows' SDK (I only now realized that t0060 was
not the only thing breaking in `next` for a while now):

-- snip --
not ok 15 - required process filter should filter data
#
#               test_config_global filter.protocol.process
#               "$TEST_DIRECTORY/t002
#               1/rot13-filter.pl clean smudge" &&
#               test_config_global filter.protocol.required true &&
#               rm -rf repo &&
#               mkdir repo &&
#               (
#                       cd repo &&
#                       git init &&
#
#                       echo "git-stderr.log" >.gitignore &&
#                       echo "*.r filter=protocol" >.gitattributes &&
#                       git add . &&
#                       git commit . -m "test commit 1" &&
#                       git branch empty-branch &&
#
#                       cp "$TEST_ROOT/test.o" test.r &&
#                       cp "$TEST_ROOT/test2.o" test2.r &&
#                       mkdir testsubdir &&
#                       cp "$TEST_ROOT/test3 'sq',\$x.o" "testsubdir/test3
#                       'sq',
#                       \$x.r" &&
#                       >test4-empty.r &&
#
#                       S=$(file_size test.r) &&
#                       S2=$(file_size test2.r) &&
#                       S3=$(file_size "testsubdir/test3 'sq',\$x.r") &&
#
#                       filter_git add . &&
#                       cat >expected.log <<-EOF &&
#                               START
#                               init handshake complete
#                               IN: clean test.r $S [OK] -- OUT: $S . [OK]
#                               IN: clean test2.r $S2 [OK] -- OUT: $S2 .
#                               [OK]
#                               IN: clean test4-empty.r 0 [OK] -- OUT: 0
#                               [OK]
#                               IN: clean testsubdir/test3 'sq',\$x.r $S3
#                               [OK] -
#                               - OUT: $S3 . [OK]
#                               STOP
#                       EOF
#                       test_cmp_count expected.log rot13-filter.log &&
#
#                       filter_git commit . -m "test commit 2" &&
#                       cat >expected.log <<-EOF &&
#                               START
#                               init handshake complete
#                               IN: clean test.r $S [OK] -- OUT: $S . [OK]
#                               IN: clean test2.r $S2 [OK] -- OUT: $S2 .
#                               [OK]
#                               IN: clean test4-empty.r 0 [OK] -- OUT: 0
#                               [OK]
#                               IN: clean testsubdir/test3 'sq',\$x.r $S3
#                               [OK] -
#                               - OUT: $S3 . [OK]
#                               IN: clean test.r $S [OK] -- OUT: $S . [OK]
#                               IN: clean test2.r $S2 [OK] -- OUT: $S2 .
#                               [OK]
#                               IN: clean test4-empty.r 0 [OK] -- OUT: 0
#                               [OK]
#                               IN: clean testsubdir/test3 'sq',\$x.r $S3
#                               [OK] -
#                               - OUT: $S3 . [OK]
#                               STOP
#                       EOF
#                       test_cmp_count expected.log rot13-filter.log &&
#
#                       rm -f test2.r "testsubdir/test3 'sq',\$x.r" &&
#
#                       filter_git checkout --quiet --no-progress . &&
#                       cat >expected.log <<-EOF &&
#                               START
#                               init handshake complete
#                               IN: smudge test2.r $S2 [OK] -- OUT: $S2 .
#                               [OK]
#                               IN: smudge testsubdir/test3 'sq',\$x.r $S3
#                               [OK]
#                               -- OUT: $S3 . [OK]
#                               STOP
#                       EOF
#                       test_cmp_exclude_clean expected.log
#                       rot13-filter.log &&
#
#                       filter_git checkout --quiet --no-progress
#                       empty-branch &
#                       &
#                       cat >expected.log <<-EOF &&
#                               START
#                               init handshake complete
#                               IN: clean test.r $S [OK] -- OUT: $S . [OK]
#                               STOP
#                       EOF
#                       test_cmp_exclude_clean expected.log
#                       rot13-filter.log &&
#
#                       filter_git checkout --quiet --no-progress master
#                       &&
#                       cat >expected.log <<-EOF &&
#                               START
#                               init handshake complete
#                               IN: smudge test.r $S [OK] -- OUT: $S .
#                               [OK]
#                               IN: smudge test2.r $S2 [OK] -- OUT: $S2 .
#                               [OK]
#                               IN: smudge test4-empty.r 0 [OK] -- OUT: 0
#                               [OK]
#                               IN: smudge testsubdir/test3 'sq',\$x.r $S3
#                               [OK]
#                               -- OUT: $S3 . [OK]
#                               STOP
#                       EOF
#                       test_cmp_exclude_clean expected.log
#                       rot13-filter.log &&
#
#                       test_cmp_committed_rot13 "$TEST_ROOT/test.o"
#                       test.r &&
#                       test_cmp_committed_rot13 "$TEST_ROOT/test2.o"
#                       test2.r &&
#                       test_cmp_committed_rot13 "$TEST_ROOT/test3
#                       'sq',\$x.o" "
#                       testsubdir/test3 'sq',\$x.r"
#               )
#
ok 16 - required process filter takes precedence
not ok 17 - required process filter should be used only for "clean"
operation on
ly
#
#               test_config_global filter.protocol.process
#               "$TEST_DIRECTORY/t002
#               1/rot13-filter.pl clean" &&
#               rm -rf repo &&
#               mkdir repo &&
#               (
#                       cd repo &&
#                       git init &&
#
#                       echo "*.r filter=protocol" >.gitattributes &&
#                       cp "$TEST_ROOT/test.o" test.r &&
#                       S=$(file_size test.r) &&
#
#                       filter_git add . &&
#                       cat >expected.log <<-EOF &&
#                               START
#                               init handshake complete
#                               IN: clean test.r $S [OK] -- OUT: $S . [OK]
#                               STOP
#                       EOF
#                       test_cmp_count expected.log rot13-filter.log &&
#
#                       rm test.r &&
#
#                       filter_git checkout --quiet --no-progress . &&
#                       # If the filter would be used for "smudge", too,
#                       we woul
#                       d see
#                       # "IN: smudge test.r 57 [OK] -- OUT: 57 . [OK]"
#                       here
#                       cat >expected.log <<-EOF &&
#                               START
#                               init handshake complete
#                               STOP
#                       EOF
#                       test_cmp_exclude_clean expected.log
#                       rot13-filter.log
#               )
-- snap --

Unsurprisingly, bisect identifies "convert: add filter.<driver>.process
option" as the first bad commit, although it only fails on the test case
15, but not on 17.

I am unfortunately still busy with trying to figure out what exactly makes
t6030 hang on `pu` (seems it thinks stdin is a tty and just waits for an
answer), and then trying to reduce that insane amount of time wasted on
running, and waiting for, the test suite, and for unrelated reasons I'll
have to go offline for the rest of the day, so I will most likely be
unable to assist further with this.

Sorry,
Johannes
