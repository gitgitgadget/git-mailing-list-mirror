From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: git diff annoyance / feature request
Date: Thu, 25 Aug 2011 14:58:38 -0700
Message-ID: <4E56C58E.4080905@panasas.com>
References: <4E569F10.8060808@panasas.com> <7vippljkxs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 23:58:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwhwr-00049v-3O
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 23:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561Ab1HYV6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 17:58:48 -0400
Received: from natasha.panasas.com ([67.152.220.90]:48540 "EHLO
	natasha.panasas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650Ab1HYV6s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 17:58:48 -0400
Received: from zenyatta.panasas.com (zenyatta.int.panasas.com [172.17.28.63])
	by natasha.panasas.com (8.13.1/8.13.1) with ESMTP id p7PLwk6F003308;
	Thu, 25 Aug 2011 17:58:46 -0400
Received: from [172.17.132.75] (172.17.132.75) by zenyatta.int.panasas.com
 (172.17.28.63) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 25 Aug
 2011 17:58:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <7vippljkxs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180128>

On 08/25/2011 01:27 PM, Junio C Hamano wrote:
> Boaz Harrosh <bharrosh@panasas.com> writes:
> 
>> I mean. The label "try_again" is not at all unique in my file. As a
>> reader I would like to see where is that code going to. The function
>> name is a unique file identifier that tells me exactly where the change
>> is going. The label is not. (It's not freaking BASIC)
>>
>> I bet all this was just inherited from diff. Would it be accepted if
>> I send a patch to fix it? What you guys think a goto label makes any
>> sense at all?
> 
> The default tries to mimic what GNU used to do when we added the feature.
> 
> The diff.*.xfuncname configuration variable is there exactly for people
> like you to tweak what we use for hunk headers. Please experiment with it
> and if you come up with a better set of patterns, people may want to copy
> it and use it themselves. we may even consider updating the built-in
> default with your patterns, once they got adopted by wider audiences.
> 

Thanks, I'll investigate it sounds very interesting.

> Personally, I would have to say that the source wouldn't be using too many
> labels with the same name for this behaviour to be problematic, especially
> if it is not freaking BASIC ;-), so...

The Linux Kernel is full of "goto out" or "goto err" its a common error handling
practice. I actually like it because it taps onto a known pattern.

Now the patch tell me @@@ lable out: !! that's not very useful I would say

Thanks I'm sure I can shape it up the way I like it
Boaz
