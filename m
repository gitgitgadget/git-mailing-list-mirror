From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Reinstate the helpful message when `git pull
 --rebase` fails
Date: Fri, 09 Oct 2015 11:50:29 +0200
Organization: gmx
Message-ID: <4a99ca8724b3604cbbec48d559e134fd@dscho.org>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
 <xmqq612grhg7.fsf@gitster.mtv.corp.google.com>
 <CACRoPnSPVMt+FtK6bwfa7Z3jBheTEkBnhU+B7qL8JrAsSmAmkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Brendan Forster <shiftkey@github.com>,
	Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 11:50:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkUKD-0001iu-3R
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 11:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965331AbbJIJuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2015 05:50:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:58614 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965328AbbJIJuf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2015 05:50:35 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LdHLB-1aS6at2f0D-00iRGQ; Fri, 09 Oct 2015 11:50:30
 +0200
In-Reply-To: <CACRoPnSPVMt+FtK6bwfa7Z3jBheTEkBnhU+B7qL8JrAsSmAmkQ@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:QsvRFfX23dH6zufiIA4lvPCoX5REbaraaFxrdMf4QcLXJnRCwdd
 o23KBhCsvFGl9D2OikfBJpDZtK7v0ROy8HlWI8lsZR2JqCncxD6PVRsl3Ye7p6g6SsGdaFb
 XOl68xEifGbkLj4saaLgsLdRwjLE4Kf4aIh8OOsdKcDc732M6mIBBqtQMrIFE+S2REudvdz
 zuM9WqSVwvveex5Jz8Abg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:76siKdL/FKE=:x1P09F4R/hh5NQKJXjsW5e
 KvW/GgIrn4EXw79AwMKvFhdBGKw4a9oqPB9FRGkVAKvUH2/lb38ZmPWsMkaPQyY8JF2EUy2UZ
 WpFsdNOVQsEAq/LgjCakb0xPrHC3q8BFyH2JMvh+t9N3YYTOizHaKRXs35fkUIKBWzEItq/hH
 kBpjoYIabUB0ANSC1W4qsfTqdLGPrQeClSC/yo4WIIOuT6cgOkjqtvpW6S96JXKBVt3+dTMVh
 cFQM8TBIN3/7WKvSVWs1lD+kDJxxWDxHuF2yNOkggJL1jfX+xX5SHHKL+DuXSO0ibqlNiL+B7
 fGTQCSuUny9Gzm82+CfWXZrP4+hugXHKFkXO2osfqd+tCZCNhJBzhnP89bqHSPsDkRO8d/akr
 8Q4259Y6PVglu8bpVg+iMLRx5cTqyWkWJuEvWcKF9+3mE3wIRxdMxUsBR7fxsy97HF+WVV7Pt
 mOboen5JrLuFBIymv2qjPRSA3W8pY2vJV2+MgvjTzW+t74lLLykrNWb3DDKqVjcaM1ZcW89NS
 H9DvioyIo7+8EgnxNVlFJpjCDrkC5iKqi2e9AgoS1pCwvRFs1vRlSHGC1owXqZOH3LhvqK5b8
 4QmUa9NPCZRk2T5EAzb5BOs8Vr4yRI5f8FJ/BTuz3Ta5ZzU4Fvm5MtyurJOfTbRM1tes8D9R/
 6R8LimEQWvbfKgEny4lzBPVCjKkuxN6rFSEXNjL77+s+lrPUNLRoFVEa5QrxlXoeaCrVdckbV
 sFcQR94B01AE1Pwg5BLGlTVNs4Et+55M9ZvF6Q1XHbNQng2ABuycBjVF8HSphP49aQNQrDgm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279304>

Hi Junio & Paul,

On 2015-10-09 03:40, Paul Tan wrote:
> On Fri, Oct 9, 2015 at 8:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
>>> Brendan Forster noticed that we no longer see the helpful message after
>>> a failed `git pull --rebase`. It turns out that the builtin `am` calls
>>> the recursive merge function directly, not via a separate process.
>>>
>>> But that function was not really safe to be called that way, as it
>>> die()s pretty liberally.
> 
> I'm not too familiar with the merge-recursive.c code, but I was under
> the impression that it only called die() under fatal conditions. In
> common use cases, such as merge conflicts, it just errors out and the
> helpful error message does get printed. Is there a reproduction recipe
> for this?

Yes. Sorry, I should have added that as part of the patch series. Actually, I should have written it *before* making those patches. Because it revealed that the underlying problem is completely different: *Normally* you are correct, if `pull --rebase` fails with a merge conflict, the advice is shown.

The problem occurs with CR/LF.

I have a reproducer and will wiggle it down to a proper test case.

>> If that is the case, I'd thinkg that we'd prefer, as a regression
>> fix to correct "that", i.e., let recursive-merge die and let the
>> caller catch its exit status.
> 
> We could do that, but I don't think it would be worth the overhead to
> spawn an additional process for every patch just to print an
> additional message should merge_recursive() call die().

I would hope that we do not go that direction! The benefit of making `am` a builtin was to *avoid* spawning, after all. Let's not make the experience for Windows users *worse* again.

> Instead, stepping back a bit, I wonder if we can extend coverage of
> the helpful message to all die() calls when running git-am. We could
> just install a die routine with set_die_routine() in builtin/am.c.
> Then, should die() be called anywhere, the helpful error message will
> be printed as well. fast-import.c and http-backend.c seem to do this.

This looks more like a work-around to me. In general, I think it is not really a good idea to treat each and every code path as if it is safe to die(). That would just preclude the code from being used as a library function.

But it looks more and more as if the problem lies with the CR/LF handling of Git. Will keep you posted.

Ciao,
Dscho
