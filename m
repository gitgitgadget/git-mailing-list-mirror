Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8939203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 20:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753247AbcLLUb2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 15:31:28 -0500
Received: from mout.gmx.net ([212.227.15.18]:60307 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932221AbcLLUb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 15:31:26 -0500
Received: from [192.168.178.43] ([88.71.239.96]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2tXS-1cWhKA2m4U-00sfXi; Mon, 12
 Dec 2016 21:31:04 +0100
Subject: Re: git add -p with new file
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com>
 <20161209141129.r53b4rbtgd76fn2a@sigill.intra.peff.net>
 <alpine.DEB.2.11.1612091331170.13185@cherryberry.dsgml.com>
 <20161210085556.nwg3pbay367jqin5@sigill.intra.peff.net>
 <xmqq37hvphji.fsf@gitster.mtv.corp.google.com>
 <20161211130034.ygj5l2gbx33uknlk@sigill.intra.peff.net>
Cc:     Ariel <asgit@dsgml.com>, git@vger.kernel.org
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <dc698b79-6311-a2a3-c564-a43ef071e62b@gmx.net>
Date:   Mon, 12 Dec 2016 21:31:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <20161211130034.ygj5l2gbx33uknlk@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:/4elMPwefSFuerDpjreP79qOX5O94Gory44ATmrpY7r9q6kY3c9
 k8bMYaJqVSqqgC8Hxa3OlI9KJNOma6pTFY+PHT5C3dW9TSFoSD33XqlFE4s6EqlQByjIDyQ
 JLgYhaWajEpGypLWomTi/A03ZlHTu6viVOcOQ0puyPE8mHIZYD/TyQ9LGMxeXPH+6DMnl2H
 /lvj+s/kybH8S5gjHJvzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZcQjDjLlB6w=:/D6S3QabzVFfh1+cGPL/+q
 4rou27MHhMf4UycC8S6AomKnvK1MU0Xm/OXy+iiVMXBq4qmA8dHStFc9K2Y2s/UfucB7ZJp8V
 iuOp8oIFJlvBj/tHrI9APUJUyAIXK5RjbstrYlJf6l622XmPF9E7KFji5X5UdCeJ/9xglmKHU
 WeHQyWeFU9OhW2BGtsleJ6tHjaUi9y02ALNtYfHIzMEbxyfZ/jDCkKFmil3c0emObaVUXJ0hX
 ERqgfP92tEbC0vcNmIZFlLW1eiN5yXfMWREbksnnGRF0m+0zncR6Gt3zZkB7Qsc9Gs2QVHpwv
 hQaxRWxE+hTPSmpIYuddpzkaPHA9rzfmChSDkHnRC3M+pQ5AhfFtZHaYu3PG4nPHp1DTbnXV/
 FKkOxMZABmjLIdgF7f8vQPDoIVAMZsPpack00bIRExj9u0SdyKIGzflObTzNl73VLAPJOPL/6
 I6yyhS1MBt3nuMOgNgSdCqTKyMwlpFSJmWnRS5q9fDBTdLXEYaU89vOrry6tIp+k39I2+rr0L
 JV1BJQSLaHXKxpdVZW/7iPAt3p+usgRqC0aLE5LTXjv1cl7P45kFxUBiOCvRgaioK6jjoREBm
 1aoA8Sx/Sp7enFVzNUGqqqlG4TAtYpW8KbIrO+ccj8fQ4rDNKYkK4BUHy4LVbY/6LHDpsN8H6
 dMZ/ZuMYSOngJfsECjziOhv4TB63/2MD2yYD7GKTXElx3CVNlHf2TrcBye6ozk1kbwpqskv6L
 7RLEO0xb1O8/foX5hzZ9ScFePcVxgTJYS09ExUqQZUQPTfsxZaqUCcQq69dwuFmHBNOTd72FW
 7Wbf5PU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 12/11/2016 02:00 PM, Jeff King wrote:
> On Sat, Dec 10, 2016 at 02:04:33PM -0800, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>>> On Fri, Dec 09, 2016 at 01:43:24PM -0500, Ariel wrote:
>>> ...
>>>> But it doesn't have to be that way. You could make add -p identical to add
>>>> without options, except the -p prompts to review diffs first.
>>>
>>> The question is whether you would annoy people using "-p" if you started
>>> including untracked files by default. I agree because it's inherently an
>>> interactive process that we can be looser with backwards compatibility.
>>
>> It might be interactive, but it will be irritating that we suddenly
>> have to see hundreds of lines in an untracked file before we are
>> asked to say "no I do not want to add this file" and have to do so
>> for all the untracked files that happen to match the given pathspec.
>>
>> It might make it less irritating if one of the interactive choices
>> offered in the first prompt were N that tells the command: "No,
>> ignore all the untracked paths", though.  I dunno.
> 
> Yeah, I agree dumping the contents automatically is annoying. Ariel
> suggested asking twice about each path, which sounds clunky to me. I'd
> probably give a simple question, with an option to dump the contents.
> Like:
> 
>   $ echo foo >untracked
>   $ git add -p
>   New file: untracked
>   Stage this file [y,n,v,q,a,d,/,e,?]? v     <-- user types 'v' for "view"

I am also a "git add -p"-only user (except for new files and merges).
However, I usually keep a lot of untracked files in my repositories.
Files that I do not (git)ignore because I want to see them when I type
"git status".

Hence, the imagination only that "git add -p" starts to ask me for each
untracked file feels like a lot of annoying "n" presses. I could imagine
that it is okay-ish when it asks about the untracked files *after* all
tracked paths have been processed (I guess this has been proposed
before), so that I can safely quit.

I am also not really sure what problem this feature is trying to solve.
If the "problem"(?) is that it should act more like "git add" instead of
"git add -u", for whatever reason, this may be fine (but the
configuration option is a must-have then).

For me, I often had the problem that I simply forgot to add new
files...¹ Still I doubt that one would benefit from such a feature
because either:

- you do not have many untracked files (unlike me). You will see the
untracked file (that should be tracked) in the "git status" output when
you edit the commit message², then you abort-add-commit or
commit-add-amend and everything is fine.

Or:

- you have a lot of untracked files (like me). You won't see the
untracked file (that should be tracked) in the "git status" output (you
ignore it because the list is so long) and you won't see it in the "git
add -p" run because you quit before seeing that file.

So I have mixed feelings...

> I'd also probably add interactive.showUntracked to make the whole thing
> optional (but I think it would be OK to default it to on).
Hm, "interactive.showUntracked" is a confusing name because "git add -i"
(interactive) already handles untracked files.

Best
  Stephan

¹ I do not have that problem any more because I got used to add new
files right after saving, in a very early state, and then I simply use
"git add -p"...

² Unless you use git commit -m ... But using "git commit -m" without
"git status" before is user-issue anyway.

