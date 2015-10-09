From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Reinstate the helpful message when `git pull
 --rebase` fails
Date: Fri, 09 Oct 2015 12:11:47 +0200
Organization: gmx
Message-ID: <d89d595a223508896db9303c901e7c30@dscho.org>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
 <xmqq612grhg7.fsf@gitster.mtv.corp.google.com>
 <CACRoPnSPVMt+FtK6bwfa7Z3jBheTEkBnhU+B7qL8JrAsSmAmkQ@mail.gmail.com>
 <4a99ca8724b3604cbbec48d559e134fd@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Brendan Forster <shiftkey@github.com>,
	Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 12:11:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkUeb-0002qI-6Z
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 12:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757368AbbJIKLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2015 06:11:53 -0400
Received: from mout.gmx.net ([212.227.15.19]:53348 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755832AbbJIKLw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2015 06:11:52 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MPDeK-1Zg4o8394C-004PQg; Fri, 09 Oct 2015 12:11:48
 +0200
In-Reply-To: <4a99ca8724b3604cbbec48d559e134fd@dscho.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:l2LZltl7wS1qWP/Nm7VfXNTLDd71H8kn6LjNssqBKmBLC6ynmsP
 4+ubSye0VyQOZHGOyIFX/g9LRnJGY35ejYt5dr+mkfWBZl+luWG0SjQI3ydw4EkeYhToFsi
 NHOXPEGsJq7SrJOcpggWosL1QAieiV2k55wsTmRg2CkuHMKlxI4iCUhq6OAQQ5CMIVm9byP
 uqD7E3Nj2XOFJO8cD29lg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZQTpX9gUj9g=:+VvxFxX9nMoettN341ckQo
 XRepVtATBENpiHIU+0u+9nu+wBn1oXzrwFeS5hU6COVNFye4AILnSqSLrpXJGhI8MjyvOmtwM
 1cewmpEfs+YAnxpX3yWJ3l1RNivCBC9z5b3/2rGf2H54gPtN3SF01U6FX0DSwi6oI4BmXBxsx
 AT6L+lsk4T/lWpELBGk/r+yvAQ9TdnbwTJ/WSRMgMyy/A3kbCha0hEZOZazC4OriKYu34pYaG
 hlL/crAmXQJT4nFN1Z+nN0UgiPulsUKt/2yn673S9sW1d7dJNdTxESxZQ9qvFC1whc+vFGXN+
 DBMCHDK880oJhgBuosoHk6oV+Pn1aJGnKwvH5BTqdD5VzR1cDwUE3itWiYtId+6llWgFs0j2N
 DSXEBKCJ4S1Cyd1VPUO99mKFBnzgGonbaXzjEra6ecRzzDXFGOdteDPUjMID3o4fCBkpXFTzL
 Zh+RlwaCL5kSQd7KI6d3oMpBFZ1bEDqPJkPpmf8C5KUqffOD3wAB9FAojrl+KmZv5KvR4+fIJ
 +yYMRUJ2sbxsHXXW3HsVbumcjSYGK3yU5h8192T6oZvHERmd+mb/KjT26piBn3IR4v2Ok1Kmz
 WDU9QQOo8zM9TvMW17glikRkQ+m6jfSvj4rJwqYRsuoQyeHF6A768TpG4n+oXisHaHvxVO+5W
 zClQG8sp5MxTO1/WSds+mT/RoGcW9nWAP9Q4IVwHF9DI4W11sZRWwPq1za3wpZKO/OKtysH59
 urcHMADqjtvXatvGA+KZup98IhrBOylYbz9y0eCf7KcPud7uWL9IelVOOFzxwbZeW165dzcS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279305>

Me again,

On 2015-10-09 11:50, Johannes Schindelin wrote:
> 
> On 2015-10-09 03:40, Paul Tan wrote:
>> On Fri, Oct 9, 2015 at 8:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>>
>>>> Brendan Forster noticed that we no longer see the helpful message after
>>>> a failed `git pull --rebase`. It turns out that the builtin `am` calls
>>>> the recursive merge function directly, not via a separate process.
>>>>
>>>> But that function was not really safe to be called that way, as it
>>>> die()s pretty liberally.
>>
>> I'm not too familiar with the merge-recursive.c code, but I was under
>> the impression that it only called die() under fatal conditions. In
>> common use cases, such as merge conflicts, it just errors out and the
>> helpful error message does get printed. Is there a reproduction recipe
>> for this?
> 
> Yes. Sorry, I should have added that as part of the patch series.
> Actually, I should have written it *before* making those patches.
> Because it revealed that the underlying problem is completely
> different: *Normally* you are correct, if `pull --rebase` fails with a
> merge conflict, the advice is shown.
> 
> The problem occurs with CR/LF.

I finally have that test case working, took way longer than I wanted to:

-- snip --
Subject: [PATCH 3/2] Verify that `git pull --rebase` shows the helpful advice when failing
Author: Johannes Schindelin <johannes.schindelin@gmx.de>
Date:   Fri Oct 9 11:15:30 2015 +0200
    
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index a0013ee..bce332f 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -237,6 +237,18 @@ test_expect_success '--rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
+test_expect_success 'failed --rebase shows advice' '
+	git checkout -b diverging &&
+	test_commit attributes .gitattributes "* text=auto" attrs &&
+	sha1="$(printf "1\\r\\n" | git hash-object -w --stdin)" &&
+	git update-index --cacheinfo 0644 $sha1 file &&
+	git commit -m v1-with-cr &&
+	git checkout -f -b fails-to-rebase HEAD^ &&
+	test_commit v2-without-cr file "2" file2-lf &&
+	test_must_fail git pull --rebase . diverging 2>err >out &&
+	grep "When you have resolved this problem" out
+'
+
 test_expect_success '--rebase fails with multiple branches' '
 	git reset --hard before-rebase &&
 	test_must_fail git pull --rebase . copy master 2>err &&
--

So the reason is that `unpack_trees()` fails with

    error: Your local changes to the following files would be overwritten by merge:
	file
    Please, commit your changes or stash them before you can merge.

then returns -1 to its caller, `git_merge_trees()`, which still returns -1 in turn to *its* caller, `merge_trees()`, which then gives up by die()ing:

    Aborting

I think there is more than one fix necessary to truly address the issue: the underlying problem is that Git handles *committed* CR/LF really badly when the corresponding `.gitattributes` label the file as `text=auto`. In fact, those files are labeled as modified in `git status`. If you change the line endings of them, they are labeled as modified in `git status`. And after a `git reset --hard`, they are *still* labeled as modified in `git status`.

I will try to make some time to continue to work on this later today, but in the meantime I would be relatively happy if we could introduce that gentle flag. It is really a very gentle patch, after all, much gentler than reverting to the heavy-handed spawning of `merge-recursive`.

Ciao,
Dscho
