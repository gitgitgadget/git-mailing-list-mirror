Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C72361F97E
	for <e@80x24.org>; Mon, 20 Aug 2018 19:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeHTWxo (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 18:53:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:50359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbeHTWxo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 18:53:44 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2nfO-1gACPS1P1i-00sdx3; Mon, 20
 Aug 2018 21:36:44 +0200
Date:   Mon, 20 Aug 2018 21:36:42 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: pw/rebase-i-author-script-fix, was Re: What's cooking in git.git
 (Aug 2018, #04; Fri, 17)
In-Reply-To: <7b340c01-f57d-1a71-e4d5-0346bb042d0c@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1808202132510.73@tvgsbejvaqbjf.bet>
References: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com> <7b340c01-f57d-1a71-e4d5-0346bb042d0c@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wBBRWdmz9qAEDX2JtMYFn4qqtD7LE0FNHS3VYQD+rljLKwJK8p2
 IvFf+MHpbfXmEbLOHvwdnmDxinYqj5FMNneDThDOpw3+dHhJkcYRCXb7SN4GRCf8EH7sO3g
 JTzUkeijUhOLhcGVUF6Vvq4IpraGBKTMgrndYSQUk5GXxbmMpw+tTTSrIZ3PB50RzyT7Cox
 HyyqWkZXW/uSO7bP8yrQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FdnqpJPpSpU=:k1KtvC/Puumso86mEuWS0c
 jeVxbciUXZkeLp6n2QywMuxIQ7Y90xXzFZL/BeA/OC9Fumw1x7GXxM6eeHCzf7z+4KmiHRMUu
 AFStuSEmrCmuLN/qK3i3VyEaWx1zXPs5/XQhTDE13AQRYXc+lMbobPT/PDca33LqGkwDPldgw
 nl0c8wLUiFeMBjrQYjsNyNRDsugMa7E1NQVxyVafXNzuXHfzYZ+KpzbEaIpIPtkdD7OzPdCJG
 puPw/sKsWdSzba5GuLxKFFabOPiDWyAUAWifqn1xqDMrxThbQWYUBgb6IWEpP7IwC/u3buuz+
 hOH1b/B32PfvtGYzeVCcsSo9dY9OukSAKRApHU5dU/4JP75+pInEu1qqFcFeqLAiXuYwzFnXJ
 revBcnBudvtplLVVVk/dIy1/U5sswubs+HM6ycyRa+WH/ru/d58BY0Gl0BzyYZE9Mbq543QAC
 wsQhfYyQc9tdC5d5Lvu6HwfUFfQTITYTn5LC+5hQRbzu3P5juNrWPr6JVNhAY0ZKSN/q6tAY6
 dI5bJmAAypiOBOHJYU+XyHkRX7PKAi1QlTyrqJ94BySeLInQr0Axx5yS6Ku+dOI4DfTKADwOn
 tv8yErDXzLdFzG2wcaoJBhTiiD/JKKM3EEUGqZzdF2jV6j7V1tUwFlS4yEoXvi/w8p0qJSpea
 Ci3zZ+gpUPBti6KluP7FYGoC9VKH2O2MLSSyRWt7ZMdzFT8yJ9lsqsgEf3nLe42G3U1bO6uJG
 Q2OvWqacfSfXxyQYguhTifUAc9G0UMjJe9+D5WNmiqbXS4naNs+fwyAoPq+S6/1j8LG0wOg9f
 1UIryXR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

On Mon, 20 Aug 2018, Phillip Wood wrote:

> On 17/08/2018 23:44, Junio C Hamano wrote:
> > Here are the topics that have been cooking.  Commits prefixed with
> > '-' are only in 'pu' (proposed updates) while commits prefixed with
> > '+' are in 'next'.  The ones marked with '.' do not appear in any of
> > the integration branches, but I am still holding onto them.
> 
> > * pw/rebase-i-author-script-fix (2018-08-07) 2 commits
> >  - sequencer: fix quoting in write_author_script
> >  - sequencer: handle errors from read_author_ident()
> > 
> >  Recent "git rebase -i" update started to write bogusly formatted
> >  author-script, with a matching broken reading code.  These are
> >  being fixed.
> > 
> >  Undecided.
> >  Is it the list consensus to favor this "with extra code, read the
> >  script written by bad writer" approach?
> 
> I think there was agreement between myself and Eric on the last version,
> I'm not sure anyone else has expressed an opinion. The problem with
> fixing the quoting without any backwards compatibility is that if git is
> upgraded while a rebase is stopped read_author_script() will happily use
> the broken quoting to create a corrupted author name in the new commit
> if the name contains "'".
> 
> The compatibility code in the latest version relies on the missing "'"
> at the end of the GIT_AUTHOR_DATE line which is fixed by
> es/rebase-i-author-script-fix which is now in master. If there is a
> release with es/rebase-i-author-script-fix but not
> pw/rebase-i-author-script-fix we'll have to rethink as the detection
> wont be reliable. I have a branch that fixes read_author_script() to use
> sq_dequote() at
> https://github.com/phillipwood/git/commits/wip/fix-author-script. At the
> moment it has compatibility with broken quoting, but I could strip that
> out and then sq_dequote() will return an error with the broken quoting
> and the user would have to restart the rebase. So one option is to drop
> this series and wait for me to finish the improved solution next month.

Having thought about it, I am now convinced that it wold be overkill to
cater to "upgrade in the middle of a rebase". I think we should drop that
part, as it uglifies the code rather a lot, and the impact is not worth
the effort IMHO.

Ciao,
Johannes
