From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 0/2] Reinstate the helpful message when `git pull
 --rebase` fails
Date: Sat, 10 Oct 2015 18:05:52 +0200
Message-ID: <56193760.5010307@web.de>
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
X-From: git-owner@vger.kernel.org Sat Oct 10 18:06:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zkwew-000166-HH
	for gcvg-git-2@plane.gmane.org; Sat, 10 Oct 2015 18:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbbJJQGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2015 12:06:05 -0400
Received: from mout.web.de ([212.227.15.4]:52831 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbbJJQGB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2015 12:06:01 -0400
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0Lu1Be-1amMAV20zm-011PmG; Sat, 10 Oct 2015 18:05:57
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <d89d595a223508896db9303c901e7c30@dscho.org>
X-Provags-ID: V03:K0:iMGKR3DOYdmDFPkatIJshUpSu4oSSt14dG/q4H+nFsV5jq/nufD
 B1O6wFxv1jhPHdegUuY0lXoGR3k3c3jK9pCO/G+wVqJAFISTu8O4s0txU28z+/eFDiDi+TB
 lnLYC094ypT9UMEXv3DoFWp3WVUmZnghM9wk+NTZkr2x1gb+D3NrexM+GbDq8EEbds91ZX8
 G+58fyXIvvyYaSo4MlMig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B/FSOwqpbzQ=:Rp25kMEkPve3CoDzHeO2hp
 Zk1RT3gDeI/P68zN8OMo/62ABUhV7DTU2IsDRm9c+oDdV0o3GdILjUMWK2+LE/F1gmAZLx+9T
 tDHgcOQN7Acg++O34blG1kcc0CPfQWUzZ6GbBIjYz1Jmx7g44tT68xEy1TNfeuhMFXbvsn/jg
 PEwWAuk41C7j+V/4BLNyWwy4a0yTRKniPOWN+fiD2aiPwiAl+MAQ+mSNCv0wu4rRtrdes+8Qn
 XespxCRbc9LocrFaeaZzltelgQbQPoQRMDl5TnTSuvCTkHQEQqc33i4lkyD9meM2XZ16KKwft
 WlLcq9fwGokjnG5yqs4NY7MbcIIdT/UdY6ds275ZL0OnAMOYinDyvmqWF/FgtiS9fGi8zKw6e
 TYHJg90D6sdTXgEAlSU/bfuSah07a/o6Pt+QNyp548Uc9t+z1TskNqKx3xibYZAJt/LtXQlCw
 Ra01uu06vL/up15IryeooJIJCBrVQE263dEYMsGAMjj8Z+Zj9SJB/jSMfrYxPWsQWrYQqdPLF
 KD/A3tfIICGV6cgZgmCm8OZoRFj8jGHu9JhPM5ifpZSGG0P3H5pBSKM1K39CJ0uCFEOITtSd0
 VPI7LX1fepXdJ7Y5n1Bo1yWIIu/hi44jXzor5RoLWypa38UDx6noRb+L6f87GRNytUqSVOGkl
 drcPxRXpEhU6jyfcXzBVmyu+IrnUo6lRAfVh7kR3AjSzp5ReoQ8TtxPFmelng5xk8oHzcS7r3
 6R1dgZEkTa1TIIwgLSjrHAekAMCBmdksDXsmgycRRpFXwQPRWmm4Z+Rbdqo2Tx3bIAndUYYS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279323>

On 09.10.15 12:11, Johannes Schindelin wrote:
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

One other question:
Is it good to mix 2 different things in one test case ?
"shows the helpful advice when failing" is one thing,
and the problematic CRLF handling another.

Does it make sense to simply create "really-modified" file to test the helpful advice ?

And may be another one witch test the CRLF handling, (may be)
