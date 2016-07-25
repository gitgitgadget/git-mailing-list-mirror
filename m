Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 879ED203C1
	for <e@80x24.org>; Mon, 25 Jul 2016 08:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbcGYIHX (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 04:07:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:61611 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522AbcGYIHV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 04:07:21 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LvPgd-1bItv903WN-010gor; Mon, 25 Jul 2016 10:07:12
 +0200
Date:	Mon, 25 Jul 2016 10:06:28 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Ilya Tumaykin <itumaykin@gmail.com>
cc:	git@vger.kernel.org
Subject: Re: Bug: "git log --format='format:%+s%+b'" doesn't insert newline
 before body
In-Reply-To: <1693749.WYZjdcdZj5@photon>
Message-ID: <alpine.DEB.2.20.1607251003360.14111@virtualbox>
References: <8915446.47C9zkNvuX@photon> <alpine.DEB.2.20.1607250926320.14111@virtualbox> <1693749.WYZjdcdZj5@photon>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QhE48vom0jt6fpxxfqDQqQP3nj60vKFGVNgIdX7/uPBZl754GeU
 eu2LqiCe8N0BlnbEw0SiSIf2hh3xBL+1i4/8IQy1m7eTYxqdfgpM4ZjaywkWp9QWwSrlqlu
 Sk4OojMBxG/lgIvQruDz03R48a51nI9uwRGn5lH91xmL/HqFscN4XfuMHvxeUv6kDpOvemc
 kSfrkGTEH7pmATnfwPn7w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:+PU90Mq8Ets=:TUzMiV4cPUezN7h6cZGaEv
 VMHDn+tHnEuSm9nlcquB5JEKYV6F02P4XsdaEU2zEj5DBFsgWdqhRaW1fGHmhtxOdtpRPwDPs
 ywXD7fmd+jc0/8Dp4JLDEwTtEQpCHUxmlnUgB0C3n1JB3MTki+ZsG70n+Lt7F+e77/TN2kUFw
 TMhc09gJGxa0t8pKJ2k6cAZlHF0c3jC6QyyTtUfh5VouS336Z8X32QOdyamRTliAqX4XCPmv8
 g85nX+QUkyTqB5Jw0zrlAafVkvbKjgB19I8af2EXemRQLpqGh/SiIZjp9vtj7R/7ZtqBYAkn+
 ee93Msx03N0hq9KIoq0YfJYj3HcWRB5cS/yP5PpN3YRrioeDz5nXiAEmgjomLUEj+qnRHOHuZ
 JEPpDl77jwi4keytHnTLP1OZqqfmwNcraGdBoGo/1TpQBQKmrCZkjFgTcJliS0HTDMp9fpGnu
 Gcg4sU7FWqzSfYguRvazaUU30OtsZMjejAWbHzegyRNxsR3kNbidvqRX6+9L7uRZD6OiRsbdK
 3XWgXbnjSwKFhDhnx0Gw+gXadNQ6caEzwi92fMjrigYPQwGoCHSbELoNBycKrYMsBfRhRcKsN
 sYQP8hm/XM726OBgWPLiRerwmDhuaJtvma0Fwvf0Dh3vdZqHuWS9pX57psQ6WVpeyshV9sI5H
 qa3h2ZoISHV9aHSYguGIxUHH4Gt3+BIwGvZJsscV9umKfhw2PUudpYxGOF7DVXAtJhF6W8nI7
 +TgPUyTL5AXoY9g8ZfoQF+KHrVbweStb83XQF8IuNTV/R848Z1jg+Jj4pqvOjGf2SinQp2Vyb
 FOs0VpI
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Ilya,

On Mon, 25 Jul 2016, Ilya Tumaykin wrote:

> On Monday 25 July 2016 09:33:00 Johannes Schindelin wrote:
> > 
> > On Sun, 24 Jul 2016, Ilya Tumaykin wrote:
> > [...]
> > > $ git --no-pager log -1 --format='format:%+s%+b'
> > > 
> > > Actual results:
> > > ```
> > > 
> > > This is subject
> > > And this is body
> > > ```
> 
> According to 'git-log' man page '%+b' should insert linefeed "immediately 
> before the expansion if and only if the placeholder expands to a non-empty 
> string." Here "%b" expands to a non-empty string, thus I expect a linefeed 
> before it. Or am I misinterpreting man page somehow?

The line break is there: after the subject. The misinterpretation is most
likely the assumption that the new-line "character" is part of the commit
subject; It is not.

> > Unless you somehow allow empty commit messages (Git does not, unless
> > you play games with low-level commands), the second '+' is
> > unnecessarily conditional. Therefore "%s%n%+b" *might* do what you
> > intended (I would not know, because that information was missing from
> > the report).
> 
> I want to display '%B', but add colours to '%s'. Thus I have to
> separately include '%s' and '%b', and not just '%B'. I was using
> '%+s%n%+b' with extra colour formatting as a workaround for some time
> now.

Okay. Hopefully the explanation above clarifies that this is not a
work-around, but the correct solution.

Ciao,
Johannes
