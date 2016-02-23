From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree info
Date: Tue, 23 Feb 2016 15:49:30 -0600
Message-ID: <87bn77hzbp.fsf@x220.int.ebiederm.org>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
	<1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
	<xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
	<20160223014741.GA21025@wfg-t540p.sh.intel.com>
	<xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
	<20160223091740.GA3830@wfg-t540p.sh.intel.com>
	<xmqq1t8319z0.fsf@gitster.mtv.corp.google.com>
	<87d1rnjil4.fsf@x220.int.ebiederm.org>
	<xmqqtwkzyxkv.fsf@gitster.mtv.corp.google.com>
	<3FAB2030-8106-4114-99A4-B04A8A0D22FB@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Fengguang Wu <fengguang.wu@intel.com>,
	Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Feb 23 23:01:20 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aYL1D-000683-2f
	for glk-linux-kernel-3@plane.gmane.org; Tue, 23 Feb 2016 23:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126AbcBWWBG (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Feb 2016 17:01:06 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:49397 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851AbcBWWA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Feb 2016 17:00:59 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
	by out01.mta.xmission.com with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.82)
	(envelope-from <ebiederm@xmission.com>)
	id 1aYL0m-00056E-9R; Tue, 23 Feb 2016 15:00:52 -0700
Received: from 67-3-245-179.omah.qwest.net ([67.3.245.179] helo=x220.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.82)
	(envelope-from <ebiederm@xmission.com>)
	id 1aYL0j-0000Zg-Pi; Tue, 23 Feb 2016 15:00:52 -0700
In-Reply-To: <3FAB2030-8106-4114-99A4-B04A8A0D22FB@zytor.com> (H. Peter
	Anvin's message of "Tue, 23 Feb 2016 12:46:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-XM-AID: U2FsdGVkX18pgcUct47AmNYdvNGPuCxuD6P0YTgqwjs=
X-SA-Exim-Connect-IP: 67.3.245.179
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
	DCC_CHECK_NEGATIVE,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
	XMNoVowels,XMSubLong autolearn=disabled version=3.4.0
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 TVD_RCVD_IP Message was received from an IP address
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;"H. Peter Anvin" <hpa@zytor.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2009 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 3.7 (0.2%), b_tie_ro: 2.7 (0.1%), parse: 1.42 (0.1%),
	extract_message_metadata: 38 (1.9%), get_uri_detail_list: 7 (0.3%),
	tests_pri_-1000: 8 (0.4%), tests_pri_-950: 1.96 (0.1%), tests_pri_-900: 1.67
	(0.1%), tests_pri_-400: 51 (2.5%), check_bayes: 49 (2.4%), b_tokenize: 20
	(1.0%), b_tok_get_all: 13 (0.7%), b_comp_prob: 7 (0.3%), b_tok_touch_all: 3.3
	(0.2%), b_finish: 0.81 (0.0%), tests_pri_0: 900 (44.8%),
	check_dkim_signature: 0.92 (0.0%), check_dkim_adsp: 5 (0.3%), tests_pri_500:
	997 (49.7%), poll_dns_idle: 982 (48.9%), rewrite_mail: 0.00 (0.0%)
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Wed, 24 Sep 2014 11:00:52 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287132>

"H. Peter Anvin" <hpa@zytor.com> writes:

> On February 23, 2016 12:35:12 PM PST, Junio C Hamano <gitster@pobox.com> wrote:
>>ebiederm@xmission.com (Eric W. Biederman) writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> It is valuable for a testing organization to say "We tested this
>>>> series on top of version X.  We know it works, we have tested on a
>>>> lot more hardware than the original developer had, we know this is
>>>> good to go."  It is a valuable service.
>>>>
>>>> But that is valuable only if version X is still relevant, isn't it?
>>>>
>>>> Is the relevance of a version something that is decided by a
>>>> developer who submits a patch series, or is it more of an attribute
>>>> of the project and where the current integration is happening?
>>>> Judging from the responses from Dan to this thread, I think the
>>>> answer is the latter, and for the purpose of identifying the
>>>> relevant version(s), the project does not even care about the exact
>>>> commit, but it wants to know more about which branch the series is
>>>> targetted to.
>>>>
>>>> With that understanding, I find it hard to believe that it buys the
>>>> project much for the "base" commit to be recorded in a patch series
>>>> and automated testing is done by applying the patches to that exact
>>>> commit, which possibly is no-longer-relevant, even though it may
>>>> help shielding the testing machinery from "you tested with a wrong
>>>> version" complaints.
>>>>
>>>> Isn't it more valuable for the test robot to say "this may or may
>>>> not have worked well with whatever old version the patch series was
>>>> based on, but it no longer is useful to the current tip of the
>>>> 'master'"?  If you consider what benefit the project would gain by
>>>> having such a robot, that is the conclusion I have to draw.
>>>>
>>>> So I still am not convinced that this "record base commit" is a
>>>> useful thing to do.
>>>
>>> So I don't know what value this has to the git project.
>>
>>Oh, don't worry, I wasn't talking about value this may have to the
>>Git project at all.  "The value to the project" I mentioned in my
>>response was all about the value to the kernel project.
>>
>>> The value of Fengguag's automated testing to the kernel project is to
>>> smoke out really stupid things.
>>
>>I'll snip your bullet points, but as I wrote, I do understand the
>>value of prescreening test.
>>
>>What I was questioning was what value it gives to that testing to
>>use "the developer based this patch on this exact commit" added to
>>each incoming patch, and have Fengguag's testing machinery test a
>>patch with a base version that may no longer be relevant in the
>>context of the project.  Compared to that, wouldn't "this no longer
>>applies to the branch the series targets" or "this still applies
>>cleanly, but no longer compiles because the surrounding API has
>>changed" be much more valuable?
>>
>>In your other message, you mentioned the "index $old..$new" lines,
>>and it is possible to use them to find a tree that the patch cleanly
>>applies to, but it will not uniquely identify _the_ version the
>>patch submitter used.  IMHO, finding such _a_ tree from the recent
>>history of the branch that the patch targets and testing the patch
>>on top of that tree (as opposed to testing the patch in the exact
>>context the developer worked on) would give the project a better
>>value.
>
> Personally, as a maintainer, I would love to see the tree ID and
> ideally also the commit ID a series is based on.  The commit ID is in
> some ways less useful since it is non-recreatable (and therefore will
> never match for anything but the first patch of a series), but could
> be useful to the maintainer.
>
> As far as putting in a bunch of metainformation that has to be
> manually or semimanually obtained, there are a lot of issues with
> that, as it way too easily turns into wrong information or potential
> information leaks that might make corporate contributors
> uncomfortable.

I would really love to hear from Fengguag about where this is a
practical problem, but I expect the flock of x86 topic tress is probably
one of those cases where there are problems for automation to figure out
which tree a patch applies to in practice.  The mailing list for x86
patches is linux-kernel.  Even if you filter by x86@kernel.org to detect
it is an x86 patch which topic branch a patch goes to was not clear to
me from a quick skim of recent lkml x86 patches.

So I could really respect a patch header line that said:
tree abcdef0123456789...0123456789abcdef

Where the numbers where the truncated tree hash before and after a patch
was applied.  That would seem to give a little bit of extra sanity
checking in the application of git diffs as well.

Eric
