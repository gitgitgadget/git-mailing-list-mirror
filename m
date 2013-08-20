From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Should "git apply --check" imply verbose?
Date: Tue, 20 Aug 2013 16:19:31 -0400
Message-ID: <5213CF53.5010306@windriver.com>
References: <5213873A.6010003@windriver.com> <xmqqioz06y9m.fsf@gitster.dls.corp.google.com> <5213B95D.3040409@windriver.com> <xmqqzjsc5ggp.fsf@gitster.dls.corp.google.com> <20130820151554.6afbcb7f@gandalf.local.home> <7v7gfgkuyo.fsf@alter.siamese.dyndns.org> <20130820155433.217abb3e@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
X-From: git-owner@vger.kernel.org Wed Aug 21 02:52:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBwf7-0005eg-GG
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 02:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023Ab3HUAwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 20:52:33 -0400
Received: from mail7.windriver.com ([128.224.252.3]:55344 "EHLO
	mail7.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab3HUAwc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 20:52:32 -0400
X-Greylist: delayed 16220 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Aug 2013 20:52:31 EDT
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
	by mail7.windriver.com (8.14.5/8.14.3) with ESMTP id r7KKJOZM026637
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 20 Aug 2013 16:19:25 -0400 (EDT)
Received: from [128.224.146.65] (128.224.146.65) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.2.342.3; Tue, 20 Aug 2013
 13:19:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <20130820155433.217abb3e@gandalf.local.home>
X-Originating-IP: [128.224.146.65]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232674>

On 13-08-20 03:54 PM, Steven Rostedt wrote:
> On Tue, 20 Aug 2013 12:45:03 -0700
> Junio C Hamano <gitster@pobox.com> wrote:
> 
>> Steven Rostedt <rostedt@goodmis.org> writes:
>>
>>>> I do not think it is necessarily a good idea to assume that people
>>>> who are learning "git apply" know how GNU patch works.
>>>
>>> Linus told me that "git apply" was basically a replacement for patch.
>>> Why would you think it would not be a good idea to assume that people
>>> would not be familiar with how GNU patch works?
>>
>> The audience of Git these days are far more widely spread than the
>> kernel circle.  I am not opposed to _helping_ those who happen to
>> know "patch", but I was against a description that assumes readers
>> know it, i.e. making it a requirement to know "patch" to understand
>> "apply".
> 
> Patch is used by much more than just the kernel folks ;-)  I've been
> using patch much longer than I've been doing kernel development.
> 
> 
>>
>>>> But I do agree that the description of -v, --verbose has a lot of
>>>> room for improvement.
>>>>
>>>> 	Report progress to stderr. By default, only a message about the
>>>> 	current patch being applied will be printed. This option will cause
>>>> 	additional information to be reported.
>>>>
>>>> It is totally unclear what "additional information" is reported at
>>>> all.
>>
>> In other words, your enhancement to the documentation could go like:
>>
>> 	... By default, ... With this option, you will additionally
>> 	see such and such and such in the output (this is similar to
>> 	what "patch --dry-run" would give you).  See the EXAMPLES
>> 	section to get a feel of how it looks like.
>>
>> and I would not be opposed, as long as "such and such and such" are
>> written in such a way that the reader does not have to have a prior
>> experience with GNU patch in order to understand it.
>>
>> Clear?
> 
> Looks good to me. Paul, what do you think?

Yep, I'll write something up tomorrow which loosely matches the above.

Thanks,
Paul.
--

> 
> Thanks,
> 
> -- Steve
> 
