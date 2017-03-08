Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ACA1202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 15:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbdCHPej (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 10:34:39 -0500
Received: from mout.gmx.net ([212.227.17.22]:52539 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751691AbdCHPee (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 10:34:34 -0500
Received: from virtualbox ([37.201.192.247]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mb31L-1cX8zL1sIV-00KeW6; Wed, 08
 Mar 2017 16:34:16 +0100
Date:   Wed, 8 Mar 2017 16:34:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: Crash on MSYS2 with GIT_WORK_TREE
In-Reply-To: <xmqqa88w4bbp.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703081304130.3767@virtualbox>
References: <CAFKRc7y_kpCGNORENUZ2qw_4qBwjjyaaDFxAEQa52fTryj+w7A@mail.gmail.com> <alpine.DEB.2.20.1703072345530.3767@virtualbox> <alpine.DEB.2.20.1703080104580.3767@virtualbox> <xmqqh9344hq6.fsf@gitster.mtv.corp.google.com>
 <xmqqa88w4bbp.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:03tcQNSqR4RiBv+qmEzV76jPumAB5h3vEAwEdIIfVfcDWO+zSVI
 NEM36ih6cauap0zprk/XLUcjLnJAFHj7BsykGwFhkPZOixBSCSHhrip7LT6ViJUINVojxbh
 ApQ/1SIyhlCtFe5h2wyjc5ge7EqDgYZat9XC0HZHSoL22RNuZKN6uAtslArOGZHNlIFOBpu
 p4VF3V6vN8Mhn1n/HJ8lA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2FPPfZxX6R4=:G0YYKGXA9nsHZLg19jDhdQ
 BJUo37XHOpAzMIuUFPzsoI9TEnVcHPCgPCr7jd3jniQN9RtyXdQcQlTBSy4vYQpRSTkUeSqwd
 t2wzt0uhq3cvjIqgF4JAIP3EvRzyR4tmg2Pq3mQiJtMRxt5wxE1RQfemoBQwuBURWy2KM/xjc
 IcmcBqU5s5r0Fnlp/VkSV9ivhWQ/zf6pojMAz/Dot8/cDDjie3opMb4/lJ54dJa0y1wg5lnMn
 /N8z2xEQ6gX/rPhw8/W+Qk9L2FEnXKhWhsZYbHRd59eBpjJlf/jlPMiV1TONSp/QTCV4sW39V
 2qMGvTStLvZ0HjFFHf3h2oq0EnO7En/7T7g5KqG2ySQapRCsf342nBn8UVS4B7TeR1gDm5wpA
 fRqN/Jxp1Ak9jq7CNEXbvKUHw3MMrvFoQ2Yq+ptHjpWYww8Pp4VOqhrk0nUS8ESBfRRTB2n8C
 9U0/KsJkhMJD8bnj8RVv2vNTNBZOowKZD3TIY8ocSR7HyMzbZkrPxJVvU12DmLuxQsjlnDwQ3
 NPu1ffkkEnnMDPu+Idhq2AotvJrfLj9pOwAStxsexnBDGP12NhSHVGVzIT/pqVp25FBQpERv1
 X5nO0IWkRZ6cukRBQDzfKBi/sokfTieRGwYSRWl/0M8CwrE+3gnRUtwu2rFiAPzt0acieNc5M
 ruRpTxbAQmyOLZT8+8OaVRlTtt/6oRkmmuhQ+NJzf1958UGn5ra9S+/tTSk6UQct2Gvgfz5ag
 guNJylxgDlgmKz6CrHQTm8cLp69NhA04hIfMcp0k839u7pKVSEjUtJwY0DigQiCYxxKbS8DL3
 MNfvAg6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 7 Mar 2017, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > OK, so it appears that we'd better audit all the callsites of
> > real_pathdup() and see if anybody _assumes_ that the return values are
> > not NULL.  They all need fixing.

Indeed.

> I just looked at 4ac9006f ("real_path: have callers use real_pathdup and
> strbuf_realpath", 2016-12-12) and it seems all hunks that replaces
> xstrdup(real_path(...)) with real_pathdup(...) in the commit share the
> same issue.  

Right, I tried to convey that information in my email to which you
replied.

> The one in canonicalize_ceiling_entry() looks OK, though.

Yes, it immediately tests whether NULL was returned.

> ec9629b3 ("submodule absorbing: fix worktree/gitdir pointers
> recursively for non-moves", 2017-01-25) introduces a new use of
> real_pathdup() and the result is immediately used to call
> connect_work_tree_and_git_dir() without checking its NULL-ness, but
> the argument to new_git_dir is something that came from git_path()
> that was successfully passed to safe_create_leading_directories(),
> so this one should be OK.
> 
> 1c16df23 ("Merge branch 'bw/realpath-wo-chdir'", 2017-01-18) turns a
> few xstrdup(real_path(...)) in dir.c without thinking.  I think that
> evil merge probably should be reverted.

Rather than a heavy-handed reversal, I would really prefer to perform a
diligent audit of all real_pathdup() callers and adjust them
appropriately.

Turns out that the canonicalize_ceiling_entry() caller is *the only one*
handling NULL correctly. All other callers need to be changed.

Will send something out in a moment.

Ciao,
Johannes
