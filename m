Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C5BD1F403
	for <e@80x24.org>; Sun, 17 Jun 2018 19:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933133AbeFQT2Z (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 15:28:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:33897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932886AbeFQT2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 15:28:24 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lx8OH-1gJOYo3blR-016fp8; Sun, 17
 Jun 2018 21:28:16 +0200
Date:   Sun, 17 Jun 2018 21:28:22 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, ch <cr@onlinehome.de>,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] sequencer: do not squash 'reword' commits when we
 hit conflicts
In-Reply-To: <d62d834a-58dd-590a-cf71-028220323bf9@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1806172048270.77@tvgsbejvaqbjf.bet>
References: <CAPig+cRKxpNrTNSEgB66LBxcJk1b24ViR=T-fkqo07wxMFywpQ@mail.gmail.com> <20180617053703.19856-1-newren@gmail.com> <d62d834a-58dd-590a-cf71-028220323bf9@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5erwFB4nghdHQFymW+VCNZ4kxnbIYhsTcH4BbNvGetV4jC5yIYD
 cudZ1SXWjgYt/x+21DOF6eqgTX6rFABEa4MMmgiUsT0zlUkW5cMwW3ur28tgakGKEkJO64K
 3QOYv5gqMtU7i98KofVdUOTNBJSawKOAaBLxki0kQh8h7osM+I3us1v40WFXjU888LqCi00
 Q1K9ECqsv36ixzkElFrNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1JNNjuriGeU=:A82Coa8luh5L8dQa8o0Ldw
 Lc5ePcUmljYojfViPrWNwky99+sLlQUPb6KSuuRPhkRrBgoG9grjKL9L9vndCqYkPqtV3Qz6k
 AHTAlZ4JlvMMwn9/duV802oViIVRS5woHumMVfx2b6H9V7BPYrKTnVCnJH3QfAvsVKofsGPf7
 7iBHsVtCLMZ8MX5gv4hbGP49IDSvd0/yMMmFAYo+x3AukieY0WSrsDX5Xsf+4wJ7iNKcemlzv
 KV4gADRX3rqKVwzkgX5Td+OK3BHdVI3stbhLlolm7/vhe5uvOQzn9/w1tBUYfFo4iijYFhRLT
 DCvCd9SR/EdMH9x2USKZeiPIbKaPvX6MqT1ekSQ8BWagB0lAO33YLF429ki3tQWtcYcy42n4m
 LNUep/xYfgbBtxfspVIjnPRv8Dv3QpY2+z/bk0mSwbayLtNK/MkkeuPoi9p5puw09kzqAwanq
 5WK0vRQxQymn0QhXyeoAMSzrTYBOijOaaPPoW61pKyN219dWVtHrVqsQsG0olwW/nrtfnlu1S
 FMuV+MO5tofpoQlmwDICF8wofovRaNY2triH5/qRrB30iGAHdI18990x3Y7A6G73r4rg/rAXD
 utTkXr0ha/+ybofbIriBluWhl7vGU5gw5qm8M0FEeBrs8Eii5gf4YSyU41x66910zhg9pvXEo
 wwAGIfLANM0r20jcRlGwiArDUZB+dVB1zEADpm8BAexmmJDZ0HWr1H/X4nNX9z4uS4o0jsSCL
 APUmzS0HseoxtGijwpG6IeOTUjCxhSPFm+qmG22GesxVejnfwG7+0d2ZRL9k2tkubdTyjhmqP
 5MMDqma
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Sun, 17 Jun 2018, Phillip Wood wrote:

> On 17/06/18 06:37, Elijah Newren wrote:
> > Ever since commit 18633e1a22 ("rebase -i: use the rebase--helper builtin",
> > 2017-02-09), when a commit marked as 'reword' in an interactive rebase
> > has conflicts and fails to apply, when the rebase is resumed that commit
> > will be squashed into its parent with its commit message taken.
> > 
> > The issue can be understood better by looking at commit 56dc3ab04b
> > ("sequencer (rebase -i): implement the 'edit' command", 2017-01-02), which
> > introduced error_with_patch() for the edit command.  For the edit command,
> > it needs to stop the rebase whether or not the patch applies cleanly.  If
> > the patch does apply cleanly, then when it resumes it knows it needs to
> > amend all changes into the previous commit.  If it does not apply cleanly,
> > then the changes should not be amended.  Thus, it passes !res (success of
> > applying the 'edit' commit) to error_with_patch() for the to_amend flag.
> > 
> > The problematic line of code actually came from commit 04efc8b57c
> > ("sequencer (rebase -i): implement the 'reword' command", 2017-01-02).
> > Note that to get to this point in the code:
> >    * !!res (i.e. patch application failed)
> >    * item->command < TODO_SQUASH
> >    * item->command != TODO_EDIT
> >    * !is_fixup(item->command) [i.e. not squash or fixup]
> > So that means this can only be a failed patch application that is either a
> > pick, revert, or reword.  For any of those cases we want a new commit, so
> > we should not set the to_amend flag.
> 
> Unfortunately I'm not sure it's that simple. Looking and do_pick() sometimes
> reword amends HEAD and sometimes it does not. In the "normal" case then the
> commit is picked and committed with '--edit'. However when fast-forwarding the
> code fast forwards to the commit to be reworded and then amends it. If the
> root commit is being reworded it takes the same code path. While these cases
> cannot fail with conflicts, it is possible for the user to cancel the commit
> or for them to fail due to collisions with untracked files.
> 
> If I remember correctly the shell version always picks the commit and then
> calls 'git commit --amend' afterwards which is less efficient but consistent.
> 
> I'm afraid I don't have a simple solution for fixing this, as currently
> pick_commits() does not know if the commit was called with AMEND_MSG, I guess
> that means adding some kind of flag for do_pick() to set.

Oh, you're right, the fast-forwarding path would pose a problem. I think
there is an easy way to resolve this, though: in the case that we do want
to amend the to-be-reworded commit, we simply have to see whether HEAD
points to the very same commit mentioned in the `reword` command:

-- snip --
diff --git a/sequencer.c b/sequencer.c
index 2dad7041960..99d33d4e063 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3691,10 +3691,22 @@ static int pick_commits(struct todo_list
*todo_list, struct replay_opts *opts)
                                        intend_to_amend();
                                return error_failed_squash(item->commit, opts,
                                        item->arg_len, item->arg);
-                       } else if (res && is_rebase_i(opts) && item->commit)
+                       } else if (res && is_rebase_i(opts) && item->commit) {
+                               int to_amend = 0;
+
+                               if (item->command == TODO_REWORD) {
+                                       struct object_id head;
+
+                                       if (!get_oid("HEAD", &head) &&
+					    !oidcmp(&item->commit->object.oid,
+                                                   &head))
+                                               to_amend = 1;
+                               }
+
                                return res | error_with_patch(item->commit,
                                        item->arg, item->arg_len, opts, res,
-                                       item->command == TODO_REWORD);
+                                       to_amend);
+                       }
                } else if (item->command == TODO_EXEC) {
                        char *end_of_arg = (char *)(item->arg + item->arg_len);
                        int saved = *end_of_arg;
-- snap --

Note that

- this patch is only compile-tested, and

- it is on top of my sequencer-shears branch thicket, so it might not
  apply cleanly to master, and

- it could probably use a comment what we are doing here (see whether we
  wanted to amend a fast-forwarded commit).

What do you think about this approach?
Dscho
