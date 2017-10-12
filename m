Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DF9D20372
	for <e@80x24.org>; Thu, 12 Oct 2017 19:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbdJLTNt (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 15:13:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:56307 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751205AbdJLTNs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 15:13:48 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M35iN-1d9vXu1LUt-00st9K; Thu, 12
 Oct 2017 21:13:41 +0200
Date:   Thu, 12 Oct 2017 21:13:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, J Wyman <jwyman@microsoft.com>
Subject: Re: [PATCH v2 2/3] for-each-ref: let upstream/push optionally remote
 ref name
In-Reply-To: <xmqqvajmmdii.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710122110170.40514@virtualbox>
References: <cover.1506952571.git.johannes.schindelin@gmx.de> <cover.1507205895.git.johannes.schindelin@gmx.de> <7da6c7e2563d14cb7cd7ff2637c79c51896a9788.1507205895.git.johannes.schindelin@gmx.de> <xmqqvajsx3o0.fsf@gitster.mtv.corp.google.com>
 <xmqqvajmmdii.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:m4Txmt3hvEVsNqHizYhvqnaits3eL524KwxMZI4ih4j2lYTlgfR
 DcTwfBOAtWzprCkug/p1PqaaRxUg0bDqPaEeh6emQTMriG20tlEYk96SIoNXglkGEOybfLu
 k6ZaW1PJE5+SzSllWUEsKlFrxAUPL+5gREfERkcPxBoJEnWiOJK6L1oiyOpPUuQvuLsUBLf
 WxJIC8Pz4RKKy2h/Vg+AQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:npOS4w2oi6M=:+nZYObQGz94kj/rhQxVrWJ
 PGugTRYOS0bjgK9uY5Y51o2i+k1lecd8P+s2VfufswKUIy/l77gE5IsLwyB0XpZ4/rtXpM0yq
 JjfJbszSETQmf7r+FRl/ecgixxnNQ1VTP/AlQ4Ka4L/DyZ1QqUz6l4Cs2omGxQ66OX3HYuOH6
 I3tABiqrCEJiDxguc2qvQ4mAUHVpCwLUKLwbLHPDk2bahNaVc5Ss5WTEOgZN0YibBi5mQng3U
 j+ziXMqghzHcpF8G/mLxTPdnBfa6tQ3R84UmrR23X5pfwAsltpUCNAhvUgivYViHqgKIeloSB
 jnqI9pcZSV/MsUbSyEPBEj3eVMSF9r9cXsj+3FIg/HbQK7F5K6XCIqu3SpkA96SBkxnJWzaeM
 vvHWbZmzeQnZ5NAIbgiIQR83LjNjEOvohuJEQ6xkTU7tCWM6YECCRH4550Ag45F9T9esBJQSm
 r2168wzdOg8yNYjPKoQy2g78tu5WyXsQjg01FzofbWmQO5ET4rp/AENGD6RgKZ6QDetYVG2+V
 dGV8GPG1Z45/gX+WXgCnvK1KLfu971TPpOK4tMQ7lgqXHqz1wd3eY5JVbnpHVDRJtMTdMVhC8
 Ff8Jyzeyu3vt2vCmBLFfIhi6dmbkpY4GJ5oiOAtTSjnDP7RboXxmJtO6pyD7naXgxgt/tfuDA
 h+T/hUc/jjwoqqVuQC5b4c8yNae7bN9L9x99LWz5p7JStcwPMi21TZmzEfxqwU6JG6iyeVeX/
 yJChdj+tMarlX3ShAvWqUp43tOeKvUwhRiOiLnF/PLqGm2JyORgtYTX82zHUm6AKkiuaB/eub
 R9Hkq6qdl/aHVy1y/N3NT/Y/Uvr+BPCrc7uo7Rzw1PNyQyp0TE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 11 Oct 2017, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >
> >> Subject: Re: [PATCH v2 2/3] for-each-ref: let upstream/push optionally remote ref name
> >
> > No verb?  s/optionally/report/ perhaps?
> 
> I just noticed that I didn't tweak the copy I have in my tree after
> sending this message, but now I did s/optionally/& report the/;

Yes, sorry for not reading this earlier, this is what I meant the commit
subject to say.

> I am still puzzled by the hunk below, though.
> 
> >> @@ -1262,6 +1265,14 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
> >>  			*s = xstrdup(remote);
> >>  		else
> >>  			*s = "";
> >> +	} else if (atom->u.remote_ref.option == RR_REMOTE_REF) {
> >> +		int explicit, for_push = starts_with(atom->name, "push");
> >
> > Hmph, the previous step got rid of starts_with() rather nicely by
> > introducing atom->u.remote_ref.push bit; can't we do the same in
> > this step?

Right, I forgot to edit this. FWIW I have this in my branch now:

-- snip --
[PATCH] squash! for-each-ref: let upstream/push optionally remote ref
 name

for-each-ref: let upstream/push optionally report the remote ref name

There are times when scripts want to know not only the name of the
push branch on the remote, but also the name of the branch as known
by the remote repository.

An example of this is when a tool wants to push to the very same branch
from which it would pull automatically, i.e. the `<remote>` and the `<to>`
in `git push <remote> <from>:<to>` would be provided by
`%(upstream:remotename)` and `%(upstream:remoteref)`, respectively.

This patch offers the new suffix :remoteref for the `upstream` and `push`
atoms, allowing to show exactly that. Example:

	$ cat .git/config
	...
	[remote "origin"]
		url = https://where.do.we.come/from
		fetch = refs/heads/*:refs/remote/origin/*
	[branch "master"]
		remote = origin
		merge = refs/heads/master
	[branch "develop/with/topics"]
		remote = origin
		merge = refs/heads/develop/with/topics
	...

	$ git for-each-ref \
		--format='%(push) %(push:remoteref)' \
		refs/heads
	refs/remotes/origin/master refs/heads/master
	refs/remotes/origin/develop/with/topics refs/heads/develop/with/topics

Signed-off-by: J Wyman <jwyman@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ref-filter.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 2556c7885de..6ab12658cb3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1268,9 +1268,11 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		else
 			*s = "";
 	} else if (atom->u.remote_ref.option == RR_REMOTE_REF) {
-		int explicit, for_push = starts_with(atom->name, "push");
-		const char *merge = remote_ref_for_branch(branch, for_push,
-							  &explicit);
+		int explicit;
+		const char *merge;
+
+		merge = remote_ref_for_branch(branch, atom->u.remote_ref.push,
+					      &explicit);
 		if (explicit)
 			*s = xstrdup(merge);
 		else
-- 
2.14.2.windows.2
-- snap --

(The funny "squash!" followed by a complete version of the rewritten
commit message is what I do until I -- or anybody else -- comes up with a
patch to implement support for "reword!".)

I'll let this simmer until next week and send out a new iteration of the
patch series then.

Thanks,
Dscho
