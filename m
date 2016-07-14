Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7377720196
	for <e@80x24.org>; Thu, 14 Jul 2016 13:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbcGNNqh (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 09:46:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:55055 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbcGNNqf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 09:46:35 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LsxuQ-1bGVwc1bQI-012Vni; Thu, 14 Jul 2016 15:46:28
 +0200
Date:	Thu, 14 Jul 2016 15:46:27 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2016, #05; Wed, 13)
In-Reply-To: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607141542250.6426@virtualbox>
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:S8ED03O4Cn9XmzBE6tUkkdBkAsCYxebpJjpEwXeA6TkkO709dHb
 VJPJh4y248qXBmf+H4i1dlztRrFU7m7RA2bmbDxyq8EnkSLu15Ubn4c4rTAS8BXZHU4Q4Cg
 xtF7PiEX0OteTPTqSF1bXsJD9FPzRbB50r7V9nccWq2Q1dwx3oaO3XOosOiItNA9G6pHm1i
 RlCeXXV5lvYvlBTwGJzuQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:wHZDlNIaFSw=:Hq0ci+of5XTEfbvCIm3FZh
 HkinMTlpcIk+bwG57LLc6BuJgJAGb7JbKi1S4mWVmwkQqZloQOnC2zQVjNAg0Xiaz+IjmQ+UT
 bohEe3+P5npJ+yPXahAciEN1Y2fwqB6hXigiT96fzsGRnuZVjTGyGW9BcV28+4PEryr9k3iUW
 7Lf5twLzD23CRx0fQ34gV1wGiAECE7tU6FYYgwI6WlefZpwhKAg96Ats648VgqwQbva9KVdm0
 IMX+dSxhzui9Xn1GZSEO3QwPFgB9tns8gMDdTxcv1xcS6J9X8c2oICe4sm8YHMjjHNZpQXoJX
 rYEAS/bQxguhhxKn4XdtZKxgRWe4VEUKz3hxXPieXroSnK/nR+C9QNqi8vNeEdI0mHFCgqZNy
 KOdP1OtZXosgcqzCpWR5EupBPpsDIbOXP452p/UKTN/zEgq46BJv74jpcdOmzTpPmwbdsGhuE
 6K8LXs8S8oAvBiWogCxOWls7IdhzXJY4meIn2Qv+GigBP/6kU9wrdLP7TMWKkx1oxhrb1d2pO
 UiBPHcexCXgs59yPN5wo4SEZ3F8CYFRAlI4X6jqCooFG2QRgvCeDQEmco5kKie6SrE9aQJzVz
 DD6rxHaMXaBSgBNwlgUDVydZ8LLjQDGo1g6L7G8rV5TL/njKMBsI2YmY9uZn9DrHvezjGSSKt
 8rh+StAv06Ld2RtsguWCqfXPMZnM7VGDZ+SAeRaFNpsRGAg8xgt+fiCgxd4Y12VCaG31ELgNM
 jQ2zImzsDB/9L8D8eYo8f8ms9uWcyPDvNxhSRav3SLe2kc82rrg/ljYf9pK7yAm1GJHkiww1X
 jYjaKUV
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 13 Jul 2016, Junio C Hamano wrote:

> * dt/index-helper (2016-07-06) 21 commits
>  - index-helper: indexhelper.exitAfter config
>  - trace: measure where the time is spent in the index-heavy operations
>  - index-helper: optionally automatically run
>  - index-helper: autorun mode
>  - index-helper: don't run if already running
>  - index-helper: kill mode
>  - watchman: add a config option to enable the extension
>  - unpack-trees: preserve index extensions
>  - update-index: enable/disable watchman support
>  - index-helper: use watchman to avoid refreshing index with lstat()
>  - watchman: support watchman to reduce index refresh cost
>  - read-cache: add watchman 'WAMA' extension
>  - index-helper: log warnings
>  - index-helper: add --detach
>  - daemonize(): set a flag before exiting the main process
>  - index-helper: add --strict
>  - index-helper: new daemon for caching index and related stuff
>  - unix-socket.c: add stub implementation when unix sockets are not supported
>  - pkt-line: add gentle version of packet_write
>  - read-cache: allow to keep mmap'd memory after reading
>  - read-cache.c: fix constness of verify_hdr()
> 
>  A new "index-helper" daemon has been introduced to give newly
>  spawned Git process a quicker access to the data in the index, and
>  optionally interface with the watchman daemon to further reduce the
>  refresh cost.
> 
>  Will merge to 'next'.
> 
>  Is everybody happy with this version?
>  At v14.

I am trying to get back to working on the Windows support for this. I had
something that compiled but did not quite manage to do the IPC on Monday
evening, and have been scrambling with too much other stuff preventing me
from getting back to that.

The reason I mention this is: I wanted to get it working first just to be
able to determine whether there are possible improvements to the design
that would make things much easier to port to non-Unix-sockets-capable
systems.

Oh, and v14 has a bug that I reported already:
http://article.gmane.org/gmane.comp.version-control.git/298949

Ciao,
Dscho
