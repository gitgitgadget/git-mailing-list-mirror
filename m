Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70CE520281
	for <e@80x24.org>; Mon,  2 Oct 2017 14:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbdJBOGe (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 10:06:34 -0400
Received: from mout.web.de ([212.227.15.4]:62563 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbdJBOGd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 10:06:33 -0400
Received: from [192.168.178.36] ([91.20.57.42]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ls9JH-1dK9Tk1IB5-013xjW; Mon, 02
 Oct 2017 16:06:31 +0200
Subject: Re: What means "git config bla ~/"?
To:     git@vger.kernel.org
References: <20171002061303.Horde.SL92grZCqTRV9oQkBFPELQ7@crashcourse.ca>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <dd28de03-9286-d5aa-3f00-9f6b7a85d71b@web.de>
Date:   Mon, 2 Oct 2017 16:06:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171002061303.Horde.SL92grZCqTRV9oQkBFPELQ7@crashcourse.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ExCiFHf749F1tcoi+rutm17gLwQE9HJko7cZ1ssv55J+dpeOGGi
 PNhvRU+drvXcdW7oU+y8TAaKcRBmViqSZSonWqOjZrn9D6d9UqoNs8cwrlFoExZcFsY78DL
 WuoiJdQ+9rBMsvSijGh/+INOnAA4kECbA0H8yIF4+xYcj+qFx8k2JC1fcVrGWd99kV58fZJ
 8x+eatPUMdHZG9u+56Fwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bj1/nZsYLOM=:mATF+0VR4q3jPI22B3JORM
 O09S0RuIuroKfgrAe4nDur/XAgEwJjFpRvWIQ/MaxWmrlEq8gdaFS94A6d2glxHwB1A6tAFZx
 ZAlPPyxqBJ08liTyfVglh8c1MdnMlAxMTT92SiZfsv7CONtx+jFPiYhtYkoAZvrS84+knhGQO
 fkjjgh/dqzYONDMRW0ZKGjUQCQzlBA+XmzR6vO+BzGA0nw3VI0cV4S7dguU4aaR8Edx9c17eM
 O7mBOlGCe60+kp869GANLJGLANNUkdPoZeRy8KuK3cjcAuBZKse+A4Y5gvAOAVeVjiwj8a+dO
 1Bzw6k9ingE3qXa+xtGODOeLd1cVZ+ZW2U98rIS8Y5VFjZn9+U36GrQzIJQnCETVUsjY2FVOm
 0S/gVmku3/YgCkr8kqJCsthMQfNmplYVDlucnX2y933T4+tKUG6aEiO+UaheVNcMMn76NUgOU
 RB+ygm9MrCQu03y4uw5egqaTM/1koHC//2xNQ+sHpVYmJgOaUbL4eJF/wQDngYf+4QIk+L7Tk
 9NvKeayj6Cc5vo6zm2LwKiCsNNhQrFwE6LQHnY8uKRcsA6h1F26Z2NhPLq/nRErkEOHm247JJ
 7UTUWzzLEd1xdxRS7ljJctMThW9Of0haT2oxYQYraIljKered9Pcav4f3Do1V8V0jyR+3iemZ
 igoSngw3GKNynBW2Ji+w6R/vqTiSSdvHHLPhEUsunvW54hyEf4m4dqYaTTkQBB5x6AYjiocYn
 GCOupKGzDCgaZmNZ+VYF4kAmeEW57OurPAkcawWspJufuE6fENdn0bLf17wNg/0upba9onmJ8
 z2WfDtQgfqETkLGGpxNVAvzF55dCFS6O09m8fDz1qGNpWWwYGQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[When I try to reply to rpjday@crashcourse.ca then my SMTP server
 says "Requested action not taken: mailbox unavailable
 invalid DNS MX or A/AAAA resource record.", so I'm replying only
 to the list.]

Am 02.10.2017 um 12:13 schrieb rpjday@crashcourse.ca:
> i'm sure i'm about to embarrass myself but, in "man git-config",
> OPTIONS, one reads:
> 
> --path
> 
> git-config will expand leading ~ to the value of $HOME, and ~user to
> the   home directory for the specified user. This option has no
> effect when setting the value (but you can use git config bla ~/ from
> the command line to let your shell do the expansion).
> 
> what's with that "git config bla ~/"? is this some config keyword or
> something?
"bla" represents any configuration option that you want to change.  It
is not literally a keyword recognized by git config.  You could replace
it with "foo", if that helps.

The comment in parentheses reminds readers that shells like bash do
tilde expansion for command line arguments.  Consider the following
command:

	$ git config format.outputDirectory ~/patches

Your shell rewrites "~/patches" to "/home/rpjday/patches" (or similar,
depending on your user name and home directory) before actually
executing git config. So even though git config doesn't expand ~ in
option values you'll still get a result like this afterwards:

	$ git config format.outputDirectory
	/home/rpjday/patches

René
