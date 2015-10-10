From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 0/2] Reinstate the helpful message when `git pull
 --rebase` fails
Date: Sat, 10 Oct 2015 06:58:04 +0200
Message-ID: <56189ADC.9040207@web.de>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
 <xmqq612grhg7.fsf@gitster.mtv.corp.google.com>
 <CACRoPnSPVMt+FtK6bwfa7Z3jBheTEkBnhU+B7qL8JrAsSmAmkQ@mail.gmail.com>
 <4a99ca8724b3604cbbec48d559e134fd@dscho.org>
 <d89d595a223508896db9303c901e7c30@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Brendan Forster <shiftkey@github.com>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 06:58:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkmEb-0002ab-Jb
	for gcvg-git-2@plane.gmane.org; Sat, 10 Oct 2015 06:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbbJJE6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2015 00:58:13 -0400
Received: from mout.web.de ([212.227.17.12]:63435 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbbJJE6M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2015 00:58:12 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LxOHm-1aeGCS1hxC-016yCu; Sat, 10 Oct 2015 06:58:06
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <d89d595a223508896db9303c901e7c30@dscho.org>
X-Provags-ID: V03:K0:3ewOJTJt4g1/G+zdSAsfq15d5ZNgevnR9gBvDWcvpaSe+F96BxX
 9XFZSy6/Z+VjG0BDndiuT812womGrCHXAXGTrnxDiYsiuDegD4TKPUmuPRd2gVaLueaoiRl
 NGSWGyL/lLGeoapXcKl/K2p8zU0fsXXeoWqvQAt8TRltTwPwIiqs71acK3KpH/N7UC2mYoM
 RF6gbbg6mA8bCiLQdTpGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oGdLBmCmdlA=:COYQj6hOzbHf9hrrLUG8N2
 jpRklJZ01/2uZ9/PKF2/aWwq4WFPKimOWrFafoZ55LmKeSCCRghwu2/O0TBq51sNyQhezbv07
 E8ua28hPkUl941OOSz0YPc6PGun4LcoODo7PH7iHPzZymYCoWvWs9/LDL0Pc1LYVLJWVjdNjh
 ZNUmFIN0p3zUqEe1RQyVIhBPefwCaItmfMzSBwtE0op69s8560TX+o1HTb+jEGJLnLTgCtpj/
 WVjPYMOvYQx8Ew/tM6nB4rhQFupkDlZsm9tju9HrMUX4dYBzBTW9L18vxnHkTis4Bkesk7yx7
 NrioWcryYZZCszXbjQYLQ+RO7W2n2d9rKywGuuxmsLjxgnt2ejW2sD0iPaQGqA8SqvI0s2VTQ
 BvRJkkpbi01sdx+bDCc/sScT2sXLbiWHyhlLqRklnohAv3piXdSav+tXQadOtrvkdBN6Uj07D
 c0fI3dGgToX0yh+v63OzGa4JUOkgrazLR+UakaUs3yFizEIqyay+ZYqUtCA8YZMM1Z2gdO/qK
 0cnsxFIcHipC4mp1g8MzKuKR0NQLkolXlAnSMvf1kbK/MjSeNV0yd1hwxFpySXfv2TA2XiXly
 zw4LEjH79tiLc/8m44c2csD72zRy60w39i0bzXXXQkym+i5QGG+4RYKLgyUpkGmGzEG5XSaXB
 lyRq+/4QkPdeAv3GcEXI5g19d9PVkqD1P+s5AqP9m4PoH3WfKpufRhUz4zTjXpNcjIuTOhgGD
 3yDqdYLFUBm3EwmDwGNJZXtpt+L7UjRY2qzpJ/z9IxJLIRhDIHjF5oba43EQOaFBhdTf7bkR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279322>

On 2015-10-09 12.11, Johannes Schindelin wrote:
> Me again,
> 
> On 2015-10-09 11:50, Johannes Schindelin wrote:
>>
>> On 2015-10-09 03:40, Paul Tan wrote:
>>> On Fri, Oct 9, 2015 at 8:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>>>
>>>>> Brendan Forster noticed that we no longer see the helpful message after
>>>>> a failed `git pull --rebase`. It turns out that the builtin `am` calls
>>>>> the recursive merge function directly, not via a separate process.
>>>>>
>>>>> But that function was not really safe to be called that way, as it
>>>>> die()s pretty liberally.
>>>
>>> I'm not too familiar with the merge-recursive.c code, but I was under
>>> the impression that it only called die() under fatal conditions. In
>>> common use cases, such as merge conflicts, it just errors out and the
>>> helpful error message does get printed. Is there a reproduction recipe
>>> for this?
>>
>> Yes. Sorry, I should have added that as part of the patch series.
>> Actually, I should have written it *before* making those patches.
>> Because it revealed that the underlying problem is completely
>> different: *Normally* you are correct, if `pull --rebase` fails with a
>> merge conflict, the advice is shown.
>>
>> The problem occurs with CR/LF.
> 
> I finally have that test case working, took way longer than I wanted to:
> 
> -- snip --
> Subject: [PATCH 3/2] Verify that `git pull --rebase` shows the helpful advice when failing
> Author: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date:   Fri Oct 9 11:15:30 2015 +0200
>     
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index a0013ee..bce332f 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -237,6 +237,18 @@ test_expect_success '--rebase' '
>  	test new = "$(git show HEAD:file2)"
>  '
>  
> +test_expect_success 'failed --rebase shows advice' '
> +	git checkout -b diverging &&
> +	test_commit attributes .gitattributes "* text=auto" attrs &&
> +	sha1="$(printf "1\\r\\n" | git hash-object -w --stdin)" &&
> +	git update-index --cacheinfo 0644 $sha1 file &&
> +	git commit -m v1-with-cr &&
> +	git checkout -f -b fails-to-rebase HEAD^ &&
> +	test_commit v2-without-cr file "2" file2-lf &&
> +	test_must_fail git pull --rebase . diverging 2>err >out &&
> +	grep "When you have resolved this problem" out
> +'
> +
>  test_expect_success '--rebase fails with multiple branches' '
>  	git reset --hard before-rebase &&
>  	test_must_fail git pull --rebase . copy master 2>err &&
> --
> 
> So the reason is that `unpack_trees()` fails with
> 
>     error: Your local changes to the following files would be overwritten by merge:
> 	file
>     Please, commit your changes or stash them before you can merge.
> 
> then returns -1 to its caller, `git_merge_trees()`, which still returns -1 in turn to *its* caller, `merge_trees()`, which then gives up by die()ing:
> 
>     Aborting
> 
> I think there is more than one fix necessary to truly address the issue: the underlying problem is that Git handles *committed* CR/LF really badly when the corresponding `.gitattributes` label the file as `text=auto`. In fact, those files are labeled as modified in `git status`. If you change the line endings of them, they are labeled as modified in `git status`. And after a `git reset --hard`, they are *still* labeled as modified in `git status`.
This is related to the normalization feature of Git:
https://www.kernel.org/pub/software/scm/git/docs/gitattributes.html
  *       text=auto
This ensures that all files that Git considers to be text will have normalized
(LF) line endings in the repository.

The normalization feature has 2 consequences:
a) - Files will get normalized at the next commit,
     Line endings of the changed lines are normalized
     Line endings of unchanged lines are normalized
b) - Not normalized files will get normalized (at the next commit),
    even if they are unchanged otherwise.


As Git knows (* text=auto), that files are normalized at the next commit,
they will change in the repo, and they are marked as changed already now.
This is by design.

The normalization has been disabled for core.autocrlf = true in commit
fd6cce9e (Eyvind Bernhardsen   2010-05-19 22:43:10 +0200  207) 			 * This is the
new safer autocrlf handling.
(See convert.c)

I'm in the mood to propose a patch that disables/suppresses the normalization
even for "* text=auto", if a file has CRLF in the repo.
This would make core.autocrlf = true do the same as "* text=auto".

I'm nearly sure, that this change would break things for some users,
and improve for others.

Currently t0027 tests this behavior, and as soon as we have the new
NNO tests establish, I will propose some cleanups in convert.c
(without change of behavour), and later to make
core.autocrlf = true
to do the same as
* text=auto











> 
> I will try to make some time to continue to work on this later today, but in the meantime I would be relatively happy if we could introduce that gentle flag. It is really a very gentle patch, after all, much gentler than reverting to the heavy-handed spawning of `merge-recursive`.
> 
> Ciao,
> Dscho
