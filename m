Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EA811F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 08:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeJLQIO (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 12:08:14 -0400
Received: from mout.gmx.net ([212.227.17.22]:43243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbeJLQIO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 12:08:14 -0400
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M93Jp-1gNHPO3sA1-00CO3v; Fri, 12
 Oct 2018 10:36:48 +0200
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M93Jp-1gNHPO3sA1-00CO3v; Fri, 12
 Oct 2018 10:36:48 +0200
Date:   Fri, 12 Oct 2018 10:36:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 1/2] rebase -i: clarify what happens on a failed
 `exec`
In-Reply-To: <xmqqva68gaqz.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810121036090.45@tvgsbejvaqbjf.bet>
References: <pull.43.git.gitgitgadget@gmail.com> <pull.43.v2.git.gitgitgadget@gmail.com> <2eefdb4874d36f14aac79b24c0f6216911f2143e.1539161632.git.gitgitgadget@gmail.com> <CAPig+cRMOOqGdiCqprUqiSXCa5SZDRy-kJSvdRmwY_uvynwoXQ@mail.gmail.com>
 <xmqqva68gaqz.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:f+ZnRAfUn2rs+BzVTFTYGrhne0HfnoySxz/UDBW6CoYhVe0amEK
 EMVGwFYb3OorRCnDVK+oKD5qlSOFXEiN/RBZ0pCITxRMcFdqwqByva8I3Imx/pK0RiXkePp
 MaBJvYlNkMcV0E2HQXmmozuAyTlC+SjdqUbm6zaWkcWOjvjeFnl6NOAzieDrYRbc0U4huh6
 Eb59mFJUNRfROaAAz2sZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7QoLz8POU9g=:3Q4aJQsFamvgjkohkIOe0x
 2/mojFNfhgu4swIkcVhMZSzhp4LabwyDBWHZ6W2Yp6WsjoWTPzXPQ1FxdNQZiSb80mTxPQBpd
 N8l4hTxOaP9fqCLjUb9r6kaRuUSvW2eg5OvW25L7BdV0WVD9t9aW/9aKnkmObfsXxomNJSoW6
 Urox6jFeZU9wWDQ9AoQvt51RhzSLA0Y1e5clDqvOkveVoRePrxzLlMe42/fbDeadOiB6NDfcG
 2aF4o4o2El6P2Gxa4xjR7M++DP+cvbeA9hmEun/276FqAkt2rHFrEWBOgYkU7g9RHJ9WCtYzr
 W0qANLjG0BNmMSwowliQNKNFUzIvQcaLEQln9r2KgS9LP5DwY0t+ecbq7pF+nEqzxCsC5/ZiM
 6ZgJSFjR6nyWEh0UiV/AlGHpFty2O94d6kAkO0PoLtc4LXULGs2m/KIj1s9NyrPaRuiidbaXe
 PpTd0iWkhE/az87exi+772WZ4QbI690MBRnG9RdM5TzoCxDDMlzwb0fRKyWjTGDqWFyMnkWjr
 14NJwC3f1XAOLBm/oHz+ModA51J9mu1OFoRoWjAth6OnFoSq0xhNqZoQbdza2sxh67ZBggbjS
 a9iJuATtPUAz4c/rOWphYW5ByFBct92NlhtkAoI8iFNlrMahmA0sljE39lEVIQFPEe5B6JVmB
 E0rE/ijthdNWZ4X9Y1iPhqsgiWQ2LAoMmtAVcVzs5Ne2NxSOFmjID8a92jfKTdtdrEvaRs0tx
 qStH+jwUbF2BMyrv3IF2IXPi313wwl5nWX3zf7kYVeYoEXsc5OLgo+aqhg5t50AkvXNMMroRK
 p9OV5cODoO4O0YKuMO9Waz+6+Jqq49rJvOQ3GgXlDyu8JUz9q8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Eric,

On Thu, 11 Oct 2018, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Wed, Oct 10, 2018 at 4:54 AM Johannes Schindelin via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> We had not documented previously what happens when an `exec` command in
> >> an interactive rebase fails. Now we do.
> >>
> >> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >> ---
> >> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> >> @@ -420,7 +420,8 @@ idea unless you know what you are doing (see BUGS below).
> >>  --exec <cmd>::
> >>         Append "exec <cmd>" after each line creating a commit in the
> >>         final history. <cmd> will be interpreted as one or more shell
> >> -       commands.
> >> +       commands. Anz command that fails will interrupt the rebase,
> >> +       withe exit code 1.
> >
> > s/Anz/Any/
> > s/withe/with/

These tyopes will be fxied in the nxet itaretion.

Ciao,
Dhsco

> 
> Heh, I know I am not good at spelling, either, but hopefully I am a
> bit more careful than leaving as many typoes as I have added lines
> in my patch X-<.  After all, it's not a race to send in patches as
> quickly as possible.
> 
> Queued.  Thanks, both.
> 
