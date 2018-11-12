Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B46011F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 13:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbeKLX1V (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 18:27:21 -0500
Received: from mout.gmx.net ([212.227.15.19]:40347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729173AbeKLX1V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 18:27:21 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LsUDg-1fKNRV0AeG-011yxO; Mon, 12
 Nov 2018 14:33:49 +0100
Date:   Mon, 12 Nov 2018 14:33:47 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/5] stop installing old libexec aliases like
 "git-init"
In-Reply-To: <20181102223743.4331-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811121431430.39@tvgsbejvaqbjf.bet>
References: <87efkkdwcv.fsf@evledraar.gmail.com> <20181102223743.4331-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-349336788-1542029629=:39"
X-Provags-ID: V03:K1:6VT/d+F5eKKQo+cuOGIFnXI+1MqStUVd5kuToOMmIowzoJWwMPT
 y//DoEnIO5JJIXpEkwRUXVIFBv6ZvHBYwpG5UjTCyKQ+OALAeiuYj2cNVjjsVN9RVFjhZuX
 tgksWl2TlpQQh5kPDpjGeQwqwreEvHsPNPzcqIjGAgRKaRUUB7DNasXW8OdZ9Wr2E97KPPu
 MhXnGGGOFf7PcE+B0Qg7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4sqouynFkH4=:/Vo5uzReeG0zwsYkKr3EYz
 VrLDxb7kTbrUbFvM70p86bqT4NR/iqC0yuKuM7xUHatnQ9+FNR0U9VOOLbSfFK8Su5U7J7++E
 Ew6ax9Z2TStri5+4uQxJYvyt7nOPTqghJj4lAaDc16gWw/miVpSWXJOLyCCOaIDLgrqHtwxzv
 /ANNOIpfMsUhgzZhPYw28lh+v8AujD9iYcy3IVa1w6oky3OK1o48TQkGQh5XG532gdTNjYmXu
 8tkXbyn6UvqVzOlxOI151O9wmDkF4ispUIrc5YAYbA+TYsLDPD/sbckU2odbLGWmufcXVxeAP
 XF/jU8U+v5R20fJ26xroe9WxxwR2ArWWQN0R9kDhm7dI7xp8kM9cV95YJ0NQpZQ4hGA/MMByG
 DooLbGKjv75c2cyGxxMmGMNqy58NWdzu26X/ahV4ZDgxoYyfUOJ0iGxSUn0vJh5H1DBO4SS/A
 cOVoDKgktZAvtY59jKPIcr4Itf0vhM6eQRnm7VuGKmFBNkNlO23iqTnRLi8cOkCpwyMdnZ/xF
 S8XAxpaq8vYmZa8MGY0h+am7VW7Hq9wY9WfIkwVFcuwxXjkOBcnapZwKSSMmxe05C93DfB3CH
 /xjNvzjVeR2dKauDEmu17qJUga1qoC2GeUlfPzqlM6CIOIRabKBMl0teAsgXUZAJ0QfzfhA9T
 v2zCxQOg65XrvPYo1Xbixg+Ee1SdrvUN2x5hGHKzS3ewEhmdfIaCv2dEkIW9H93/d0RkjwWaz
 1kbFcZgrxHwvstUvsvCbGzi49cBzBgUuGGR1ZCBUpQWpJagTMwKo7ejwLD0754Mj/w4RWLXnT
 ET93tBpNV+uMXtHEsmcM81O8DLO4PVCmsuA3Ber6jSqnkxgqJlWiz6aaCWM14ByqLqr2LTzwD
 NrQYyqVzbPHR7veS/5BeiJsjPYOyVFFL0w1/mDPVvOKG8ni8w4xffH2UuFKX3v67kqZtl9NTD
 L3XKM+sGBDg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-349336788-1542029629=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Fri, 2 Nov 2018, Ævar Arnfjörð Bjarmason wrote:

>  * GIT_TEST_INSTALLED breaks entirely under this, as early as the
>    heuristic for "are we built?" being "do we have git-init in
>    libexecdir?". I tried a bit to make this work, but there's a lot of
>    dependencies there.

I have a couple of patches in the pipeline to improve
`GIT_TEST_INSTALLED`, as I needed it to work without hardlinked copies of
the built-ins. These patches might help this here isue.

>  * We still (and this is also true of my ad874608d8) hardlink
>    everything in the build dir via a different part of the Makefile,
>    ideally we should do exactly the same thing there so also normal
>    tests and not just GIT_TEST_INSTALLED (if that worked) would test
>    in the same mode.
> 
>    I gave making that work a bit of a try and gave up in the Makefile
>    jungle.

Yep.

Ciao,
Dscho
--8323328-349336788-1542029629=:39--
