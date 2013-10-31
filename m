From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/16] pull: cleanup documentation
Date: Thu, 31 Oct 2013 13:27:11 -0700
Message-ID: <xmqqr4b1425c.fsf@gitster.dls.corp.google.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-4-git-send-email-felipe.contreras@gmail.com>
	<xmqqiowd71kv.fsf@gitster.dls.corp.google.com>
	<CAMP44s3AKnZUJy0O0Hg+G=ER2bRn1nHMBeoJQ=ugCzO4d2WZ-g@mail.gmail.com>
	<xmqqob655kqi.fsf@gitster.dls.corp.google.com>
	<CAMP44s1-pVDoLrEC9m0J+fRCxnvMb+P0ANMxS7vzBhFub_Yv6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 21:27:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbypr-0004h9-JZ
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 21:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598Ab3JaU1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 16:27:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36015 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368Ab3JaU1P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 16:27:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 839F24EEE4;
	Thu, 31 Oct 2013 16:27:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/U69XKYrFP01zLPeRqapkx12n9c=; b=vUJhK4
	8ABbVNaeHzQLEbl7JyNJ9cDOwtwgTNwWuQpbVX7xsWC0D6qOv/istm1E2vuBRWY7
	Gu3PiL/gwb3ndvnahTuX5uQW8fvpR7I34GQXYuRWmh3rxL3KATrAGbELaTEh9mfL
	7Y8o5RvfIJ9ILGckGLiCGsaOUsM3Hc4qyh4ak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ib3T7rlJ7dEPezvR35H313FSjQ3dMAzX
	KFxCzvU8tRY6D0Wq74Yn7fJs5dSRFdRMnLO6938S/uKfXJSvYf7NbAlsYX3YwlAF
	BGCIIt8n6E+JL/pT5dciOZ5i9gnEgwfOEln4HLVSibkZmZ5U2nD4tee9UVcS3mX8
	z/axl2HU/SI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7674E4EEE3;
	Thu, 31 Oct 2013 16:27:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C91514EEE1;
	Thu, 31 Oct 2013 16:27:13 -0400 (EDT)
In-Reply-To: <CAMP44s1-pVDoLrEC9m0J+fRCxnvMb+P0ANMxS7vzBhFub_Yv6Q@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 31 Oct 2013 13:51:42 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D3C82FE8-426A-11E3-A190-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237177>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Oct 31, 2013 at 1:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> On Thu, Oct 31, 2013 at 12:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>>> --- a/Documentation/git-pull.txt
>>>>> +++ b/Documentation/git-pull.txt
>>>>> @@ -39,7 +39,7 @@ Assume the following history exists and the current branch is
>>>>>  "`master`":
>>>>>
>>>>>  ------------
>>>>> -       A---B---C master on origin
>>>>> +       A---B---C origin/master
>>>>>        /
>>>>>      D---E---F---G master
>>>>>  ------------
>>>>
>>>> This change is wrong; the illustration depicts the distributed world
>>>> (i.e. a fetch has not happened yet).
>>>
>>> That is an irrelevant implementation detail, specially at this high
>>> level. In the user's mind origin/master means master on origin.
>>
>> You are wrong.  In the user's mind, origin/master means the commit
>> that used to be at master on origin, and the point of this
>> illustration is to make them understand that they live in a
>> distributed world, where their last observation will go stale over
>> time.
>
> Wrong. That would make sense in 'git fetch', but here the point of the
> illustration is to make them understand what 'git pull' will do,
> namely a merge.
>
> Which refs point to C at which points in time irrelevant information,
> the user wants to know that 'git pull' will create a merge.

Merge with what, and how do the users know what will be merged?

Think.

The users need to learn that origin/master they were told to use
with "git log origin/master.." etc. trails reality, "git fetch" is
how they can get them in sync, and the reason they do not need to
run "git fetch" separately when they "git pull" is because it is run
for them internally.

That is what the illustration and the paragraph that follows teach
them.

I've said enough on this.
