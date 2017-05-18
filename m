Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01354201CF
	for <e@80x24.org>; Thu, 18 May 2017 21:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756042AbdERVTh (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 17:19:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:49719 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755203AbdERVTf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 17:19:35 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9b4B-1dGhsz2rh1-00CwPn; Thu, 18
 May 2017 23:19:30 +0200
Date:   Thu, 18 May 2017 23:19:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     phillip.wood@dunelm.org.uk
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] rebase -i: silence stash apply
In-Reply-To: <decdfff1-dd21-4e10-44d5-9dbee38ba05f@talktalk.net>
Message-ID: <alpine.DEB.2.21.1.1705182318170.3610@virtualbox>
References: <20170518100233.30559-1-phillip.wood@talktalk.net> <20170518100233.30559-3-phillip.wood@talktalk.net> <alpine.DEB.2.21.1.1705181246430.3610@virtualbox> <decdfff1-dd21-4e10-44d5-9dbee38ba05f@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XVA8R4G35AeQnzDvxetcr6G8bZoTmInGAVTb0LOpQ4fVLQGnxPI
 7Mb/GajmFmmRyg9tE11dZFAfLxPhLrYy8lHDh4chYvWJP+BpEb2VVcGbfLt6ZZoB2kHL/8x
 JO8VlXuzrfFUGl8uF++Gt8gDWJ15J7WKkK8U1APF2RMuXI4Jk2ifOJxDtQXUu8t7wiVBs8w
 erpTp7xs0LXnNTbc9tmCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZaF7xix9iek=:nwhpTWv55ff/XUnMx44dsU
 v2tDWYqHLvq+SYIygyEwv539ksxZ8tCG0TXjrr36dbubiGHHuQpc98Zkb63oe/nKh2zg+ZXY5
 4to3SooJqWXqDtX3VLk8W2O3JP5YvxuZMoRcXrzkUeFgtG1RPWPbuucsymF//nVMafioS+52I
 LFPuwtiHlk3ztwLOPoQHPlECzahBN/F06wvBsGvWA1ZfqnvxkIosmlpIr78LmoI1m1lF8W5dV
 nDhBdDRQwwTGYQyEVXveXabzQPJLBQaIbTCavzEDchtR5dAS0CwC2Tfnym2hKPdwDfzPSHWtb
 pSjeKxnUuMIHunRscR5yxMA78O5UxerYAyy/eBGe0Lt69DLvWkCh/WbQQHoyx+/XNPlfnxHPf
 KjUjGbMLp9OR47U5EvAQ2tkAzkJ/1iA5dA24+1gbOBPl39MzxD7DbNWLemB/LOqi8NXW0X5nB
 9nFK7ISERNlzIKfzEra6WyT45pVesXKGc7pJ2jY9rwH3Vtf7Vnm4CjKkEPKWMORDhIa/qEm+m
 iweomgo7EjEzVed5KbwH2q3VxTRE4FjGYFQaF3KUPT/rUb6TZh90Aim60zcQRBQTrSZTaUD5d
 4jzMaRlVSsQKDeZkae+w51qtru9Jf0oKyErs0YYNMM1Ev/I7PzGOlLhZck/oU1qJIg7T+WAoi
 +lSGQwUO9biQ1v/A6I8Z8HZfyOrvynWpOXDS0xEVBPMHcRNsfrgHJ0oEdq9KCcQQly9sRPh4z
 Q3qdkasYbluGmPjtU6DGjr3pinCBqSsbiOXLFENX7LxAE3zVRMmPlKJJOWmWaCwFvFhzM2QU+
 END9j+f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 18 May 2017, Phillip Wood wrote:

> The shell version prints it's own error message if there's an error, the
> C version does this as well
> 
> Shell version:
> apply_autostash () {
> 	if test -f "$state_dir/autostash"
> 	then
> 		stash_sha1=$(cat "$state_dir/autostash")
> 		if git stash apply $stash_sha1 2>&1 >/dev/null
> 		then
> 			echo "$(gettext 'Applied autostash.')"
> 		else
> 			git stash store -m "autostash" -q $stash_sha1 ||
> 			die "$(eval_gettext "Cannot store \$stash_sha1")"
> 			gettext 'Applying autostash resulted in conflicts.
> Your changes are safe in the stash.
> You can run "git stash pop" or "git stash drop" at any time.
> '
> 		fi
> 	fi
> }
> 
> C version:
> static int apply_autostash(struct replay_opts *opts)
> {
> 	struct strbuf stash_sha1 = STRBUF_INIT;
> 	struct child_process child = CHILD_PROCESS_INIT;
> 	int ret = 0;
> 
> 	if (!read_oneliner(&stash_sha1, rebase_path_autostash(), 1)) {
> 		strbuf_release(&stash_sha1);
> 		return 0;
> 	}
> 	strbuf_trim(&stash_sha1);
> 
> 	child.git_cmd = 1;
> 	child.no_stdout = 1;
> 	child.no_stderr = 1;
> 	argv_array_push(&child.args, "stash");
> 	argv_array_push(&child.args, "apply");
> 	argv_array_push(&child.args, stash_sha1.buf);
> 	if (!run_command(&child))
> 		printf(_("Applied autostash.\n"));
> 	else {
> 		struct child_process store = CHILD_PROCESS_INIT;
> 
> 		store.git_cmd = 1;
> 		argv_array_push(&store.args, "stash");
> 		argv_array_push(&store.args, "store");
> 		argv_array_push(&store.args, "-m");
> 		argv_array_push(&store.args, "autostash");
> 		argv_array_push(&store.args, "-q");
> 		argv_array_push(&store.args, stash_sha1.buf);
> 		if (run_command(&store))
> 			ret = error(_("cannot store %s"), stash_sha1.buf);
> 		else
> 			printf(_("Applying autostash resulted in conflicts.\n"
> 				"Your changes are safe in the stash.\n"
> 				"You can run \"git stash pop\" or"
> 				" \"git stash drop\" at any time.\n"));
> 	}
> 
> 	strbuf_release(&stash_sha1);
> 	return ret;
> }

Oh, you're right, I misremembered.

Thank you for being so thorough. This patch is Acked-by: me, then.

Thanks,
Johannes
